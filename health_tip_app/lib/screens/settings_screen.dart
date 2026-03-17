import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/app_theme.dart';
import 'package:health_tip_app/app_locale.dart';

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
  static const String _keyNewTips     = 'notif_new_tips';
  static const String _keyNewFeatures = 'notif_new_features';
  static const String _keyUpdates     = 'notif_updates';
  static const String _keyLanguage    = 'app_language';

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
          _userData      = doc.exists ? doc.data() : null;
          _loadingProfile = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadingProfile = false);
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _newTips     = prefs.getBool(_keyNewTips)     ?? false;
        _newFeatures = prefs.getBool(_keyNewFeatures) ?? false;
        _updates     = prefs.getBool(_keyUpdates)     ?? false;
        _langCode    = prefs.getString(_keyLanguage)  ?? 'en';
      });
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
            child: Text(l.cancel,
                style: const TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
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
                AppLocalizations.of(context)!.logoutFailed(e.toString()))),
      );
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  String get _displayName =>
      _userData?['name'] as String? ??
      _currentUser?.displayName ??
      'User';

  String get _displayEmail =>
      _userData?['email'] as String? ??
      _currentUser?.email ??
      '';

  String _formatMemberSince(dynamic timestamp, AppLocalizations l) {
    if (timestamp == null) return '';
    if (timestamp is! Timestamp) return '';
    final dt       = timestamp.toDate();
    final dateStr  = DateFormat('MMM yyyy', _langCode).format(dt);
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
                    child: CircularProgressIndicator(
                        color: Color(0xFF4CAF82)),
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
                      Text(_displayName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(_displayEmail,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 14)),
                      if (_userData?['createdAt'] != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _formatMemberSince(_userData!['createdAt'], l),
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
          ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),

          // ── Notifications ─────────────────────────────────────────────────
          Text(l.notifications,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

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
          Text(l.appPreferences,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
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
                        value: 'System', child: Text(l.themeSystem)),
                    DropdownMenuItem(
                        value: 'Light', child: Text(l.themeLight)),
                    DropdownMenuItem(
                        value: 'Dark', child: Text(l.themeDark)),
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
                  .map((e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) _changeLanguage(val);
              },
            ),
          ),

          const SizedBox(height: 32),

          // ── Log out ───────────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _isLoggingOut ? null : _logout,
              icon: _isLoggingOut
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
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
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: content,
    );
  }
}
