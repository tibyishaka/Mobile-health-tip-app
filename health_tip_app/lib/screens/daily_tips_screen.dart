import 'package:flutter/material.dart';
import 'package:health_tip_app/services/notification_service.dart';

class DailyTipsScreen extends StatefulWidget {
  const DailyTipsScreen({super.key});

  @override
  State<DailyTipsScreen> createState() => _DailyTipsScreenState();
}

class _DailyTipsScreenState extends State<DailyTipsScreen> {
  bool _remindMe = false;
  bool _loadingReminder = true;

  @override
  void initState() {
    super.initState();
    _loadReminderState();
  }

  Future<void> _loadReminderState() async {
    final enabled = await NotificationService.getReminderEnabled();
    if (mounted) {
      setState(() {
        _remindMe = enabled;
        _loadingReminder = false;
      });
    }
  }

  Future<void> _toggleReminder(bool value) async {
    setState(() => _remindMe = value);
    await NotificationService.setReminder(value);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? '🔔 Daily reminders enabled! You\'ll be notified every day.'
              : '🔕 Daily reminders disabled.',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 20),
        children: [
          const Text(
            'Tip of the Day',
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                  child: Image.asset(
                    'assets/images/fitness/rest-sleep.webp',
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(6, 6, 6, 0),
                  child: Text(
                    'Prioritize Sleep for Optimal Health',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 4, 6, 0),
                  child: Text(
                    'Aim for 7-9 hours of quality sleep each night to\n'
                    'support physical and mental well-being.\n'
                    'Consistent sleep patterns can improve mood,\n'
                    'focus, and overall health.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green.shade700,
                      height: 1.35,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 4, 6, 8),
                  child: Text(
                    'Health',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remind Me',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Get a daily notification to check your tip of the day.',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _loadingReminder
                  ? const SizedBox(
                      width: 36,
                      height: 24,
                      child: Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : Transform.scale(
                      scale: 0.95,
                      child: Switch(
                        value: _remindMe,
                        onChanged: _toggleReminder,
                        activeTrackColor: const Color(0xFF4CAF82),
                        activeThumbColor: Colors.white,
                      ),
                    ),
            ],
          ),
          if (_remindMe) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF4CAF82), width: 1),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.notifications_active,
                    color: Color(0xFF4CAF82),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You\'ll receive a daily reminder to check your health tip.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green.shade800,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
