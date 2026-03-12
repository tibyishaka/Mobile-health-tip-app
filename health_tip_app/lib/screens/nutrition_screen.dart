import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Nutrition',
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
                  color: const Color(0xFFF1F5F1),
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

            // Tip 1 - Increase fiber intake
            _buildTipRow(
              title: 'Increase fiber intake',
              description: 'Fiber helps regulate digestion and keeps you feeling full.',
              color: const Color(0xFFE8F5E9),
              icon: Icons.eco,
              iconColor: const Color(0xFF4CAF50),
            ),

            // Tip 2 - Stay hydrated
            _buildTipRow(
              title: 'Stay hydrated',
              description: 'Drink plenty of water throughout the day to maintain energy levels.',
              color: const Color(0xFFFFF8E1),
              icon: Icons.water_drop,
              iconColor: const Color(0xFF42A5F5),
            ),

            // Tip 3 - Choose whole grains
            _buildTipRow(
              title: 'Choose whole grains',
              description: 'Opt for whole grains like brown rice and quinoa for sustained energy.',
              color: const Color(0xFFFFF3E0),
              icon: Icons.grass,
              iconColor: const Color(0xFF8D6E63),
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
