import 'package:flutter/material.dart';

class _NutritionTip {
  final String picture;
  final String title;
  final String description;

  const _NutritionTip({
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

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<_NutritionTip> _allTips = [
    _NutritionTip(
      picture: 'assets/images/fitness/cons.webp',
      title: 'Increase fiber intake',
      description:
          'Fiber helps regulate digestion and keeps you feeling full longer. '
          'Include fruits, vegetables, legumes, and whole grains in your daily meals.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/01.webp',
      title: 'Build balanced meals',
      description:
          'Fill your plate with vegetables, lean protein, healthy fats, and '
          'complex carbs to ensure you get all the nutrients your body needs.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/cardio.webp',
      title: 'Stay hydrated',
      description:
          'Drink water consistently throughout the day to support energy, '
          'focus, and overall body function. Aim for at least 8 glasses daily.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/training.webp',
      title: 'Choose whole grains',
      description:
          'Prefer whole grains like oats, brown rice, and quinoa over refined '
          'grains for lasting energy and improved digestive health.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/warm_up.webp',
      title: 'Eat more fruits and vegetables',
      description:
          'Aim for at least five servings of fruits and vegetables a day to '
          'supply your body with essential vitamins, minerals, and antioxidants.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/rest-sleep.webp',
      title: 'Limit processed foods',
      description:
          'Reduce your intake of ultra-processed snacks and fast food, which '
          'are often high in sugar, sodium, and unhealthy fats.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/cons.webp',
      title: 'Control portion sizes',
      description:
          'Be mindful of how much you eat at each meal. Using smaller plates '
          'and eating slowly can help prevent overeating.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/01.webp',
      title: 'Include healthy fats',
      description:
          'Incorporate sources of healthy fats such as avocados, nuts, seeds, '
          'and olive oil to support brain health and hormone production.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/training.webp',
      title: 'Prioritise lean protein',
      description:
          'Choose lean protein sources like chicken, fish, tofu, eggs, and '
          'legumes to support muscle repair and keep you satiated.',
    ),
    _NutritionTip(
      picture: 'assets/images/fitness/cardio.webp',
      title: 'Reduce added sugar',
      description:
          'Cut back on sugary drinks, desserts, and packaged foods. Excess '
          'sugar can lead to weight gain, energy crashes, and inflammation.',
    ),
  ];

  List<_NutritionTip> get _filteredTips =>
      _allTips.where((tip) => tip.matches(_searchQuery)).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTips;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Center(
          child: Text(
            'Nutrition',
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
                  hintText: 'Search nutrition tips…',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  border: InputBorder.none,
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

            // Results label
            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  filtered.isEmpty
                      ? 'No results for "$_searchQuery"'
                      : '${filtered.length} result${filtered.length == 1 ? '' : 's'} for "$_searchQuery"',
                  style: TextStyle(
                    fontSize: 13,
                    color: filtered.isEmpty
                        ? Colors.redAccent
                        : Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            // Tips list
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off,
                              size: 56, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            'No nutrition tips found.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 4),
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
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final tip = filtered[index];
                        return NutritionTipCard(
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

class NutritionTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const NutritionTipCard({
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
              errorBuilder: (context, error, stackTrace) => Container(
                width: 110,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8DDC8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image_outlined,
                    color: Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
