import 'package:flutter/material.dart';

class DailyTipsScreen extends StatefulWidget {
  const DailyTipsScreen({super.key});

  @override
  State<DailyTipsScreen> createState() => _DailyTipsScreenState();
}

class _DailyTipsScreenState extends State<DailyTipsScreen> {
  bool _remindMe = false;

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
                    'Aim for 7-9 hours of quality sleep each night to\nsupport physical and mental well-being.\nConsistent sleep patterns can improve mood,\nfocus, and overall health.',
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
                child: Text('Remind Me', style: TextStyle(fontSize: 20)),
              ),
              Transform.scale(
                scale: 0.95,
                child: Switch(
                  value: _remindMe,
                  onChanged: (value) => setState(() => _remindMe = value),
                  activeThumbColor: const Color(0xFF4CAF82),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
