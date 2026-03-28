import 'dart:convert';
import 'package:flutter/foundation.dart';
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

    // Using gemini-pro (1.0) because the 1.5 models are returning 404 Not Found
    // for this API key's region or tier.
    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
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
    ],
    TipCategory.mentalHealth: [
      'assets/images/mental-health/connection.webp',
      'assets/images/mental-health/counseling.webp',
      'assets/images/mental-health/detox.webp',
      'assets/images/mental-health/journaling.webp',
      'assets/images/mental-health/negative-thoughts.webp',
      'assets/images/mental-health/practice.webp',
      'assets/images/mental-health/self-care-routine.webp',
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
    ],
    TipCategory.nutrition: ['assets/images/fitness/cons.webp'],
    TipCategory.sleep: ['assets/images/fitness/rest-sleep.webp'],
    TipCategory.mindfulness: [
      'assets/images/mental-health/self-care-routine.webp',
      'assets/images/stress/Mindful walking.webp',
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

        List<dynamic> jsonList;
        try {
          jsonList = jsonDecode(cleanText);
        } catch (e) {
          debugPrint('JSON Decode Error: $e');
          debugPrint('Gemini Output was: $textResults');
          return [];
        }

        final pool = _imagePools[category] ?? _imagePools[TipCategory.fitness]!;
        int i = 0;

        return jsonList.map((item) {
          final String assignedImage = pool[i % pool.length];
          i++;

          return HealthTip(
            id: 'gemini_${category.name}_${(item["title"] as String).hashCode.abs()}',
            title: item['title'] ?? 'Health Tip',
            description: item['description'] ?? '',
            imageAsset: assignedImage,
            category: category,
          );
        }).toList();
      }
      return [];
    } catch (e, stacktrace) {
      debugPrint('Error generating tips from Gemini: $e');
      debugPrint('Stacktrace: $stacktrace');
      return [];
    }
  }
}
