import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_tip_app/models/health_tip.dart';
import 'package:health_tip_app/services/gemini_service.dart';

class TipProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};
  final Map<TipCategory, List<HealthTip>> _geminiTips = {};
  final Map<TipCategory, bool> _isLoadingGemini = {};
  final Map<TipCategory, String?> _geminiErrors = {};
  final GeminiService _geminiService = GeminiService();

  Set<String> get favoriteIds => _favoriteIds;

  TipProvider() {
    _loadFavorites();
  }

  Future<void> fetchGeminiTipsForCategory(TipCategory category) async {
    if (_geminiTips.containsKey(category) ||
        (_isLoadingGemini[category] ?? false)) {
      return; // Already fetched or fetching
    }

    _isLoadingGemini[category] = true;
    // We notify listeners using a post-frame callback or directly since this might trigger a rebuild
    Future.microtask(() => notifyListeners());

    try {
      // Fetch 15 AI tips to ensure there are plenty per category
      final tips = await _geminiService.generateHealthTips(category, count: 15);
      _geminiTips[category] = tips;
      _geminiErrors.remove(category);
    } catch (e) {
      debugPrint('Error fetching gemini tips for $category: $e');
      _geminiTips[category] = [];
      _geminiErrors[category] = e.toString();
    } finally {
      _isLoadingGemini[category] = false;
      notifyListeners();
    }
  }

  List<HealthTip> getGeminiTips(TipCategory category) {
    return _geminiTips[category] ?? [];
  }

  /// Returns the list of categories for which Gemini tips have been cached.
  List<TipCategory> getAllCachedCategories() => _geminiTips.keys.toList();

  bool isLoadingGemini(TipCategory category) {
    return _isLoadingGemini[category] ?? false;
  }

  String? getGeminiError(TipCategory category) => _geminiErrors[category];

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList('favorite_tips');
    if (saved != null) {
      _favoriteIds.addAll(saved);
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String id) async {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_tips', _favoriteIds.toList());
  }

  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }
}
