import 'package:flutter/material.dart';
import 'package:flutter_application_expense_tracker/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.purple,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.tealAccent.shade100,
        appBarTheme: const AppBarTheme(
          color: Colors.teal,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            color: Colors.black,
          )
        )
      ),
      home: const Home(),
    );
  }
}
