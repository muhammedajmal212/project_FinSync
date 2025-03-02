import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:week5/models/category/category_model.dart';
import 'package:week5/models/transaction/transaction_model.dart';
import 'package:week5/provider/category_provider.dart';
import 'package:week5/provider/transaction_provider.dart';
import 'package:week5/screens/splash_Screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(
      CategoryTypeAdapter(),
    );
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(
      CategoryModelAdapter(),
    );
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext ctx) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext ctx) => TransactionProvider(),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!);
        },
        theme: ThemeData(
          primaryColor: const Color(0xFF2F7E79),
          fontFamily: "Taviraj",
        ),
        home: const SplashScreen(),
      ),
    ),
  );
}
