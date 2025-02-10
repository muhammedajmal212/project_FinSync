import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week5/screens/screen_login/login_screen.dart';
import 'package:week5/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    userLoginCheck(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const  Color(0xFFFFFFFF),

      body: 
         SafeArea(
          child: Center(
            child: Animate(
              onPlay: (controller) => controller.repeat(),
              effects: const [
                ScaleEffect(),
                FadeEffect(),
              ],
              child: const Text(
                "FinSync",
                style: TextStyle(fontSize: 35),
              ),
            )
                .fade(
                  duration: const Duration(seconds: 4),
                )
                .tint(color: Theme.of(context).primaryColor)
                .then()
                .addEffect(
                  const SaturateEffect(),
                ),
          ),
        ),
      
    );
  }

  Future<void> navigateToLogintScreen(context) async {
    await Future.delayed(
      const Duration(seconds: 6),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void userLoginCheck(context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final value = sharedPreferences.getString("setString");
    if (value != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const BottomNavBar(),
        ),
      );
    } else {
      navigateToLogintScreen(context);
    }
  }
}
