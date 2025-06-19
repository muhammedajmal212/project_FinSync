import 'package:flutter/material.dart';
import 'package:week5/view/transaction_adding_screen/widgets/transaction_adding_widget.dart';
import 'package:week5/view/transaction_adding_screen/widgets/transaction_adding_widget.dart';

class TransactionAddiScreen extends StatefulWidget {
  const TransactionAddiScreen({super.key});

  @override
  State<TransactionAddiScreen> createState() => _TransactionAddiScreenState();
}

class _TransactionAddiScreenState extends State<TransactionAddiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
         title: const Text(
          "Add Transaction",
          style:  TextStyle(color: Colors.white)
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TransactionAddingWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
