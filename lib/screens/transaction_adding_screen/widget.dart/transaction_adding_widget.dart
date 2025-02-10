import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:week5/db/category/category_db.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/models/transaction/transaction_model.dart';
import 'package:week5/screens/transaction_adding_screen/widget.dart/app_drop_down.dart';
import 'package:week5/screens/transaction_adding_screen/widget.dart/date_form_field.dart';
import 'package:week5/widgets/app_button.dart';
import 'package:week5/widgets/app_radio_button.dart';
import 'package:week5/widgets/app_text_form_field.dart';
import 'package:week5/widgets/expense_text.dart';
import 'package:week5/widgets/income_text.dart';

class TransactionAddingWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TransactionAddingWidget({
    super.key,
  });

  @override
  State<TransactionAddingWidget> createState() =>
      _TransactionAddingWidgetState();
}

class _TransactionAddingWidgetState extends State<TransactionAddingWidget> {
  final List<String> groupvalue = ["income", "expense"];
  String currentvalue = "income";
  DateTime? selectedDate;
  @override
  void initState() {
    currentvalue = groupvalue[0];
    super.initState();
  }

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  CategoryModel? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppRadioButton(
                  groupValue: currentvalue,
                  newvalue: groupvalue[0],
                  title: const IncomeText(),
                  onChanged: (value) {
                    setState(
                      () {
                        widget.formKey.currentState?.reset();
                        selectedCategory = null;
                        currentvalue = value;
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: AppRadioButton(
                  groupValue: currentvalue,
                  newvalue: groupvalue[1],
                  title: const ExpenseText(),
                  onChanged: (value) {
                    setState(
                      () {
                        widget.formKey.currentState?.reset();
                        selectedCategory = null;
                        currentvalue = value;
                      },
                    );
                  },
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
              dropdownlist: currentvalue == "income"
                  ? CategoryDb.instance.incomeCategoryList.value
                      .toSet()
                      .toList()
                  : CategoryDb.instance.expenseCategoryList.value
                      .toSet()
                      .toList(),
              validatorKey: (value) {
                if (value == null || value.id.isEmpty) {
                  return "Select Category";
                }
                return null;
              },
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
              keyboardType: TextInputType.number,
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
            child: AppButton(onTap: saveButton, text: "Save"),
          ),
        ],
      ),
    );
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

  void saveButton() async {
    if (widget.formKey.currentState?.validate() ?? false) {
      final description = descriptionController.text;
      final amount = amountController.text;
      final date = dateController.text;
      if (selectedCategory == null) {
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
      log(date);
      final transaction = TransactionModel(
        categoryModel: selectedCategory!,
        description: description,
        date: selectedDate!,
        amount: integerAmount,
        type: currentvalue == "income"
            ? CategoryType.income
            : CategoryType.expense,
      );
      await TransactionDb.instance.addTransaction(transaction);
      await TransactionDb.instance.refreshUi();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor:const Color(0xFF80CBC4),
          content: const Text(
            "Please fix the errors in the form",
            style: TextStyle(color: Color(0xFF2F2F2F)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(20),
        ),
      );
    }
  }
}
