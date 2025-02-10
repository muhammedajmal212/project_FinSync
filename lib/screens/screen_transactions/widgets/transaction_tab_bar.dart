import 'package:flutter/material.dart';

import 'package:week5/screens/screen_transactions/widgets/transaction_tab_bar_view.dart';

class TransactionTabBar extends StatefulWidget {
  final bool isIncomeSelected;
  const TransactionTabBar({super.key, required this.isIncomeSelected});

  @override
  State<TransactionTabBar> createState() => _TransactionTabBarState();
}

class _TransactionTabBarState extends State<TransactionTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TabBar(
            labelColor: const Color(0xFF2F2F2F),
            unselectedLabelColor: const Color(0xFF2F2F2F),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFFCCE5E3)),
            controller: tabController,
            tabs: const [
              Text(
                "All",
                style: TextStyle(
                    color: Color(0xFF2F2F2F),
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Text(
                "Today",
                style: TextStyle(
                    color: Color(0xFF2F2F2F),
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Text(
                "Custom",
                style: TextStyle(
                    color: Color(0xFF2F2F2F),
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TransactionTabBarView(
          tabController: tabController,
          isIncomeSelected: widget.isIncomeSelected,
        ),
      ],
    );
  }
}
