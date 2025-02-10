import 'package:flutter/material.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/screens/screen_transactions/widgets/aleart_dialouge_widget.dart';
import 'package:week5/screens/screen_transactions/widgets/edit_screen.dart';
import 'package:week5/screens/screen_transactions/widgets/slide_widget.dart';
import 'package:week5/widgets/transactions_card.dart';

import '../../../models/transaction/transaction_model.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key, required this.isIncomeSelected});
  final bool isIncomeSelected;

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  List<TransactionModel> allSampleList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: TransactionDb.instance.allTransactionList,
            builder: (context, List<TransactionModel> transactions, _) {
              if (widget.isIncomeSelected == true) {
                allSampleList = transactions.where(
                  (element) {
                    return element.type == CategoryType.income;
                  },
                ).toList();
              } else {
                allSampleList = transactions.where(
                  (element) {
                    return element.type == CategoryType.expense;
                  },
                ).toList();
              }
              allSampleList = allSampleList.reversed.toList();
              return ListView.builder(
                itemCount: allSampleList.length,
                itemBuilder: (ctx, index) {
                  final transaction = allSampleList[index];
                  return SlideWidget(
                    id: transaction.id,
                    editFunction: (edit) {
                      editAllFunction(transaction);
                    },
                    deleteFunction: (delete) {
                      deleteAllTransaction(transaction);
                    },
                    child: TransactionsCard(transactionModel: transaction),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void editAllFunction(TransactionModel transaction) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AleartDialougeWidget(
            transactionModel: transaction,
            functoin: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) =>
                      EditScreen(oldTransactionModel: transaction),
                ),
              );
            },
          );
        });
  }

  void deleteAllTransaction(TransactionModel transaction) {
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
        });
  }
}
