import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:week5/widgets/app_button.dart';
import 'package:week5/widgets/app_text_form_field.dart';
import 'package:week5/widgets/bottom_nav_bar.dart';

final TextEditingController userNameController = TextEditingController();

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "Login Screen",
            style: TextStyle(color: Colors.white),
            
          ),
        ),
      body: SafeArea(
      
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: AppTextFormField(
                      validatorKey: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Username";
                        }
                        return null;
                      },
                      textEditingController: userNameController,
                      hintText: "Username",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppButton(
                      onTap: () {
                        gotoBottomNavBarScreen(context);
                      },
                      text: "Login"),
                ],
              ),
            ),
          ),
        ),
      
    );
  }

  Future<void> gotoBottomNavBarScreen(context) async {
    if (formKey.currentState?.validate() ?? false) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString("setString", userNameController.text);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const BottomNavBar(),
        ),
      );
    }
    userNameController.clear();
  }
}
