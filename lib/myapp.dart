import 'package:flutter/material.dart';
import 'package:flutter_application_expense_tracker/home.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.tealAccent.shade100,
        appBarTheme: const AppBarTheme(
          color: Colors.teal,
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme, // keeps default sizes/colors
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      home: const Home(),
    );
  }
}
