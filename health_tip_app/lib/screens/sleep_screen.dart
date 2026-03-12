import 'package:flutter/material.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Sleep',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      'Search  for topics',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Tip 1 - Establish a bedtime routine
            _buildTipRow(
              title: 'Establish a bedtime routine',
              description: 'Consistency is key. Go to bed and wake up at the same time every day, even on weekends.',
              color: const Color(0xFFE8E0D4),
              icon: Icons.nightlight_round,
              iconColor: const Color(0xFFD4A857),
            ),

            // Tip 2 - Limit screen time before bed
            _buildTipRow(
              title: 'Limit screen time before bed',
              description: 'The blue light emitted from screens can interfere with your sleep. Avoid screens at least an hour before bed.',
              color: const Color(0xFFE8DDD6),
              icon: Icons.visibility_off,
              iconColor: const Color(0xFF8D6E63),
            ),

            // Tip 3 - Keep your room cool
            _buildTipRow(
              title: 'Keep your room cool',
              description: 'A slightly cooler room temperature can help you fall asleep faster and stay asleep longer.',
              color: const Color(0xFFFFE0B2),
              icon: Icons.thermostat,
              iconColor: const Color(0xFFE65100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipRow({
    required String title,
    required String description,
    required Color color,
    required IconData icon,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 110,
            height: 90,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(icon, size: 40, color: iconColor),
            ),
          ),
        ],
      ),
    );
  }

}
