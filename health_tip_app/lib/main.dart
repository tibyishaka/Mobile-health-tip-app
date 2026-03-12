import 'package:flutter/material.dart';
import 'package:health_tip_app/screens/main_screen.dart';

void main() {
  runApp(const HealthTipsApp());
}

class HealthTipsApp extends StatelessWidget {
  const HealthTipsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tips',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4CAF82)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
