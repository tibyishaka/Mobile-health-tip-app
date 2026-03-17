import 'package:flutter/material.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Center(
          child: Text(
            'Sleep',
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

            // Sleep tips cards
            Expanded(
              child: ListView(
                children: const [
                  SleepTipCard(
                    picture: 'assets/images/fitness/rest-sleep.webp',
                    title: 'Establish a bedtime routine',
                    description:
                        'Go to bed and wake up at the same time daily, including weekends.',
                  ),
                  SizedBox(height: 15),
                  SleepTipCard(
                    picture: 'assets/images/mental-health/detox.webp',
                    title: 'Limit screen time before bed',
                    description:
                        'Avoid screens at least one hour before sleep to reduce blue light exposure.',
                  ),
                  SizedBox(height: 15),
                  SleepTipCard(
                    picture: 'assets/images/fitness/warm_up.webp',
                    title: 'Create a wind-down routine',
                    description:
                        'Use calming habits like light stretching or reading before bedtime.',
                  ),
                  SizedBox(height: 15),
                  SleepTipCard(
                    picture: 'assets/images/fitness/01.webp',
                    title: 'Keep your room cool',
                    description:
                        'A cool, dark room helps you fall asleep faster and sleep more deeply.',
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

class SleepTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const SleepTipCard({
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
