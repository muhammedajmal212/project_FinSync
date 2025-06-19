import 'package:flutter/material.dart';
import 'package:week5/view/screen_transactions/widgets/all_transactions.dart';
import 'package:week5/view/screen_transactions/widgets/custom_transaction.dart';
import 'package:week5/view/screen_transactions/widgets/today_transactions.dart';

class TransactionTabBarView extends StatelessWidget {
  const TransactionTabBarView(
      {super.key, required this.tabController, required this.isIncomeSelected});

  final TabController tabController;
  final bool isIncomeSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [
          AllTransactions(
            isIncomeSelected: isIncomeSelected,
          ),
          TodayTransactions(
            isIncomeSelected: isIncomeSelected,
          ),
          CustomTransaction(
            isIncomeSelected: isIncomeSelected,
          ),
        ],
      ),
    );
  }
}
