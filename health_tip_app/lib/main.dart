import 'package:flutter/material.dart';
import 'package:health_tip_app/screens/fitness_screen.dart';
import 'package:health_tip_app/screens/mental_health_screen.dart';
import 'package:health_tip_app/screens/stress_management_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tips App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Health Tips App'),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/fitness': (context) => const FitnessScreen(),
        '/mental_health' : (context) => const MentalHealthScreen(),
        '/stress_man' : (context) => const StressManagementScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('Go to Login'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text('Go to Signup'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: const Text('Go to Settings'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/fitness'),
              child: const Text('Go to fitness'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/mental_health'),
              child: const Text('Go to mental health'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/stress_man'),
              child: const Text('Go to Stress management'),
            ),
          ],
        ),
      ),
    );
  }
}
