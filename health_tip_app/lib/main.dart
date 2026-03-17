import 'package:flutter/material.dart';
import 'package:health_tip_app/screens/getting_started_screen.dart';
import 'package:health_tip_app/screens/mindfulness_screen.dart';
import 'package:health_tip_app/screens/nutrition_screen.dart';
import 'package:health_tip_app/screens/sleep_screen.dart';

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
      routes: {
        '/nutrition': (context) => const NutritionScreen(),
        '/sleep': (context) => const SleepScreen(),
        '/mindfulness': (context) => const MindfulnessScreen(),
      },
      home: const GettingStartedScreen(),
    );
  }
}
