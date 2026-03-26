import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health_tip_app/models/health_tip.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      throw Exception('GEMINI_API_KEY is not set in the .env file');
    }

    // Using the recommended gemini-1.5-pro for better reasoning and text generation
    _model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
  }

  // Large pool of dynamic online and offline image assets to cycle through
  static const Map<TipCategory, List<String>> _imagePools = {
    TipCategory.fitness: [
      'assets/images/fitness/01.webp',
      'assets/images/fitness/cardio.webp',
      'assets/images/fitness/cons.webp',
      'assets/images/fitness/rest-sleep.webp',
      'assets/images/fitness/training.webp',
      'assets/images/fitness/warm_up.webp',
      'https://images.unsplash.com/photo-1517836357463-d25dfe09ce14?w=500&q=80',
      'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500&q=80',
      'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500&q=80',
    ],
    TipCategory.mentalHealth: [
      'assets/images/mental-health/connection.webp',
      'assets/images/mental-health/counseling.webp',
      'assets/images/mental-health/detox.webp',
      'assets/images/mental-health/journaling.webp',
      'assets/images/mental-health/negative-thoughts.webp',
      'assets/images/mental-health/practice.webp',
      'assets/images/mental-health/self-care-routine.webp',
      'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=500&q=80',
      'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=500&q=80',
    ],
    TipCategory.stressManagement: [
      'assets/images/stress/Aromatherapy.webp',
      'assets/images/stress/deep-breathing.webp',
      'assets/images/stress/exercise.webp',
      'assets/images/stress/Listen to music.webp',
      'assets/images/stress/Mindful walking.webp',
      'assets/images/stress/Progressive muscle relaxation.webp',
      'assets/images/stress/Set-boundaries.webp',
      'assets/images/stress/time-management.webp',
      'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=500&q=80',
    ],
    TipCategory.nutrition: [
      'assets/images/fitness/cons.webp',
      'https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=500&q=80',
      'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500&q=80',
      'https://images.unsplash.com/photo-1498837167922-41c012202392?w=500&q=80',
      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=500&q=80',
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500&q=80',
      'https://images.unsplash.com/photo-1478144592103-25e218a04891?w=500&q=80',
      'https://images.unsplash.com/photo-1556910103-1c02745a872f?w=500&q=80',
    ],
    TipCategory.sleep: [
      'assets/images/fitness/rest-sleep.webp',
      'https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?w=500&q=80',
      'https://images.unsplash.com/photo-1511295742362-92c96b124e41?w=500&q=80',
      'https://images.unsplash.com/photo-1520206183501-b80df61043c2?w=500&q=80',
      'https://images.unsplash.com/photo-1626887532395-654dbba66cd8?w=500&q=80',
      'https://images.unsplash.com/photo-1505018620898-92616e184fa4?w=500&q=80',
      'https://images.unsplash.com/photo-1455217431268-3e4b7b3992ed?w=500&q=80',
      'https://images.unsplash.com/photo-1552857462-fd82c3c6f62b?w=500&q=80',
    ],
    TipCategory.mindfulness: [
      'assets/images/mental-health/self-care-routine.webp',
      'assets/images/stress/Mindful walking.webp',
      'https://images.unsplash.com/photo-1508672019048-805c876b67e2?w=500&q=80',
      'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=500&q=80',
      'https://images.unsplash.com/photo-1515023115689-589c33041d3c?w=500&q=80',
      'https://images.unsplash.com/photo-1528319725582-ddc096101511?w=500&q=80',
      'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=500&q=80',
      'https://images.unsplash.com/photo-1447023029226-ef8f6b52e3ea?w=500&q=80',
    ],
  };

  /// Generate a list of health tips for a specific category
  Future<List<HealthTip>> generateHealthTips(
    TipCategory category, {
    int count = 5,
  }) async {
    final categoryName = category.toString().split('.').last;
    final prompt =
        '''
You are a professional health and wellness expert.
Provide an array of $count actionable, concise, and highly effective health tips regarding "$categoryName".
Format the output STRICTLY as a JSON array of objects with exactly two keys: "title" and "description". Do not use markdown blocks like ```json.
Example:
[
  {"title": "Sample Title 1", "description": "Sample description 1"},
  {"title": "Sample Title 2", "description": "Sample description 2"}
]
''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      if (response.text != null) {
        final textResults = response.text!.trim();
        final cleanText = textResults
            .replaceAll(RegExp(r'```json\s*'), '')
            .replaceAll(RegExp(r'\s*```'), '');

        final List<dynamic> jsonList = jsonDecode(cleanText);

        final pool = _imagePools[category] ?? _imagePools[TipCategory.fitness]!;
        int i = 0;

        return jsonList.map((item) {
          final String assignedImage = pool[i % pool.length];
          i++;

          return HealthTip(
            id: 'gemini_\${DateTime.now().millisecondsSinceEpoch}_\${item["title"].hashCode}',
            title: item['title'] ?? 'Health Tip',
            description: item['description'] ?? '',
            imageAsset: assignedImage,
            category: category,
          );
        }).toList();
      }
      return [];
    } catch (e) {
      print('Error generating tips from Gemini: \$e');
      return [];
    }
  }
}
