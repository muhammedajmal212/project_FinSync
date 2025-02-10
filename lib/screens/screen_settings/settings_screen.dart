import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:week5/db/category/category_db.dart';
import 'package:week5/db/transactions/transaction_db.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/models/transaction/transaction_model.dart';
import 'package:week5/screens/screen_category/widget/alert_widget.dart';
import 'package:week5/screens/screen_settings/screen_statitics.dart';
import 'package:week5/screens/splash_Screen/splash_screen.dart';

final TextEditingController newUserNameController = TextEditingController();

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    loadUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Settings Screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertWidget(
                          function: () {
                            changeUserName(context);
                          },
                          categorycontroller: newUserNameController,
                          text: "Are You Sure?");
                    });
              },
              label: const Text(
                "Change Username",
                style: TextStyle(color: Color(0xFF2F2F2F)),
              ),
              icon: const Icon(
                Icons.person_outlined,
                color: Color(0xFF2F7E79),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const ScreenStatitics()));
              },
              label: const Text("Statitics",
                  style: TextStyle(color: Color(0xFF2F2F2F))),
              icon: const Icon(
                Icons.auto_graph,
                color: Color(0xFF2F7E79),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                helpCenterFunction();
              },
              label: const Text("Help Center",
                  style: TextStyle(color: Color(0xFF2F2F2F))),
              icon: const Icon(
                Icons.help_outline_sharp,
                color: Color(0xFF2F7E79),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                shareFunction();
              },
              label: const Text("Share",
                  style: TextStyle(color: Color(0xFF2F2F2F))),
              icon: const Icon(
                Icons.share,
                color: Color(0xFF2F7E79),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                resetAleartDialoude(context);
              },
              label: const Text("reset",
                  style: TextStyle(color: Color(0xFF2F2F2F))),
              icon: const Icon(
                Icons.restart_alt_rounded,
                color: Color(0xFF2F7E79),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeUserName(context) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    if (newUserNameController.text.isNotEmpty) {
      await sharedpref.remove("setString");
      await sharedpref.setString("setString", newUserNameController.text);
      Navigator.of(context).pop();
    }
  }

  void loadUsername() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    newUserNameController.text = sharedpref.getString("setString") ?? "";
  }

  void resetAleartDialoude(context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Reset"),
        content: const Text("Are You Sure Doyou Want to Reset"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    isResetButtonClicked(context);
                  },
                  child: const Text("Reset"))
            ],
          ),
        ],
      ),
    );
  }

  void isResetButtonClicked(context) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.remove("setString");
    final categoryDb = await Hive.openBox<CategoryModel>(categoryDbName);
    categoryDb.clear();
    final transactionDb =
        await Hive.openBox<TransactionModel>(transactionDbName);
    transactionDb.clear();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const SplashScreen(),
        ),
        (route) => false);
  }

  void shareFunction() async {
    await Share.share("text");
  }

  void helpCenterFunction() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'roshanudemy123@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Example Subject & Symbols are allowed!',
      }),
    );

    launchUrl(emailLaunchUri);
  }
}
