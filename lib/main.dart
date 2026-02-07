import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
