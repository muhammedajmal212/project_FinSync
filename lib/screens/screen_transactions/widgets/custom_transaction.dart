import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/models/transaction/transaction_model.dart';
import 'package:week5/provider/transaction_provider.dart';
import 'package:week5/screens/screen_transactions/widgets/aleart_dialouge_widget.dart';
import 'package:week5/screens/screen_transactions/widgets/edit_screen.dart';
import 'package:week5/screens/screen_transactions/widgets/slide_widget.dart';
import 'package:week5/screens/transaction_adding_screen/widget.dart/date_form_field.dart';
import 'package:week5/widgets/transactions_card.dart';

class CustomTransaction extends StatefulWidget {
  final bool isIncomeSelected;
  const CustomTransaction({super.key, required this.isIncomeSelected});

  @override
  State<CustomTransaction> createState() => _CustomTransactionState();
}

class _CustomTransactionState extends State<CustomTransaction> {
  DateTime? newdate;

  List<TransactionModel> allCustomTransactionList = [];
  TextEditingController datecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateFormField(
          datecontroller: datecontroller,
          function: (p0) {
            selectDates(context);
          },
        ),
        Consumer<TransactionProvider>(
          builder: (context, value, child) {
            if (widget.isIncomeSelected == true) {
              allCustomTransactionList = value.allTransactionlist.where(
                (element) {
                  return element.type == CategoryType.income &&
                      element.date == newdate;
                },
              ).toList();
            } else {
              allCustomTransactionList = value.allTransactionlist.where(
                (element) {
                  return element.type == CategoryType.expense &&
                      element.date == newdate;
                },
              ).toList();
            }
            return Expanded(
              child: ListView.builder(
                itemCount: allCustomTransactionList.length,
                itemBuilder: (ctx, index) {
                  final transaction = allCustomTransactionList[index];
                  return SlideWidget(
                    id: transaction.id,
                    editFunction: (edit) {
                      editCustomTransaction(transaction);
                    },
                    deleteFunction: (delete) {
                      deleteCustomTransaction(transaction, context);
                    },
                    child: TransactionsCard(transactionModel: transaction),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }

  void selectDates(BuildContext context) async {
    newdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2029),
    );

    if (newdate == null) {
      return;
    } else {
      setState(
        () {
          datecontroller.text = newdate.toString().split(" ")[0];
        },
      );
    }
  }

  void editCustomTransaction(TransactionModel transaction) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AleartDialougeWidget(
          transactionModel: transaction,
          functoin: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => EditScreen(oldTransactionModel: transaction),
              ),
            );
          },
        );
      },
    );
  }

  void deleteCustomTransaction(
      TransactionModel transaction, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AleartDialougeWidget(
          text: "Do you Want To Delete",
          transactionModel: transaction,
          functoin: () {
            TransactionDb.instance.deleteTransation(transaction);
             Provider.of<TransactionProvider>(context,listen: false).refreshTransaction();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
