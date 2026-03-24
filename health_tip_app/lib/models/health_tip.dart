enum TipCategory {
  fitness,
  nutrition,
  mentalHealth,
  sleep,
  stressManagement,
  mindfulness,
}

class HealthTip {
  final String id;
  final String title;
  final String description;
  final String imageAsset;
  final TipCategory category;
  bool isFavorite;

  HealthTip({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.category,
    this.isFavorite = false,
  });

  bool matches(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return title.toLowerCase().contains(q) ||
        description.toLowerCase().contains(q);
  }
}
