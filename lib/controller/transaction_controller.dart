import 'package:flutter/material.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/model/category/category_model.dart';
import 'package:week5/model/transaction/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  num totalIncome = 0;
  num totalExpense = 0;
  num currentBalance = 0;
  List<TransactionModel> allTransactionlist = [];
   

  Future<void> refreshTransaction() async {
    final newList = await TransactionDb.instance.refreshUi();
    allTransactionlist.clear();
    allTransactionlist.addAll(newList);
    totalIncome = 0;
    totalExpense = 0;
    currentBalance = 0;
    for (int i = 0; i < allTransactionlist.length; i++) {
      if (allTransactionlist[i].type == CategoryType.income) {
        totalIncome = totalIncome + allTransactionlist[i].amount;
      } else {
        totalExpense = totalExpense + allTransactionlist[i].amount;
      }
    }
    currentBalance = totalIncome - totalExpense;
    notifyListeners();
  }
  Future<void> addTransaction(TransactionModel transactionModelValue) async {
   await TransactionDb.instance.addTransaction(transactionModelValue);
   refreshTransaction();
  }
}
