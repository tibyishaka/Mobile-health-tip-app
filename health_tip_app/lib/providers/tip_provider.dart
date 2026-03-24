import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TipProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;

  TipProvider() {
    _loadFavorites();
  }

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
