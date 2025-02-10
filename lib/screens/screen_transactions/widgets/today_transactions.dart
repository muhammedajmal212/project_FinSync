import 'package:flutter/material.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/models/transaction/transaction_model.dart';
import 'package:week5/screens/screen_transactions/widgets/aleart_dialouge_widget.dart';
import 'package:week5/screens/screen_transactions/widgets/edit_screen.dart';
import 'package:week5/screens/screen_transactions/widgets/slide_widget.dart';
import 'package:week5/widgets/transactions_card.dart';

class TodayTransactions extends StatelessWidget {
  final bool isIncomeSelected;
  const TodayTransactions({super.key, required this.isIncomeSelected});

  @override
  Widget build(BuildContext context) {
    DateTime todayDate = DateTime.now();
    todayDate = DateTime(todayDate.year, todayDate.month, todayDate.day);
    List<TransactionModel> allTodayList = [];
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.allTransactionList,
      builder: (context, List<TransactionModel> transactions, _) {
        if (isIncomeSelected == true) {
          allTodayList = transactions.where(
            (element) {
              return element.type == CategoryType.income &&
                  element.date == todayDate;
            },
          ).toList();
        } else {
          allTodayList = transactions.where(
            (element) {
              return element.type == CategoryType.expense &&
                  element.date == todayDate;
            },
          ).toList();
        }
        allTodayList = allTodayList.reversed.toList();
        return ListView.builder(
          itemCount: allTodayList.length,
          itemBuilder: (ctx, index) {
            final transaction = allTodayList[index];
            return SlideWidget(
              id: transaction.id,
              deleteFunction: (delete) {
                deleteTodayransaction(transaction, context);
              },
              editFunction: (edit) {
                editTodayTransaction(transaction, context);
              },
              child: TransactionsCard(transactionModel: transaction),
            );
          },
        );
      },
    );
  }

  void editTodayFunction(TransactionModel transaction, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AleartDialougeWidget(
        transactionModel: transaction,
        functoin: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => EditScreen(oldTransactionModel: transaction),
            ),
          );
        },
      ),
    );
  }

  void editTodayTransaction(
      TransactionModel transaction, BuildContext context) {
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

  void deleteTodayransaction(
      TransactionModel transaction, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AleartDialougeWidget(
          text: "Do you Want To Delete",
          transactionModel: transaction,
          functoin: () {
            TransactionDb.instance.deleteTransation(transaction);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
