import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week5/db/category/category_db.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/models/transaction/transaction_model.dart';

class DeleteCategoryPopup extends StatelessWidget {
  final String id;
  const DeleteCategoryPopup({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Are You Sure? You Want To Delete This Item? ",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.infinity,
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    deleteFunction(context);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Color.fromARGB(255, 248, 90, 90),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 248, 90, 90)),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteFunction(context) async {
    final transactionDb =
        await Hive.openBox<TransactionModel>(transactionDbName);
    final isCategoryUsedInTransaction = transactionDb.values
        .any((transaction) => transaction.categoryModel?.id == id);
    if (isCategoryUsedInTransaction) {
      Navigator.of(context).pop();
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text(
            "Cannot Delete Category As it Is Used In Transaction",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            )
          ],
        ),
      );
    } else {
      CategoryDb().deleteCategory(id);
      Navigator.of(context).pop();
    }
  }
}
