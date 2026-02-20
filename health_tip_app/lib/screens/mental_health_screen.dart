import 'package:flutter/material.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mental Health',
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

            // Mental Health Tips Cards
            Expanded(
              child: ListView(
                children: const [
                  // Card 1
                  MentalHealthTipCard(
                    title: 'Practice mindfulness',
                    description: 'Take 10 minutes daily to focus on the present moment through meditation or deep breathing exercises.',
                  ),
                  SizedBox(height: 15),

                  // Card 2
                  MentalHealthTipCard(
                    title: 'Digital detox',
                    description: 'Set aside time each day to disconnect from screens and engage in offline activities you enjoy.',
                  ),
                  SizedBox(height: 15),

                  // Card 3
                  MentalHealthTipCard(
                    title: 'Gratitude journaling',
                    description: 'Write down three things you\'re grateful for each day to cultivate a positive mindset.',
                  ),
                  SizedBox(height: 15),

                  // Card 4
                  MentalHealthTipCard(
                    title: 'Connect with others',
                    description: 'Maintain strong social connections by regularly reaching out to friends and family.',
                  ),
                  SizedBox(height: 15),

                  // Card 5
                  MentalHealthTipCard(
                    title: 'Self-care routine',
                    description: 'Establish a daily self-care routine that includes activities that nourish your mental well-being.',
                  ),
                  SizedBox(height: 15),

                  // Card 6
                  MentalHealthTipCard(
                    title: 'Limit negative thoughts',
                    description: 'Challenge negative self-talk and replace it with positive affirmations.',
                  ),
                  SizedBox(height: 15),

                  // Card 7
                  MentalHealthTipCard(
                    title: 'Seek professional help',
                    description: 'Don\'t hesitate to consult a mental health professional when feeling overwhelmed.',
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

class MentalHealthTipCard extends StatelessWidget {
  final String title;
  final String description;

  const MentalHealthTipCard({
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