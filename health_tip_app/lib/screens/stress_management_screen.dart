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
        title:  Center(
          child: Text(
            'Mental Health',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search hint text
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300, // light grey background
                    borderRadius: BorderRadius.circular(15), // rounded corners
                  ),
                  child:  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for topics',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: Colors.black54, size: 28),
                          onPressed:(){}
                      ),
                    ),
                  )
              ),
            ),

            // Stress Management Tips Cards
            Expanded(
              child: ListView(
                children: const [
                  // Card 1
                  StressTipCard(
                    picture:'assets/images/stress/deep-breathing.webp',
                    title: 'Deep breathing exercises',
                    description: 'Practice the 4-7-8 technique: inhale for 4 seconds, hold for 7, exhale for 8 to calm your nervous system.',
                  ),
                  SizedBox(height: 15),

                  // Card 2
                  StressTipCard(
                    picture:'assets/images/stress/time-management.webp',
                    title: 'Time management',
                    description: 'Break tasks into smaller steps and prioritize to avoid feeling overwhelmed by responsibilities.',
                  ),
                  SizedBox(height: 15),

                  // Card 3
                  StressTipCard(
                    picture:'assets/images/stress/exercise.webp',
                    title: 'Physical activity',
                    description: 'Regular exercise releases endorphins and helps reduce stress levels naturally.',
                  ),
                  SizedBox(height: 15),

                  // Card 4
                  StressTipCard(
                    picture:'assets/images/stress/Progressive muscle relaxation.webp',
                    title: 'Progressive muscle relaxation',
                    description: 'Tense and then relax each muscle group to release physical tension caused by stress.',
                  ),
                  SizedBox(height: 15),

                  // Card 5
                  StressTipCard(
                    picture:'assets/images/stress/Set-boundaries.webp',
                    title: 'Set boundaries',
                    description: 'Learn to say no to additional responsibilities when you\'re feeling overwhelmed.',
                  ),
                  SizedBox(height: 15),

                  // Card 6
                  StressTipCard(
                    picture:'assets/images/stress/Mindful walking.webp',
                    title: 'Mindful walking',
                    description: 'Take a short walk and focus on your surroundings, the sensation of walking, and your breathing.',
                  ),
                  SizedBox(height: 15),

                  // Card 7
                  StressTipCard(
                    picture:'assets/images/stress/Listen to music.webp',
                    title: 'Listen to music',
                    description: 'Play calming music or nature sounds to reduce stress and improve your mood.',
                  ),
                  SizedBox(height: 15),

                  // Card 8
                  StressTipCard(
                    picture:'assets/images/stress/Aromatherapy.webp',
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
  final String picture;

  const StressTipCard({
    super.key,
    required this.title,
    required this.description,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // LEFT SIDE (TEXTS)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // RIGHT SIDE (IMAGE)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              picture,
              width: 110,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),

    );
  }
}