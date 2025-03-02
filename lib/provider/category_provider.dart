import 'package:flutter/material.dart';
import 'package:week5/db/category/category_db.dart';
import 'package:week5/models/category/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> incomeCategoryList = [];
  List<CategoryModel> expenseCategoryList = [];

  Future<void> refreshCategory() async {
    final allCategory = await CategoryDb.instance.refreshUi();
    incomeCategoryList.clear();
    expenseCategoryList.clear();
    for (int i = 0; i < allCategory.length; i++) {
      if (allCategory[i].type == CategoryType.income) {
        incomeCategoryList.add(allCategory[i]);
      } else {
        expenseCategoryList.add(allCategory[i]);
      }
    }

    notifyListeners();
  }

  Future<void> addCategory(CategoryModel value) async {
    await CategoryDb.instance.insertCatogory(value);
    refreshCategory();
  }
}
