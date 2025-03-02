import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/models/transaction/transaction_model.dart';
import 'package:week5/provider/category_provider.dart';
import 'package:week5/provider/transaction_provider.dart';
import 'package:week5/screens/transaction_adding_screen/widget.dart/app_drop_down.dart';
import 'package:week5/screens/transaction_adding_screen/widget.dart/date_form_field.dart';
import 'package:week5/widgets/app_button.dart';
import 'package:week5/widgets/app_radio_button.dart';
import 'package:week5/widgets/app_text_form_field.dart';
import 'package:week5/widgets/expense_text.dart';
import 'package:week5/widgets/income_text.dart';

class EditScreen extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditScreen({super.key, required this.oldTransactionModel});

  final TransactionModel oldTransactionModel;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final List<String> groupvalue = ["income", "expense"];
  String currentType = "income";
  DateTime? selectedDate;
  String? categoryId;
  @override
  void initState() {
    super.initState();
    currentType = widget.oldTransactionModel.type == CategoryType.income
        ? "income"
        : "expense";
    selectedCategory = widget.oldTransactionModel.categoryModel;
    descriptionController.text = widget.oldTransactionModel.description;
    amountController.text = widget.oldTransactionModel.amount.toString();
    dateController.text =
        widget.oldTransactionModel.date.toString().split(" ")[0];
    selectedDate = widget.oldTransactionModel.date;
    categoryId = widget.oldTransactionModel.categoryModel!.id;
  }

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppRadioButton(
                        groupValue: currentType,
                        newvalue: groupvalue[0],
                        title: const IncomeText(),
                        onChanged: (value) => _updateTransactionType(value),
                      ),
                    ),
                    Expanded(
                      child: AppRadioButton(
                        groupValue: currentType,
                        newvalue: groupvalue[1],
                        title: const ExpenseText(),
                        onChanged: (value) => _updateTransactionType(value),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: AppDropDown(
                    selectedValue: selectedCategory,
                    onChanged: (value) {
                      setState(
                        () {
                          selectedCategory = value;
                        },
                      );
                    },
                    dropdownlist: getCategoryList(),
                    validatorKey: (value) =>
                        value == null ? "Select a category" : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppTextFormField(
                      textEditingController: descriptionController,
                      hintText: "Description (Optional)"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: AppTextFormField(
                      validatorKey: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Amount";
                        }
                        if (double.tryParse(value) == null) {
                          return "enter valid amount";
                        }
                        return null;
                      },
                      textEditingController: amountController,
                      hintText: "Amount"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: DateFormField(
                    function: (p0) {
                      selectDate(context);
                    },
                    datecontroller: dateController,
                    validatorKey: (value) {
                      if (dateController.text.isEmpty) {
                        return "Select Date";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: AppButton(
                      onTap: () {
                        setState(
                          () {
                            updateButton(widget.oldTransactionModel);
                          },
                        );
                      },
                      text: "Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateTransactionType(String value) {
    setState(
      () {
        widget.formKey.currentState?.reset();
        selectedCategory = null;
        currentType = value;
        List<CategoryModel> newList = getCategoryList();
        if (!newList.contains(selectedCategory)) {
          selectedCategory = null;
        }
      },
    );
  }

  List<CategoryModel> getCategoryList() {
    return currentType == "income"
        ? Provider.of<CategoryProvider>(context)
            .incomeCategoryList
            .toSet()
            .toList()
        : Provider.of<CategoryProvider>(context)
            .expenseCategoryList
            .toSet()
            .toList();

    // ? CategoryDb.instance.incomeCategoryList.value.toSet().toList()
    // : CategoryDb.instance.expenseCategoryList.value.toSet().toList();
  }

  void selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2029),
    );

    if (date == null) {
      return;
    } else {
      setState(
        () {
          dateController.text = date.toString().split(" ")[0];
          selectedDate = date;
        },
      );
    }
  }

  void updateButton(TransactionModel oldTransactionModel) async {
    if (widget.formKey.currentState?.validate() ?? false) {
      final description = descriptionController.text;
      final amount = amountController.text;
      final date = dateController.text;
      if (selectedCategory == null) {
        return;
      }
      if (description.isEmpty) {
        return;
      }
      if (amount.isEmpty) {
        return;
      }
      final integerAmount = double.tryParse(amount);
      if (integerAmount == null) {
        return;
      }
      if (date.isEmpty) {
        return;
      }

      final transaction = TransactionModel(
        categoryModel: selectedCategory!,
        description: descriptionController.text,
        date: selectedDate!,
        amount: double.parse(amountController.text),
        type: currentType == "income"
            ? CategoryType.income
            : CategoryType.expense,
      );
      await TransactionDb.instance
          .editTransactionSample(transaction, oldTransactionModel);
      Provider.of<TransactionProvider>(context, listen: false)
          .refreshTransaction();

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
