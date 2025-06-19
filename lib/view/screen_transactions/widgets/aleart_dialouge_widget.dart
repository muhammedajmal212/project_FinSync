import 'package:flutter/material.dart';
import 'package:week5/model/transaction/transaction_model.dart';

class AleartDialougeWidget extends StatelessWidget {
  final TransactionModel transactionModel;
  final void Function()? functoin;
  final String? text;

  const AleartDialougeWidget(
      {super.key,
      required this.transactionModel,
      required this.functoin,
      this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Are You Sure?"),
          Text(text == null ? "Do you want To Edit" : text!),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: functoin,
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            )
          ],
        )
      ],
    );
  }
}
