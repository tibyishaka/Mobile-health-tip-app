import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/screens/main_screen.dart';

class GettingStartedScreen extends StatefulWidget {
  const GettingStartedScreen({super.key});

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  final Set<String> _selectedKeys = {'topicMentalHealth'};
  bool _isSaving = false;

  Future<void> _completeOnboarding() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'showGettingStarted': false,
          'onboardingCompletedAt': FieldValue.serverTimestamp(),
          'interests': _selectedKeys.toList(),
        }, SetOptions(merge: true));
      }

      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    final List<_InterestTopic> topics = [
      _InterestTopic(
        'topicNutrition',
        l.topicNutrition,
        'assets/images/fitness/cons.webp',
      ),
      _InterestTopic(
        'topicSleep',
        l.topicSleep,
        'assets/images/fitness/rest-sleep.webp',
      ),
      _InterestTopic(
        'topicFitness',
        l.topicFitness,
        'assets/images/fitness/training.webp',
      ),
      _InterestTopic(
        'topicMentalHealth',
        l.topicMentalHealth,
        'assets/images/mental-health/practice.webp',
      ),
      _InterestTopic(
        'topicStressManagement',
        l.topicStressManagement,
        'assets/images/stress/deep-breathing.webp',
      ),
      _InterestTopic(
        'topicMindfulness',
        l.topicMindfulness,
        'assets/images/mental-health/self-care-routine.webp',
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
          child: Column(
            children: [
              Text(
                l.selectInterests,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l.chooseTopicsDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: topics.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.86,
                  ),
                  itemBuilder: (context, index) {
                    final topic = topics[index];
                    final selected = _selectedKeys.contains(topic.key);
                    return _InterestCard(
                      topic: topic,
                      selected: selected,
                      onTap: () {
                        setState(() {
                          if (selected) {
                            _selectedKeys.remove(topic.key);
                          } else {
                            _selectedKeys.add(topic.key);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF82),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isSaving ? null : _completeOnboarding,
                  child: _isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          l.getStarted,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InterestCard extends StatelessWidget {
  const _InterestCard({
    required this.topic,
    required this.selected,
    required this.onTap,
  });

  final _InterestTopic topic;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF4CAF82)
                      : Colors.transparent,
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF5F7FA),
                  child: Image.asset(
                    topic.imagePath,
                    fit: BoxFit.cover,
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
          ),
          const SizedBox(height: 4),
          Text(
            topic.title,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _InterestTopic {
  const _InterestTopic(this.key, this.title, this.imagePath);

  final String key;
  final String title;
  final String imagePath;
}
