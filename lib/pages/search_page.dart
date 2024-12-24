// lib/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/travel_search_provider.dart';
import '../services/chatgpt_service.dart';
import '../models/travel_search_request.dart';
import 'results_page.dart';

// 즐겨찾기 관련
import '../providers/favorites_provider.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isLoading = false;
  Map<String, dynamic>? _chatGptResult;
  List<dynamic> _travelPlans = [];

  @override
  void initState() {
    super.initState();
    _fetchPlanFromChatGPT();
  }

  Future<void> _fetchPlanFromChatGPT() async {
    setState(() {
      _isLoading = true;
    });

    final request = context.read<TravelSearchProvider>().request;
    if (request == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // ChatGPT 응답 받아오기
      final response = await ChatGPTService().fetchTravelPlan(request);
      _chatGptResult = response["assistantMessageParsed"];

      // "travelPlans" 배열 파싱
      if (_chatGptResult != null &&
          _chatGptResult!.containsKey("travelPlans")) {
        _travelPlans = _chatGptResult!["travelPlans"];
      }
    } catch (e) {
      print("Error fetching plan: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<TravelSearchProvider>().request;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (request == null)
              ? Center(child: Text('Home Page에서 정보를 입력하세요'))
              : _buildSearchResult(),
    );
  }

  Widget _buildSearchResult() {
    // 아무 일정도 없으면 안내 문구
    if (_travelPlans.isEmpty) {
      return Center(child: Text('No travel plans found.'));
    }

    // 유저가 입력한 요청
    final request = context.read<TravelSearchProvider>().request!;

    // 이번 검색에 대한 고유 searchID(예: departure기준)
    // => 모든 플랜은 동일한 searchID를 갖되, "travelPlanID"만 달라짐
    final int searchID = request.departure.millisecondsSinceEpoch;

    return ListView.builder(
      itemCount: _travelPlans.length,
      itemBuilder: (context, index) {
        final plan = _travelPlans[index];
        final planName = plan["name"] ?? "No name";
        final summary = plan["summary"] ?? "";

        // 해당 plan의 id
        final travelPlanID = index;

        // 즐겨찾기 여부
        final isFav = context
            .watch<FavoritesProvider>()
            .isFavorite(searchID, travelPlanID);

        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(planName),
            subtitle: Text(summary),
            onTap: () {
              // 상세페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(travelPlan: plan),
                ),
              );
            },
            // -----------------------------
            // 하트 아이콘 (즐겨찾기 토글)
            // -----------------------------
            trailing: IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
              onPressed: () {
                // 날짜 문자열 예시
                final dateString =
                    "${request.departure.year}.${request.departure.month}.${request.departure.day}"
                    " - ${request.arrival.year}.${request.arrival.month}.${request.arrival.day}";

                if (isFav) {
                  // 이미 즐겨찾기라면 => 제거
                  context
                      .read<FavoritesProvider>()
                      .removeFavorite(searchID, travelPlanID);
                } else {
                  // 아직 즐겨찾기가 아니라면 => 추가
                  final newFavorite = FavoritesItem(
                    title: planName,
                    country: request.country,
                    state: request.state,
                    path: 'assets/images/travel_1.jpg',
                    date: dateString,
                    searchID: searchID,
                    travelPlanID: travelPlanID,
                    planData: plan, // ChatGPT 원본 JSON
                  );
                  context.read<FavoritesProvider>().addFavorite(newFavorite);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
