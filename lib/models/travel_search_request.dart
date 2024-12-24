// lib/models/travel_search_request.dart
import 'package:flutter/foundation.dart';

class TravelSearchRequest {
  final DateTime departure;
  final DateTime arrival;
  final String country;
  final String state;
  final String city;
  final int numPeople;
  final double budget;
  final String currency;
  final int accommodation;
  final List<bool> travelStyle;
  final String command;

  TravelSearchRequest({
    required this.departure,
    required this.arrival,
    required this.country,
    required this.state,
    required this.city,
    required this.numPeople,
    required this.budget,
    required this.currency,
    required this.accommodation,
    required this.travelStyle,
    required this.command,
  });
}
