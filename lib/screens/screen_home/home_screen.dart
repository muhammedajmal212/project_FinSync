import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/models/transaction/transaction_model.dart';
import 'package:week5/screens/screen_home/widgets/total_income_expense_screen.dart';
import 'package:week5/screens/transaction_adding_screen/transaction_adding_screen.dart';
import 'package:week5/widgets/add_button.dart';
import 'package:week5/widgets/transactions_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String newName = "";
  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
        title: Text(
          newName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const TotalIncomeExpenseScreen(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent transactions",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: ValueListenableBuilder(
                  valueListenable: TransactionDb.instance.allTransactionList,
                  builder: (context, List<TransactionModel> transactions, _) {
                    final recentTransaction =
                        transactions.reversed.take(4).toList();
                    return ListView.builder(
                      itemCount: recentTransaction.length,
                      itemBuilder: (ctx, index) {
                        final transaction = recentTransaction[index];
                        return TransactionsCard(transactionModel: transaction);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddButton(
        ontap: () => goToAddTransactionScreen(context),
      ),
    );
  }

  void getUsername() async {
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    final username = sharedpref.getString("setString");
    if (username != null) {
      setState(
        () {
          newName = username;
        },
      );
    }
  }

  goToAddTransactionScreen(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const TransactionAddiScreen(),
      ),
    );
  }
}
