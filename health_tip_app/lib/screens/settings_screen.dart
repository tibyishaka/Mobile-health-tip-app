import 'package:flutter/material.dart';
import 'package:health_tip_app/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.embedded = false});

  final bool embedded;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool newTips = false;
  bool newFeatures = false;
  bool updates = false;
  String language = 'English';

  @override
  Widget build(BuildContext context) {
    final content = SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Liam Carter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'View profile',
                  style: TextStyle(color: Colors.blue),
                ),
                const Text(
                  'ID: 12345678',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Notifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text('New tips'),
            subtitle: const Text('Get notified about new tips'),
            value: newTips,
            onChanged: (val) => setState(() => newTips = val),
          ),
          SwitchListTile(
            title: const Text('New features'),
            subtitle: const Text('Get notified about new features'),
            value: newFeatures,
            onChanged: (val) => setState(() => newFeatures = val),
          ),
          SwitchListTile(
            title: const Text('Updates'),
            subtitle: const Text('Get notified about new updates'),
            value: updates,
            onChanged: (val) => setState(() => updates = val),
          ),
          const SizedBox(height: 24),
          const Text(
            'App Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Choose your preferred theme'),
            trailing: ValueListenableBuilder<ThemeMode>(
              valueListenable: appThemeMode,
              builder: (context, mode, child) {
                return DropdownButton<String>(
                  value: themeModeLabel(mode),
                  items: const [
                    DropdownMenuItem(value: 'System', child: Text('System')),
                    DropdownMenuItem(value: 'Light', child: Text('Light')),
                    DropdownMenuItem(value: 'Dark', child: Text('Dark')),
                  ],
                  onChanged: (val) {
                    if (val == null) return;
                    appThemeMode.value = themeModeFromLabel(val);
                  },
                );
              },
            ),
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: const Text('Select your preferred language'),
            trailing: DropdownButton<String>(
              value: language,
              items: const [
                DropdownMenuItem(value: 'English', child: Text('English')),
                DropdownMenuItem(value: 'French', child: Text('French')),
                DropdownMenuItem(
                  value: 'Kinyarwanda',
                  child: Text('Kinyarwanda'),
                ),
              ],
              onChanged: (val) => setState(() => language = val ?? 'English'),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: const Text('Logout', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );

    if (widget.embedded) {
      return content;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: content,
    );
  }
}
