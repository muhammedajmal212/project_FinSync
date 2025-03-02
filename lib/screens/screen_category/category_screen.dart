import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week5/db/category/category_db.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/provider/category_provider.dart';
import 'package:week5/screens/screen_category/widget/alert_widget.dart';
import 'package:week5/screens/screen_category/widget/categories.dart';
import 'package:week5/widgets/add_button.dart';
import 'package:week5/widgets/app_radio_button.dart';
import 'package:week5/widgets/expense_text.dart';
import 'package:week5/widgets/income_text.dart';

final TextEditingController categorycontroller = TextEditingController();

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

List<String> options = ["income", "expense"];

class _CategoryScreenState extends State<CategoryScreen> {
  String currentOption = "income";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).refreshCategory();
    super.initState();
    currentOption = options[0];
  }

  @override
  void dispose() {
    categorycontroller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Category Screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppRadioButton(
                  groupValue: currentOption,
                  newvalue: options[0],
                  title: const IncomeText(),
                  onChanged: (value) {
                    setState(
                      () {
                        currentOption = value;
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: AppRadioButton(
                  groupValue: currentOption,
                  newvalue: options[1],
                  title: const ExpenseText(),
                  onChanged: (value) {
                    setState(
                      () {
                        currentOption = value;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child:
                Consumer<CategoryProvider>(builder: (ctx, categoryconsumer, _) {
              final vasu = currentOption == options[0]
                  ? categoryconsumer.incomeCategoryList
                  : categoryconsumer.expenseCategoryList;
              return Categories(categoriesList: vasu);
            }),
          ),
        ],
      ),
      floatingActionButton: AddButton(
        ontap: () {
          showDialog(
            context: context,
            builder: (context) => AlertWidget(
              function: () {
                addCategory(context);
              },
              categorycontroller: categorycontroller,
              text: currentOption == options[0]
                  ? "Add New Income Category"
                  : "Add New Expense Category",
              formKey: _formKey,
              validatorFunction: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "category canot be empty";
                }
                String categoryname = value.trim().toLowerCase();
                final existingIncomeCategories =
                    Provider.of<CategoryProvider>(context, listen: false)
                        .incomeCategoryList
                        .map((e) => e.name)
                        .toList();

                final existingExpenseCategories =
                    Provider.of<CategoryProvider>(context, listen: false)
                        .incomeCategoryList
                        .map((e) => e.name)
                        .toList();

                if (currentOption == options[0] &&
                    existingIncomeCategories.contains(categoryname)) {
                  return "Category Already Exists ";
                }
                if (currentOption == options[1] &&
                    existingExpenseCategories.contains(categoryname)) {
                  return " Category Already Exists";
                }
                return null;
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> addCategory(context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final newCategory = CategoryModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          name: categorycontroller.text.toLowerCase(),
          type: currentOption == options[0]
              ? CategoryType.income
              : CategoryType.expense);
              Provider.of<CategoryProvider>(context,listen: false).addCategory(newCategory);
      // await CategoryDb().insertCatogory(newCategory);
      categorycontroller.clear();
      Provider.of<CategoryProvider>(context, listen: false).refreshCategory();

      Navigator.of(context).pop();
    }
  }
}
