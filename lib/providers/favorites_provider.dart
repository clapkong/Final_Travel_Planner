// lib/providers/favorites_provider.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesItem {
  final String title;
  final String country;
  final String state;
  final String path;
  final String date;
  final int searchID;
  final int travelPlanID;

  // ChatGPT 원본 JSON 저장용 (nullable)
  final Map<String, dynamic>? planData;

  FavoritesItem({
    required this.title,
    required this.country,
    required this.state,
    required this.path,
    required this.date,
    required this.searchID,
    required this.travelPlanID,
    this.planData,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'country': country,
      'state': state,
      'path': path,
      'date': date,
      'searchID': searchID,
      'travelPlanID': travelPlanID,
      'planData': planData != null ? jsonEncode(planData) : null,
    };
  }

  factory FavoritesItem.fromMap(Map<String, dynamic> map) {
    return FavoritesItem(
      title: map['title'],
      country: map['country'],
      state: map['state'],
      path: map['path'],
      date: map['date'],
      searchID: map['searchID'],
      travelPlanID: map['travelPlanID'],
      planData: map['planData'] != null
          ? jsonDecode(map['planData']) as Map<String, dynamic>
          : null,
    );
  }
}

class FavoritesStorage {
  static const _favoritesKey = 'favoritesList';

  static Future<void> saveFavorites(List<FavoritesItem> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        favorites.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList(_favoritesKey, jsonList);
  }

  static Future<List<FavoritesItem>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_favoritesKey);
    if (jsonList == null) return [];
    return jsonList
        .map((item) => FavoritesItem.fromMap(jsonDecode(item)))
        .toList();
  }

  static Future<void> addFavorite(FavoritesItem item) async {
    final favorites = await loadFavorites();
    favorites.add(item);
    await saveFavorites(favorites);
  }

  static Future<void> removeFavorite(int searchID, int travelPlanID) async {
    final favorites = await loadFavorites();
    favorites.removeWhere((item) =>
        item.searchID == searchID && item.travelPlanID == travelPlanID);
    await saveFavorites(favorites);
  }
}

class FavoritesProvider extends ChangeNotifier {
  List<FavoritesItem> _favorites = [];
  List<FavoritesItem> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favorites = await FavoritesStorage.loadFavorites();
    notifyListeners();
  }

  void addFavorite(FavoritesItem item) async {
    _favorites.add(item);
    await FavoritesStorage.saveFavorites(_favorites);
    notifyListeners();
  }

  void removeFavorite(int searchID, int travelPlanID) async {
    _favorites.removeWhere((item) =>
        item.searchID == searchID && item.travelPlanID == travelPlanID);
    await FavoritesStorage.saveFavorites(_favorites);
    notifyListeners();
  }

  bool isFavorite(int searchID, int travelPlanID) {
    return _favorites.any((item) =>
        item.searchID == searchID && item.travelPlanID == travelPlanID);
  }
}
