import 'package:flutter/material.dart';
import 'package:week5/view/screen_transactions/widgets/transaction_tab_bar.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Transactions",
          style: TextStyle(color: Colors.white),
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
                  child: isIncomeSelected == true
                      ? const Text(
                          "Income",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          "Income",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isIncomeSelected = false;
                    });
                  },
                  child: isIncomeSelected == false
                      ? const Text(
                          "Expense",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          "Expense",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
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
