import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week5/models/category/category_model.dart';

const categoryDbName = "categorydbname";
abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCatogory(CategoryModel value);
  Future<void> deleteCategory(String id);
}

class CategoryDb implements CategoryDbFunction {
  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);

  CategoryDb.internal();
  static CategoryDb instance = CategoryDb.internal();
  factory CategoryDb() {
    return instance;
  }
  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDb = await Hive.openBox<CategoryModel>(categoryDbName);
    return categoryDb.values.toList();
  }

  @override
  Future<void> insertCatogory(CategoryModel value) async {
    final categoryDb = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDb.put(value.id, value);
    await refreshUi();
  }

  Future<void> refreshUi() async {
    final allCategories = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(
      allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryList.value.add(category);
        } else {
          expenseCategoryList.value.add(category);
        }
      },
    );
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final categoryDb = await Hive.openBox<CategoryModel>(categoryDbName);
    await categoryDb.delete(categoryID);
    refreshUi();
  }
}
