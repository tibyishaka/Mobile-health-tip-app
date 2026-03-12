import 'package:flutter/material.dart';

class DailyTipsScreen extends StatelessWidget {
  const DailyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _TipTile(
          title: 'Drink water first thing in the morning',
          subtitle: 'A glass of water helps rehydrate your body after sleep.',
        ),
        _TipTile(
          title: 'Take a 10-minute walk',
          subtitle: 'A short walk can improve mood and reduce stress quickly.',
        ),
        _TipTile(
          title: 'Pause for deep breathing',
          subtitle:
              'Try 4-4-4 breathing: inhale, hold, exhale for 4 seconds each.',
        ),
        _TipTile(
          title: 'Reduce screen time before bed',
          subtitle: 'Avoid screens 30 minutes before sleep for better rest.',
        ),
      ],
    );
  }
}

class _TipTile extends StatelessWidget {
  const _TipTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.lightbulb, color: Color(0xFF4CAF82)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
