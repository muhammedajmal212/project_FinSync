import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/models/transaction/transaction_model.dart';

const String transactionDbName = "TRANSACTION_DB_NAME";

abstract class TransactionDbFunctions {
  Future<void> refreshUi();
  Future<void> addTransaction(TransactionModel transactionModelValue);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransation(TransactionModel transaction);
  Future<void> editTransactionSample(TransactionModel newTransactionModel,
      TransactionModel oldTransactionModel);
}

class TransactionDb extends ChangeNotifier implements TransactionDbFunctions {
  ValueNotifier<num> totalIncome = ValueNotifier(0);
  ValueNotifier<num> totalExpense = ValueNotifier(0);
  ValueNotifier<num> currentBalance = ValueNotifier(0);
  ValueNotifier<List<TransactionModel>> allTransactionList = ValueNotifier([]);
  TransactionDb.internal();
  static TransactionDb instance = TransactionDb.internal();
  factory TransactionDb() {
    return instance;
  }
  @override
  Future<void> addTransaction(TransactionModel transactionModelValue) async {
    final transactionDb =
        await Hive.openBox<TransactionModel>(transactionDbName);
    await transactionDb.put(transactionModelValue.id, transactionModelValue);
    refreshUi();
  }

  @override
  Future<void> deleteTransation(TransactionModel transaction) async {
    await transaction.deleteTransaction();
    refreshUi();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final transactionDb =
        await Hive.openBox<TransactionModel>(transactionDbName);
    return transactionDb.values.toList();
  }

  @override
  Future<void> refreshUi() async {
    final allTransaction = await getAllTransactions();
    allTransactionList.value.clear();
    allTransactionList.value.addAll(allTransaction);
    allTransactionList.notifyListeners();
    totalIncome.value = 0;
    totalExpense.value = 0;
    currentBalance.value = 0;
    for (int i = 0; i < allTransaction.length; i++) {
      if (allTransaction[i].type == CategoryType.income) {
        totalIncome.value = totalIncome.value + allTransaction[i].amount;
      } else {
        totalExpense.value = totalExpense.value + allTransaction[i].amount;
      }
    }
    currentBalance.value = totalIncome.value - totalExpense.value;
    totalIncome.notifyListeners();
    totalExpense.notifyListeners();
    currentBalance.notifyListeners();
  }

  @override
  Future<void> editTransactionSample(TransactionModel newTransactionModel,
      TransactionModel oldTransactionModel) async {
    await oldTransactionModel.editTransaction(newTransactionModel);
    await refreshUi();
  }
}
