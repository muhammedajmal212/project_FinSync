import 'package:hive_flutter/hive_flutter.dart';
import 'package:week5/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel extends HiveObject {
  @HiveField(0)
  CategoryModel? categoryModel;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  num amount;

  @HiveField(4)
  String? id;

  @HiveField(5)
  CategoryType type;

  TransactionModel({
    this.categoryModel,
    required this.description,
    required this.date,
    required this.amount,
    required this.type,
  }) {
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
  Future<void> editTransaction(TransactionModel newTransaction) async {
    categoryModel=newTransaction.categoryModel;
    description = newTransaction.description;
    date = newTransaction.date;
    amount = newTransaction.amount;
    type = newTransaction.type;
  }
  Future<void>deleteTransaction()async{
    await delete();

  }
   Future<void>deleteCategory()async{
    await delete();

  }
}
