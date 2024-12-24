// lib/services/chatgpt_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/travel_search_request.dart';

class ChatGPTService {
  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';
  // 실제 발급받은 키로 교체하세요
  static const String _apiKey =
      '';

  Future<Map<String, dynamic>> fetchTravelPlan(
      TravelSearchRequest request) async {
    final prompt = _buildPrompt(request);

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": prompt}
        ],
        "max_tokens": 2000,
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseBody = jsonDecode(decodedBody);

      final String assistantMessage =
          responseBody["choices"][0]["message"]["content"];

      debugPrint("===== ChatGPT Raw JSON String =====");
      debugPrint(assistantMessage);

      try {
        final parsedJson = jsonDecode(assistantMessage);
        return {
          "assistantMessageRaw": assistantMessage,
          "assistantMessageParsed": parsedJson,
        };
      } catch (e) {
        debugPrint('JSON 파싱 에러: $e');
        throw Exception('ChatGPT 응답이 유효한 JSON 형식이 아닙니다.');
      }
    } else {
      throw Exception(
          'Failed to get travel plan from ChatGPT. Code: ${response.statusCode}');
    }
  }

  /// 프롬프트를 구성
  String _buildPrompt(TravelSearchRequest request) {
    // 날짜 차이 계산 (며칠짜리 여행인지)
    final daysCount = request.arrival.difference(request.departure).inDays + 1;
    // 예: 3박4일 => arrival - departure = 3일 차이이므로 +1 = 4일

    return '''
아래 조건에 맞추어 여러 가지(예: 2개 이상) 여행 일정을 JSON으로 만들어줘.
배열로 travelPlans를 만들어서, 예: "travelPlans": [ {...}, {...}, ... ]

[조건들]
1) 전체 여행 기간(예: 3박4일)이 ${request.budget} ${request.currency} 내외로 맞춰지도록:
   - 하루 경비 = (숙박비 + 식사비 + 일정(입장료, 체험비 등)) 총합
   - 각 day마다 "totalPrice"로 표시, 모든 day 합산이 ${request.budget} ${request.currency} 근처가 되도록.
   - 여행일수는 ${daysCount}일 (day=1..${daysCount})에 해당하도록.

2) 하루 일정은 (아침 9시 ~ 저녁 9시) 사이에 3~5개 이상 활동 구성하되, **이동 거리가 너무 길지 않도록**.
   - 예: 홍대 주변이면 신촌/연남동 정도, 강남이면 그 근방에서만 이동.

3) 숙소는 **실제로 존재하는 호텔**을 사용 (예: 서울 -> 롯데호텔, 부산 -> 파라다이스호텔 등).
   - "hotel" 필드에 { "name", "checkin", "checkout", "location", "pricePerNight" } 형태로 기재.
   - 하루 숙박비를 "pricePerNight"로 표기하고, "totalPrice" 계산 시 포함.

4) 식사(점심/저녁)는 일정 동선을 고려하여, (이전 일정 장소)와 (다음 일정 장소) 사이 또는 근처에 있는 실제 식당으로 잡아주면 좋음.
    - 중복되는 일정이 없었으면 좋겠음. day 1이나 이전에 갔던 곳은 day 2에서는 가지 말 것. 매 일자마다 항상 다른 곳을 가야함.

5) JSON 구조 예시:
{
  "travelPlans": [
    {
      "name": "일정 이름",
      "keyword": "예: 연인, 가족, etc",
      "budget": 500000,
      "hotel": "대표 숙소 이름(필수 아님)",
      "summary": "...",
      "days": [
        {
          "day": 1,
          "hotel": {
            "name": "실제 호텔 명",
            "checkin": "14:00",
            "checkout": "12:00",
            "location": "...",
            "pricePerNight": 100000
          },
          "totalPrice": 120000,
          "itinerary": [
            {
              "index": 0,
              "time": "09:00 - 09:00",
              "title": "조식",
              "location": "숙소 내 레스토랑",
              "cost": 10000
            },
            {
              "index": 1,
              "time": "09:30 - 11:00",
              "title": "가까운 관광지 방문",
              "location": "...",
              "cost": 3000
            },
            {
              "index": 2,
              "time": "12:00 - 13:00",
              "title": "점심 식사",
              "location": "가까운 식당",
              "cost": 15000
            },
            ...
          ]
        },
        ...
      ]
    }
  ]
}


[입력값]
- 출발일: ${request.departure}
- 도착일: ${request.arrival}
- 여행일수: ${daysCount}일
- 국가/도시: ${request.country}, ${request.city}
- 인원: ${request.numPeople}명
- 예산: ${request.budget} ${request.currency}
- 숙소 index: ${request.accommodation}
- 여행 스타일: ${request.travelStyle}
- 추가 요구사항: ${request.command}

사용자가 추가로 남긴 요구사항: ${request.command}

이 조건을 지켜서 구체적으로 JSON 만들어줘. (이미지 정보는 없이 해줘)
JSON만 반환하고, 다른 문장은 쓰지마.
''';
  }
}
