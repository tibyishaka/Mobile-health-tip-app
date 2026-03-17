import 'package:flutter/material.dart';
import 'package:health_tip_app/widgets/topic_tip_card.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Center(
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

            // Mental Health Tips Cards
            Expanded(
              child: ListView(
                children: const [
                  // Card 1
                  TopicTipCard(
                    picture: 'assets/images/mental-health/practice.webp',
                    title: 'Practice mindfulness',
                    description:
                        'Take 10 minutes daily to focus on the present moment through meditation or deep breathing exercises.',
                  ),
                  SizedBox(height: 15),

                  // Card 2
                  TopicTipCard(
                    picture: 'assets/images/mental-health/detox.webp',
                    title: 'Digital detox',
                    description:
                        'Set aside time each day to disconnect from screens and engage in offline activities you enjoy.',
                  ),
                  SizedBox(height: 15),

                  // Card 3
                  TopicTipCard(
                    picture: 'assets/images/mental-health/journaling.webp',
                    title: 'Gratitude journaling',
                    description:
                        'Write down three things you\'re grateful for each day to cultivate a positive mindset.',
                  ),
                  SizedBox(height: 15),

                  // Card 4
                  TopicTipCard(
                    picture: 'assets/images/mental-health/connection.webp',
                    title: 'Connect with others',
                    description:
                        'Maintain strong social connections by regularly reaching out to friends and family.',
                  ),
                  SizedBox(height: 15),

                  // Card 5
                  TopicTipCard(
                    picture:
                        'assets/images/mental-health/self-care-routine.webp',
                    title: 'Self-care routine',
                    description:
                        'Establish a daily self-care routine that includes activities that nourish your mental well-being.',
                  ),
                  SizedBox(height: 15),

                  // Card 6
                  TopicTipCard(
                    picture:
                        'assets/images/mental-health/negative-thoughts.webp',
                    title: 'Limit negative thoughts',
                    description:
                        'Challenge negative self-talk and replace it with positive affirmations.',
                  ),
                  SizedBox(height: 15),

                  // Card 7
                  TopicTipCard(
                    picture: 'assets/images/mental-health/counseling.webp',
                    title: 'Seek professional help',
                    description:
                        'Don\'t hesitate to consult a mental health professional when feeling overwhelmed.',
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
