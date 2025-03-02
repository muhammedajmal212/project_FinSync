import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  Future<List<TransactionModel>> refreshUi() async {
    final allTransaction = await getAllTransactions();
    return allTransaction;
  }

  @override
  Future<void> editTransactionSample(TransactionModel newTransactionModel,
      TransactionModel oldTransactionModel) async {
    await oldTransactionModel.editTransaction(newTransactionModel);
    await refreshUi();
  }
}
