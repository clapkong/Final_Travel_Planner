// lib/providers/travel_search_provider.dart
import 'package:flutter/foundation.dart';
import '../models/travel_search_request.dart';

class TravelSearchProvider with ChangeNotifier {
  TravelSearchRequest? _request;

  TravelSearchRequest? get request => _request;

  void updateRequest(TravelSearchRequest req) {
    _request = req;
    notifyListeners();
  }
}
