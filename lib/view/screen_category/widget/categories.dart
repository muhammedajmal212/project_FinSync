import 'package:flutter/material.dart';

import 'package:week5/model/category/category_model.dart';

import 'package:week5/view/screen_category/widget/delete_category_popup.dart';

class Categories extends StatelessWidget {
  Categories({super.key, required this.categoriesList, this.function});
List<CategoryModel> categoriesList = [];
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: categoriesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (ctx, index) {
          final value = categoriesList[index];
          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => DeleteCategoryPopup(
                  id: value.id,
                ),
              );
            },
            child: Card(
              color: const Color(0xFFCCE5E3),
              elevation: 10,
              child: Center(
                child: Text(
                  value.name,
                  style: const TextStyle(letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
