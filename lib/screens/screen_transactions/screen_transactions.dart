import 'package:flutter/material.dart';
import 'package:week5/screens/screen_transactions/widgets/transaction_tab_bar.dart';
import 'package:week5/widgets/expense_text.dart';
import 'package:week5/widgets/income_text.dart';

class ScreenTransactions extends StatefulWidget {
  const ScreenTransactions({super.key});

  @override
  State<ScreenTransactions> createState() => _ScreenTransactionsState();
}

class _ScreenTransactionsState extends State<ScreenTransactions> {
  bool isIncomeSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor:Colors.white,
      appBar: AppBar(
      backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Transactions",
          style:  TextStyle(color: Colors.white),
        ),
        elevation: 5,
     
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isIncomeSelected = true;
                    });
                  },
                  child: const IncomeText(),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isIncomeSelected = false;
                    });
                  },
                  child: const ExpenseText(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TransactionTabBar(
                isIncomeSelected: isIncomeSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
