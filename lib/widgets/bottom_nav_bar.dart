import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:week5/db/category/category_db.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/screens/screen_category/category_screen.dart';
import 'package:week5/screens/screen_home/home_screen.dart';
import 'package:week5/screens/screen_settings/settings_screen.dart';
import 'package:week5/screens/screen_transactions/screen_transactions.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> navBarScreens = const [
    HomeScreen(),
    ScreenTransactions(),
    CategoryScreen(),
    SettingsScreen(),
  ];

  int navigationBarindex = 0;
  @override
  void initState() {
    CategoryDb().refreshUi();
    TransactionDb.instance.refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFCCE5E3),
                Color(0xFFEEDEF6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, -2),
              )
            ]),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: const Color(0xFF80CBC4),
          animationDuration: const Duration(milliseconds: 300),
          index: navigationBarindex,
          items: [
            Icon(
              Icons.home,
              size: 30,
              color: navigationBarindex == 0
                  ? Colors.white
                  : const Color.fromARGB(255, 91, 90, 90),
            ),
            Icon(
              Icons.list_alt,
              color: navigationBarindex == 1
                  ? Colors.white
                  : const Color.fromARGB(255, 91, 90, 90),
              size: 30,
            ),
            Icon(
              Icons.category,
              size: 30,
              color: navigationBarindex == 2
                  ? Colors.white
                  : const Color.fromARGB(255, 91, 90, 90),
            ),
            Icon(
              Icons.settings,
              size: 30,
              color: navigationBarindex == 3
                  ? Colors.white
                  : const Color.fromARGB(255, 91, 90, 90),
            ),
          ],
          onTap: (index) {
            setState(
              () {
                navigationBarindex = index;
              },
            );
          },
        ),
      ),
      body: navBarScreens[navigationBarindex],
    );
  }
}
