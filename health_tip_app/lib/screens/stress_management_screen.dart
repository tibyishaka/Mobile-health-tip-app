import 'package:flutter/material.dart';
import 'package:health_tip_app/widgets/topic_tip_card.dart';

class StressManagementScreen extends StatelessWidget {
  const StressManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            'Stress Management',
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

            // Stress Management Tips Cards
            Expanded(
              child: ListView(
                children: const [
                  // Card 1
                  TopicTipCard(
                    picture: 'assets/images/stress/deep-breathing.webp',
                    title: 'Deep breathing exercises',
                    description:
                        'Practice the 4-7-8 technique: inhale for 4 seconds, hold for 7, exhale for 8 to calm your nervous system.',
                  ),
                  SizedBox(height: 15),

                  // Card 2
                  TopicTipCard(
                    picture: 'assets/images/stress/time-management.webp',
                    title: 'Time management',
                    description:
                        'Break tasks into smaller steps and prioritize to avoid feeling overwhelmed by responsibilities.',
                  ),
                  SizedBox(height: 15),

                  // Card 3
                  TopicTipCard(
                    picture: 'assets/images/stress/exercise.webp',
                    title: 'Physical activity',
                    description:
                        'Regular exercise releases endorphins and helps reduce stress levels naturally.',
                  ),
                  SizedBox(height: 15),

                  // Card 4
                  TopicTipCard(
                    picture:
                        'assets/images/stress/Progressive muscle relaxation.webp',
                    title: 'Progressive muscle relaxation',
                    description:
                        'Tense and then relax each muscle group to release physical tension caused by stress.',
                  ),
                  SizedBox(height: 15),

                  // Card 5
                  TopicTipCard(
                    picture: 'assets/images/stress/Set-boundaries.webp',
                    title: 'Set boundaries',
                    description:
                        'Learn to say no to additional responsibilities when you\'re feeling overwhelmed.',
                  ),
                  SizedBox(height: 15),

                  // Card 6
                  TopicTipCard(
                    picture: 'assets/images/stress/Mindful walking.webp',
                    title: 'Mindful walking',
                    description:
                        'Take a short walk and focus on your surroundings, the sensation of walking, and your breathing.',
                  ),
                  SizedBox(height: 15),

                  // Card 7
                  TopicTipCard(
                    picture: 'assets/images/stress/Listen to music.webp',
                    title: 'Listen to music',
                    description:
                        'Play calming music or nature sounds to reduce stress and improve your mood.',
                  ),
                  SizedBox(height: 15),

                  // Card 8
                  TopicTipCard(
                    picture: 'assets/images/stress/Aromatherapy.webp',
                    title: 'Aromatherapy',
                    description:
                        'Use essential oils like lavender or chamomile to create a calming environment.',
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
