import 'package:flutter/material.dart';

class MindfulnessScreen extends StatelessWidget {
  const MindfulnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mindfulness',
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
                  color: const Color(0xFFEDF5FC),
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

            // Tip 1 - Practice deep breathing
            _buildTipRow(
              title: 'Practice deep breathing',
              description: 'Take slow, deep breaths to calm your mind and reduce stress throughout the day.',
              color: const Color(0xFFE1F5FE),
              icon: Icons.air,
              iconColor: const Color(0xFF42A5F5),
            ),

            // Tip 2 - Try meditation
            _buildTipRow(
              title: 'Try meditation',
              description: 'Start with just 5 minutes a day. Meditation can help reduce anxiety and improve focus.',
              color: const Color(0xFFF3E5F5),
              icon: Icons.self_improvement,
              iconColor: const Color(0xFF9C27B0),
            ),

            // Tip 3 - Be present in the moment
            _buildTipRow(
              title: 'Be present in the moment',
              description: 'Focus on the here and now. Notice your surroundings, thoughts, and feelings without judgment.',
              color: const Color(0xFFE8F5E9),
              icon: Icons.spa,
              iconColor: const Color(0xFF66BB6A),
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
