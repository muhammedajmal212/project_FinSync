import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/models/transaction/transaction_model.dart';

class TransactionsCard extends StatelessWidget {
  final TransactionModel transactionModel;
  const TransactionsCard({super.key, required this.transactionModel});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      // color:const Color.fromARGB(255, 209, 247, 243),
      child: ListTile(
        leading: Icon(
          transactionModel.categoryModel!.type == CategoryType.income
              ? Icons.arrow_circle_up_outlined
              : Icons.arrow_circle_down_outlined,
          color: transactionModel.categoryModel!.type == CategoryType.income
              ? const Color(0xFF4CAF50)
              : const Color(0xFFE53935),
        ),
        title: Row(
          children: [
            Text(
              transactionModel.categoryModel!.name,
              style: const TextStyle(
                color: Color(0xFF2F2F2F),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: transactionModel.description.isEmpty
                  ? const Text("")
                  : Text('( ${transactionModel.description})'),
            )
          ],
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transactionModel.date),
        ),
        trailing: Text(
          transactionModel.amount.toString(),
        ),
      ),
    );
  }
}
