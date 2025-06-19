import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:week5/view/screen_settings/widgets/all_statitics_widget.dart';
import 'package:week5/view/screen_settings/widgets/expense_statitics_widget.dart';
import 'package:week5/view/screen_settings/widgets/income_statitics_widget.dart';

class ScreenStatitics extends StatefulWidget {
  const ScreenStatitics({super.key});

  @override
  State<ScreenStatitics> createState() => _ScreenStatiticsState();
}

class _ScreenStatiticsState extends State<ScreenStatitics> {
  int newCurvebarIndex = 0;
  final List<Widget> curveBarScreens = const [
    AllStatiticsWidget(),
    IncomeStatiticsWidget(),
    ExpenseStatiticsWidget()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Statitics",
          style: TextStyle(color: Colors.white),
        ),
         backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 80,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color(0xFFCCE5E3),
        backgroundColor: Colors.white,
        index: newCurvebarIndex,
        onTap: (index) {
          setState(() {
            newCurvebarIndex = index;
          });
        },
        items: [
          Icon(
            Icons.border_all_rounded,
            color: Colors.grey[600],
          ),
          const Icon(
            Icons.trending_up_outlined,
            color: Color(0xFF1995AD),
            size: 35,
          ),
          const Icon(
            Icons.trending_down_outlined,
            color: Color(0xFF2F2F2F),
            size: 35,
          ),
        ],
      ),
      backgroundColor: const Color(0xFFB8D7D1),
      body: SafeArea(
        child: curveBarScreens[newCurvebarIndex],
      ),
    );
  }
}
