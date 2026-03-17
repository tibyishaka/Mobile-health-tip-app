import 'package:flutter/material.dart';
import 'package:health_tip_app/widgets/topic_tip_card.dart';

class _StressTip {
  final String picture;
  final String title;
  final String description;

  const _StressTip({
    required this.picture,
    required this.title,
    required this.description,
  });

  bool matches(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return title.toLowerCase().contains(q) ||
        description.toLowerCase().contains(q);
  }
}

class StressManagementScreen extends StatefulWidget {
  const StressManagementScreen({super.key});

  @override
  State<StressManagementScreen> createState() => _StressManagementScreenState();
}

class _StressManagementScreenState extends State<StressManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<_StressTip> _allTips = [
    _StressTip(
      picture: 'assets/images/stress/deep-breathing.webp',
      title: 'Deep breathing exercises',
      description:
          'Practice the 4-7-8 technique: inhale for 4 seconds, hold for 7, exhale for 8 to calm your nervous system.',
    ),
    _StressTip(
      picture: 'assets/images/stress/time-management.webp',
      title: 'Time management',
      description:
          'Break tasks into smaller steps and prioritize to avoid feeling overwhelmed by responsibilities.',
    ),
    _StressTip(
      picture: 'assets/images/stress/exercise.webp',
      title: 'Physical activity',
      description:
          'Regular exercise releases endorphins and helps reduce stress levels naturally.',
    ),
    _StressTip(
      picture: 'assets/images/stress/Progressive muscle relaxation.webp',
      title: 'Progressive muscle relaxation',
      description:
          'Tense and then relax each muscle group to release physical tension caused by stress.',
    ),
    _StressTip(
      picture: 'assets/images/stress/Set-boundaries.webp',
      title: 'Set boundaries',
      description:
          'Learn to say no to additional responsibilities when you\'re feeling overwhelmed.',
    ),
    _StressTip(
      picture: 'assets/images/stress/Mindful walking.webp',
      title: 'Mindful walking',
      description:
          'Take a short walk and focus on your surroundings, the sensation of walking, and your breathing.',
    ),
    _StressTip(
      picture: 'assets/images/stress/Listen to music.webp',
      title: 'Listen to music',
      description:
          'Play calming music or nature sounds to reduce stress and improve your mood.',
    ),
    _StressTip(
      picture: 'assets/images/stress/Aromatherapy.webp',
      title: 'Aromatherapy',
      description:
          'Use essential oils like lavender or chamomile to create a calming environment.',
    ),
  ];

  List<_StressTip> get _filteredTips =>
      _allTips.where((tip) => tip.matches(_searchQuery)).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTips = _filteredTips;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Text(
          'Stress Management',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search stress tips…',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 16),
                    border: InputBorder.none,
                    suffixIcon: _searchQuery.isEmpty
                        ? const Icon(Icons.search,
                            color: Colors.black54, size: 26)
                        : IconButton(
                            icon: const Icon(Icons.close,
                                color: Colors.black54, size: 24),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          ),
                  ),
                ),
              ),
            ),

            // Tips list
            Expanded(
              child: filteredTips.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off,
                              size: 56, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            'No tips found for "$_searchQuery"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Try a different keyword.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredTips.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final tip = filteredTips[index];
                        return TopicTipCard(
                          picture: tip.picture,
                          title: tip.title,
                          description: tip.description,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
