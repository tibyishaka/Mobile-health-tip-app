import 'package:flutter/material.dart';

class MindfulnessScreen extends StatelessWidget {
  const MindfulnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Center(
          child: Text(
            'Mindfulness',
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for topics',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                        size: 28,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),

            // Mindfulness tips cards
            Expanded(
              child: ListView(
                children: const [
                  MindfulnessTipCard(
                    picture: 'assets/images/mental-health/practice.webp',
                    title: 'Practice deep breathing',
                    description:
                        'Take slow, deep breaths for a few minutes to calm the mind and body.',
                  ),
                  SizedBox(height: 15),
                  MindfulnessTipCard(
                    picture:
                        'assets/images/mental-health/self-care-routine.webp',
                    title: 'Try meditation',
                    description:
                        'Begin with five minutes daily and gradually increase your practice time.',
                  ),
                  SizedBox(height: 15),
                  MindfulnessTipCard(
                    picture: 'assets/images/mental-health/journaling.webp',
                    title: 'Journal your thoughts',
                    description:
                        'Write down thoughts and emotions to increase awareness and reduce stress.',
                  ),
                  SizedBox(height: 15),
                  MindfulnessTipCard(
                    picture: 'assets/images/mental-health/connection.webp',
                    title: 'Be present in the moment',
                    description:
                        'Focus on what you can see, hear, and feel without judging the experience.',
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

class MindfulnessTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const MindfulnessTipCard({
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
