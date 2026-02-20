import 'package:flutter/material.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Fitness',
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

            // Fitness Tips Cards
            Expanded(
              child: ListView(
                children: const [
                  // Card 1
                  FitnessTipCard(
                    picture:'images/warm_up.webp',
                    title: 'Start with warm-up',
                    description: 'Always begin your workout with 5-10 minutes of light cardio and dynamic stretches to prevent injuries.',
                  ),
                  SizedBox(height: 15),

                  // Card 2
                  FitnessTipCard(
                    picture:'images/training.webp',
                    title: 'Strength training basics',
                    description: 'Incorporate strength training 2-3 times per week focusing on major muscle groups for balanced development.',
                  ),
                  SizedBox(height: 15),

                  // Card 3
                  FitnessTipCard(
                    picture:'images/cardio.webp',
                    title: 'Cardio for heart health',
                    description: 'Aim for at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous activity weekly.',
                  ),
                  SizedBox(height: 15),

                  // Card 4
                  FitnessTipCard(
                    picture:'images/rest-sleep.webp',
                    title: 'Rest and recovery',
                    description: 'Take rest days between intense workouts to allow muscles to repair and grow stronger.',
                  ),
                  SizedBox(height: 15),

                  // Card 5
                  FitnessTipCard(
                    picture:'images/01.webp',
                    title: 'Proper form matters',
                    description: 'Focus on correct form rather than heavy weights to maximize results and prevent injuries.',
                  ),

                  // Card 6
                  FitnessTipCard(
                    picture:'images/cons.webp',
                    title: 'Stay consistent',
                    description: 'Create a workout schedule that you can maintain long-term rather than occasional intense sessions.',
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

class FitnessTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const FitnessTipCard({
    super.key,
    required this.title,
    required this.description,
    required this.picture,
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
          Image.asset(picture),
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