import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _DiscoverCard(
          icon: Icons.self_improvement,
          title: 'Discover Wellness',
          description:
              'Find breathing, sleep, and mindfulness guides to feel better.',
        ),
        SizedBox(height: 12),
        _DiscoverCard(
          icon: Icons.restaurant_menu,
          title: 'Healthy Nutrition',
          description:
              'Explore balanced meals and practical food choices for every day.',
        ),
        SizedBox(height: 12),
        _DiscoverCard(
          icon: Icons.directions_walk,
          title: 'Move More',
          description:
              'Browse simple activities to stay active even on busy schedules.',
        ),
      ],
    );
  }
}

class _DiscoverCard extends StatelessWidget {
  const _DiscoverCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFFF3FAF5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF4CAF82), size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[700], height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
