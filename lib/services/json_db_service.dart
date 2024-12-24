// lib/services/json_db_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class JsonDbService {
  final String baseUrl = 'http://localhost:3000'; // or your server IP

  /// user_search에 새 검색을 추가하고, 생성된 search_id(문자열) 반환
  Future<String> insertUserSearch(Map<String, dynamic> userSearchData) async {
    final url = Uri.parse('$baseUrl/user_search');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userSearchData),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data.containsKey('id')) {
          // id 가 "7290" 등 문자열로 넘어올 수 있으므로
          return data['id'].toString();
        } else {
          throw Exception('Response does not contain "id". Response: $data');
        }
      } else {
        throw Exception(
            'Failed to create user_search. Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('insertUserSearch error: $e');
      rethrow;
    }
  }

  /// travel_plans에 새 travel plan을 추가하고, 생성된 id(문자열) 반환
  Future<String> insertTravelPlan(Map<String, dynamic> travelPlanData) async {
    final url = Uri.parse('$baseUrl/travel_plans');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(travelPlanData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data.containsKey('id')) {
          return data['id'].toString();
        } else {
          throw Exception('Response does not contain "id". Response: $data');
        }
      } else {
        throw Exception(
            'Failed to create travel_plan. code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('insertTravelPlan error: $e');
      rethrow;
    }
  }

  /// travel_itinery에 일정 정보 추가: { "[id]": {Day1:[], Day2:[]...} } 구조
  /// planId도 String으로 받도록 수정
  Future<void> insertTravelItinery(
      String planId, Map<String, dynamic> dayItinerary) async {
    final url = Uri.parse('$baseUrl/travel_itinery');
    try {
      // 1) 기존 전체 데이터 GET
      final getResponse = await http.get(url);
      if (getResponse.statusCode == 200) {
        Map<String, dynamic> itineryData = jsonDecode(getResponse.body);
        // ex) { "1": {...}, "8": {...} }

        // 2) planId (string) 을 key로 추가
        itineryData[planId] = dayItinerary;

        // 3) PUT (전체 덮어쓰기)
        final putResponse = await http.put(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(itineryData),
        );
        if (putResponse.statusCode != 200 && putResponse.statusCode != 201) {
          throw Exception(
              'Failed to update travel_itinery. code: ${putResponse.statusCode}');
        }
      } else {
        throw Exception(
            'Failed to get travel_itinery data. code: ${getResponse.statusCode}');
      }
    } catch (e) {
      debugPrint('insertTravelItinery error: $e');
      rethrow;
    }
  }
}
