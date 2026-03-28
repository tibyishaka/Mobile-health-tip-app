import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/app_theme.dart';
import 'package:health_tip_app/app_locale.dart';
import 'package:health_tip_app/services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.embedded = false});
  final bool embedded;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ── Notification toggles ────────────────────────────────────────────────────
  bool _newTips = false;
  bool _newFeatures = false;
  bool _updates = false;
  bool _dailyReminder = false;
  bool _loadingDailyReminder = false;

  // ── Language ─────────────────────────────────────────────────────────────────
  // Stored as locale code: 'en', 'fr', 'es'
  String _langCode = 'en';

  // Native display names – always shown in their own language so the user can
  // find them regardless of the current app language.
  static const Map<String, String> _languages = {
    'en': 'English',
    'fr': 'Français',
    'es': 'Español',
  };

  // ── Profile ──────────────────────────────────────────────────────────────────
  User? _currentUser;
  Map<String, dynamic>? _userData;
  bool _loadingProfile = true;
  bool _isLoggingOut = false;

  // ── SharedPreferences keys ───────────────────────────────────────────────────
  static const String _keyNewTips = 'notif_new_tips';
  static const String _keyNewFeatures = 'notif_new_features';
  static const String _keyUpdates = 'notif_updates';
  static const String _keyLanguage = 'app_language';

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _loadPreferences();
  }

  // ── Data loaders ─────────────────────────────────────────────────────────────

  Future<void> _loadUserProfile() async {
    _currentUser = FirebaseAuth.instance.currentUser;

    if (_currentUser == null) {
      if (mounted) setState(() => _loadingProfile = false);
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .get();
      if (mounted) {
        setState(() {
          _userData = doc.exists ? doc.data() : null;
          _loadingProfile = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingProfile = false);
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final dailyEnabled = await NotificationService.getReminderEnabled();
    if (mounted) {
      setState(() {
        _newTips = prefs.getBool(_keyNewTips) ?? false;
        _newFeatures = prefs.getBool(_keyNewFeatures) ?? false;
        _updates = prefs.getBool(_keyUpdates) ?? false;
        _langCode = _migrateLocaleCode(prefs.getString(_keyLanguage) ?? 'en');
        _dailyReminder = dailyEnabled;
      });
    }
  }

  /// Converts legacy full-name values ('English', 'French', 'Spanish')
  /// that the old code stored in SharedPreferences into proper BCP-47
  /// locale codes ('en', 'fr', 'es'). Valid codes pass through unchanged.
  String _migrateLocaleCode(String saved) {
    switch (saved.toLowerCase()) {
      case 'english':
        return 'en';
      case 'french':
      case 'français':
        return 'fr';
      case 'spanish':
      case 'español':
        return 'es';
      default:
        // Already a valid code ('en', 'fr', 'es') — use as-is.
        if (['en', 'fr', 'es'].contains(saved)) return saved;
        return 'en';
    }
  }

  // ── Savers ───────────────────────────────────────────────────────────────────

  Future<void> _saveNotifPref(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _changeLanguage(String code) async {
    if (code == _langCode) return;
    setState(() => _langCode = code);
    // 1. Update the global notifier → MaterialApp rebuilds with new locale
    appLocale.value = Locale(code);
    // 2. Persist so the choice survives restarts
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, code);
  }

  // ── Logout ───────────────────────────────────────────────────────────────────

  Future<void> _logout() async {
    final l = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l.logOutConfirmTitle),
        content: Text(l.logOutConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              l.cancel,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.logOut),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!mounted) return;

    setState(() => _isLoggingOut = true);
    try {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoggingOut = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.logoutFailed(e.toString()),
          ),
        ),
      );
    }
  }

  // ── Daily reminder toggle ────────────────────────────────────────────────────

  Future<void> _toggleDailyReminder(bool value) async {
    setState(() {
      _dailyReminder = value;
      _loadingDailyReminder = true;
    });
    await NotificationService.setReminder(value);
    if (mounted) setState(() => _loadingDailyReminder = false);
  }

  // ── Profile editing ──────────────────────────────────────────────────────────

  Future<void> _editDisplayName() async {
    final controller = TextEditingController(text: _displayName);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Name'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Your display name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF82),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    final newName = controller.text.trim();
    if (newName.isEmpty || newName == _displayName) return;

    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(newName);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .update({'name': newName});
      if (mounted) {
        setState(() {
          if (_userData != null) _userData!['name'] = newName;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Name updated successfully'),
            backgroundColor: Color(0xFF4CAF82),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update name: $e')));
      }
    }
  }

  // ── Account deletion ─────────────────────────────────────────────────────────

  Future<void> _deleteAccount() async {
    final l = AppLocalizations.of(context)!;

    // First confirmation
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Account',
          style: TextStyle(color: Colors.redAccent),
        ),
        content: const Text(
          'This will permanently delete your account, profile, and all your data. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              l.cancel,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete My Account'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    // Second confirmation — type to confirm
    final verifyController = TextEditingController();
    final verified = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Are you absolutely sure?',
          style: TextStyle(color: Colors.redAccent),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Type DELETE to confirm:'),
            const SizedBox(height: 12),
            TextField(
              controller: verifyController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'DELETE',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              l.cancel,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () =>
                Navigator.pop(ctx, verifyController.text.trim() == 'DELETE'),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (verified != true || !mounted) return;

    setState(() => _isLoggingOut = true);
    try {
      final uid = _currentUser?.uid;
      // Cancel all notifications first
      await NotificationService.cancelAll();
      // Delete Firestore document
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      }
      // Delete Firebase Auth account
      await FirebaseAuth.instance.currentUser?.delete();

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoggingOut = false);
      // If re-authentication is required (Firebase may throw this for sensitive ops)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not delete account. Please log out and log back in, then try again.',
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  String get _displayName =>
      _userData?['name'] as String? ?? _currentUser?.displayName ?? 'User';

  String get _displayEmail =>
      _userData?['email'] as String? ?? _currentUser?.email ?? '';

  String _formatMemberSince(dynamic timestamp, AppLocalizations l) {
    if (timestamp == null) return '';
    if (timestamp is! Timestamp) return '';
    final dt = timestamp.toDate();
    final dateStr = DateFormat('MMM yyyy', _langCode).format(dt);
    return l.memberSince(dateStr);
  }

  // ── Build ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final content = SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Profile card ──────────────────────────────────────────────────
          Center(
            child: _loadingProfile
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: CircularProgressIndicator(color: Color(0xFF4CAF82)),
                  )
                : Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundColor: const Color(0xFFE8F5E9),
                        child: Text(
                          _displayName.isNotEmpty
                              ? _displayName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4CAF82),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _displayName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          InkWell(
                            onTap: _editDisplayName,
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: Color(0xFF4CAF82),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _displayEmail,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      if (_userData?['createdAt'] != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _formatMemberSince(_userData!['createdAt'], l),
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),

          // ── Notifications ─────────────────────────────────────────────────
          Text(
            l.notifications,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Real daily reminder — wired to NotificationService
          SwitchListTile(
            title: const Text('Daily Tip Reminder'),
            subtitle: const Text(
              'Get a push reminder each day to check your tip',
            ),
            activeTrackColor: const Color(0xFF4CAF82),
            secondary: _loadingDailyReminder
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF4CAF82),
                    ),
                  )
                : const Icon(
                    Icons.notifications_active_outlined,
                    color: Color(0xFF4CAF82),
                  ),
            value: _dailyReminder,
            onChanged: _loadingDailyReminder ? null : _toggleDailyReminder,
          ),

          SwitchListTile(
            title: Text(l.newTips),
            subtitle: Text(l.newTipsDesc),
            activeTrackColor: const Color(0xFF4CAF82),
            value: _newTips,
            onChanged: (val) {
              setState(() => _newTips = val);
              _saveNotifPref(_keyNewTips, val);
            },
          ),
          SwitchListTile(
            title: Text(l.newFeatures),
            subtitle: Text(l.newFeaturesDesc),
            activeTrackColor: const Color(0xFF4CAF82),
            value: _newFeatures,
            onChanged: (val) {
              setState(() => _newFeatures = val);
              _saveNotifPref(_keyNewFeatures, val);
            },
          ),
          SwitchListTile(
            title: Text(l.updatesLabel),
            subtitle: Text(l.updatesDesc),
            activeTrackColor: const Color(0xFF4CAF82),
            value: _updates,
            onChanged: (val) {
              setState(() => _updates = val);
              _saveNotifPref(_keyUpdates, val);
            },
          ),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // ── App Preferences ───────────────────────────────────────────────
          Text(
            l.appPreferences,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Theme picker
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.theme),
            subtitle: Text(l.themeDesc),
            trailing: ValueListenableBuilder<ThemeMode>(
              valueListenable: appThemeMode,
              builder: (context, mode, _) {
                return DropdownButton<String>(
                  value: themeModeLabel(mode),
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(10),
                  items: [
                    DropdownMenuItem(
                      value: 'System',
                      child: Text(l.themeSystem),
                    ),
                    DropdownMenuItem(value: 'Light', child: Text(l.themeLight)),
                    DropdownMenuItem(value: 'Dark', child: Text(l.themeDark)),
                  ],
                  onChanged: (val) {
                    if (val == null) return;
                    appThemeMode.value = themeModeFromLabel(val);
                  },
                );
              },
            ),
          ),

          // Language picker
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l.language),
            subtitle: Text(l.languageDesc),
            trailing: DropdownButton<String>(
              value: _langCode,
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(10),
              items: _languages.entries
                  .map(
                    (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) _changeLanguage(val);
              },
            ),
          ),

          const SizedBox(height: 32),

          // ── Delete account ────────────────────────────────────────────────
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Danger Zone',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent.shade200,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isLoggingOut ? null : _deleteAccount,
              icon: const Icon(Icons.delete_forever_outlined),
              label: const Text(
                'Delete My Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Log out ───────────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isLoggingOut ? null : _logout,
              icon: _isLoggingOut
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.logout),
              label: Text(
                _isLoggingOut ? l.loggingOut : l.logOut,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );

    if (widget.embedded) return content;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l.navSettings,
          style: const TextStyle(
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
