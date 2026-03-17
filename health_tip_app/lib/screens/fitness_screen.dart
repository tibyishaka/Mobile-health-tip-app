import 'package:flutter/material.dart';

class _FitnessTip {
  final String picture;
  final String title;
  final String description;

  const _FitnessTip({
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

const List<_FitnessTip> _allFitnessTips = [
  _FitnessTip(
    picture: 'assets/images/fitness/warm_up.webp',
    title: 'Start with warm-up',
    description:
        'Always begin your workout with 5-10 minutes of light cardio and dynamic stretches to prevent injuries.',
  ),
  _FitnessTip(
    picture: 'assets/images/fitness/training.webp',
    title: 'Strength training basics',
    description:
        'Incorporate strength training 2-3 times per week focusing on major muscle groups for balanced development.',
  ),
  _FitnessTip(
    picture: 'assets/images/fitness/cardio.webp',
    title: 'Cardio for heart health',
    description:
        'Aim for at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous activity weekly.',
  ),
  _FitnessTip(
    picture: 'assets/images/fitness/rest-sleep.webp',
    title: 'Rest and recovery',
    description:
        'Take rest days between intense workouts to allow muscles to repair and grow stronger.',
  ),
  _FitnessTip(
    picture: 'assets/images/fitness/01.webp',
    title: 'Proper form matters',
    description:
        'Focus on correct form rather than heavy weights to maximize results and prevent injuries.',
  ),
  _FitnessTip(
    picture: 'assets/images/fitness/cons.webp',
    title: 'Stay consistent',
    description:
        'Create a workout schedule that you can maintain long-term rather than occasional intense sessions.',
  ),
];

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_FitnessTip> get _filteredTips =>
      _allFitnessTips.where((tip) => tip.matches(_searchQuery)).toList();

  @override
  Widget build(BuildContext context) {
    final tips = _filteredTips;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Text(
          'Fitness',
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
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search fitness tips…',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  suffixIcon: _searchQuery.isEmpty
                      ? const Icon(Icons.search,
                          color: Colors.black54, size: 28)
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
            const SizedBox(height: 20),

            // Results count when searching
            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  tips.isEmpty
                      ? 'No results for "$_searchQuery"'
                      : '${tips.length} result${tips.length == 1 ? '' : 's'} for "$_searchQuery"',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            // Tips list or empty state
            Expanded(
              child: tips.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off,
                              size: 56, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            'No tips found.',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Try a different search term.',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: tips.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final tip = tips[index];
                        return FitnessTipCard(
                          picture: tip.picture,
                          title: tip.title,
                          description: tip.description,
                          searchQuery: _searchQuery,
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

class FitnessTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;
  final String searchQuery;

  const FitnessTipCard({
    super.key,
    required this.title,
    required this.description,
    required this.picture,
    this.searchQuery = '',
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
          // Left side – text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HighlightedText(
                  text: title,
                  query: searchQuery,
                  baseStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _HighlightedText(
                  text: description,
                  query: searchQuery,
                  baseStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.green.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Right side – image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              picture,
              width: 110,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 110,
                height: 90,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_outlined, color: Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders [text] with every occurrence of [query] highlighted in yellow.
class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle baseStyle;

  const _HighlightedText({
    required this.text,
    required this.query,
    required this.baseStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return Text(text, style: baseStyle);

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: baseStyle.copyWith(
            backgroundColor: const Color(0xFFFFE082),
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      start = index + query.length;
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
    );
  }
}
