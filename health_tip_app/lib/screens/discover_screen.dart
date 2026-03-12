import 'package:flutter/material.dart';
import 'package:health_tip_app/screens/fitness_screen.dart';
import 'package:health_tip_app/screens/mental_health_screen.dart';
import 'package:health_tip_app/screens/stress_management_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      _DiscoverTopic('Nutrition', 'assets/images/fitness/cons.webp'),
      _DiscoverTopic('Sleep', 'assets/images/fitness/rest-sleep.webp'),
      _DiscoverTopic('Fitness', 'assets/images/fitness/training.webp'),
      _DiscoverTopic(
        'Mental Health',
        'assets/images/mental-health/practice.webp',
      ),
      _DiscoverTopic(
        'Stress Management',
        'assets/images/stress/deep-breathing.webp',
      ),
      _DiscoverTopic(
        'Mindfulness',
        'assets/images/mental-health/self-care-routine.webp',
      ),
    ];

    return Container(
      color: const Color(0xFFF3F5F2),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: Column(
        children: [
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Search for topics',
              hintStyle: TextStyle(color: Colors.green.shade300, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFDDE5DE),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              suffixIcon: const Icon(Icons.search, color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              itemCount: topics.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.86,
              ),
              itemBuilder: (context, index) {
                final topic = topics[index];
                return _TopicCard(
                  topic: topic,
                  onTap: () => _handleTopicTap(context, topic.title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleTopicTap(BuildContext context, String topicTitle) {
    Widget? destination;

    switch (topicTitle) {
      case 'Mental Health':
        destination = const MentalHealthScreen();
        break;
      case 'Fitness':
        destination = const FitnessScreen();
        break;
      case 'Stress Management':
        destination = const StressManagementScreen();
        break;
      default:
        destination = null;
    }

    if (destination != null) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => destination!));
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$topicTitle details coming soon')));
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic, required this.onTap});

  final _DiscoverTopic topic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: const Color(0xFFE8DDC8),
                  child: Image.asset(
                    topic.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.black45,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              topic.title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscoverTopic {
  const _DiscoverTopic(this.title, this.imagePath);

  final String title;
  final String imagePath;
}