import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/screens/daily_tips_screen.dart';
import 'package:health_tip_app/screens/discover_screen.dart';
import 'package:health_tip_app/screens/home_screen.dart';
import 'package:health_tip_app/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    DiscoverScreen(),
    DailyTipsScreen(),
    SettingsScreen(embedded: true),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final titles = [
      l.appTitle,
      l.navDiscover,
      l.navDailyTips,
      l.navSettings,
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: _currentIndex == 2
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => setState(() => _currentIndex = 0),
              )
            : null,
        centerTitle: true,
        title: Text(
          titles[_currentIndex],
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (_currentIndex == 0)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                onTap: () => setState(() => _currentIndex = 3),
                borderRadius: BorderRadius.circular(20),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.person,
                    color: Colors.grey.shade700,
                    size: 18,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4CAF82),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: l.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            activeIcon: const Icon(Icons.explore),
            label: l.navDiscover,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.lightbulb_outline),
            activeIcon: const Icon(Icons.lightbulb),
            label: l.navDailyTips,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: l.navSettings,
          ),
        ],
      ),
    );
  }
}
