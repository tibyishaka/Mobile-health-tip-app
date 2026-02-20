import 'package:flutter/material.dart';

class StressManagementScreen extends StatelessWidget {
  const StressManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Stress Management',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black54, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search hint text
            const Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Text(
                'Search for topics',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),

            // Stress Management Tips Cards
            Expanded(
              child: ListView(
                children: const [
                  // Card 1
                  StressTipCard(
                    title: 'Deep breathing exercises',
                    description: 'Practice the 4-7-8 technique: inhale for 4 seconds, hold for 7, exhale for 8 to calm your nervous system.',
                  ),
                  SizedBox(height: 15),

                  // Card 2
                  StressTipCard(
                    title: 'Time management',
                    description: 'Break tasks into smaller steps and prioritize to avoid feeling overwhelmed by responsibilities.',
                  ),
                  SizedBox(height: 15),

                  // Card 3
                  StressTipCard(
                    title: 'Physical activity',
                    description: 'Regular exercise releases endorphins and helps reduce stress levels naturally.',
                  ),
                  SizedBox(height: 15),

                  // Card 4
                  StressTipCard(
                    title: 'Progressive muscle relaxation',
                    description: 'Tense and then relax each muscle group to release physical tension caused by stress.',
                  ),
                  SizedBox(height: 15),

                  // Card 5
                  StressTipCard(
                    title: 'Set boundaries',
                    description: 'Learn to say no to additional responsibilities when you\'re feeling overwhelmed.',
                  ),
                  SizedBox(height: 15),

                  // Card 6
                  StressTipCard(
                    title: 'Mindful walking',
                    description: 'Take a short walk and focus on your surroundings, the sensation of walking, and your breathing.',
                  ),
                  SizedBox(height: 15),

                  // Card 7
                  StressTipCard(
                    title: 'Listen to music',
                    description: 'Play calming music or nature sounds to reduce stress and improve your mood.',
                  ),
                  SizedBox(height: 15),

                  // Card 8
                  StressTipCard(
                    title: 'Aromatherapy',
                    description: 'Use essential oils like lavender or chamomile to create a calming environment.',
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

class StressTipCard extends StatelessWidget {
  final String title;
  final String description;

  const StressTipCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}