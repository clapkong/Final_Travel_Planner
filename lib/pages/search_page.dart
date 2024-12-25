// lib/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/travel_search_provider.dart';
import '../services/chatgpt_service.dart';
import '../models/travel_search_request.dart';
import 'results_page.dart';

// 즐겨찾기 관련
import '../providers/favorites_provider.dart';

String formatDateRange(DateTime departure, DateTime arrival) {
  return '${formatDate(departure)} - ${formatDate(arrival)}';
}

String formatDate(DateTime date) {
  return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isLoading = false;
  Map<String, dynamic>? _chatGptResult;
  List<dynamic> _travelPlans = [];
  String _currency = "";

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

  bool _customTileExpanded = false;
  final List<String> accommodationLabels = ['호텔', '게스트하우스', '리조트', 'Airbnb'];
  List<String> travelStyleLabels = [
    '휴양 및 힐링',
    '기념일',
    '호캉스',
    '가족여행',
    '관광',
    '역사 탐방'
  ];

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
                : Column(
                    children: <Widget>[
                      _widgetExpansionTile(context, request),
                      const SizedBox(height: 10),
                      _buildSearchResult(),
                    ],
                  ));
  }

  Widget _widgetExpansionTile(
      BuildContext context, TravelSearchRequest request) {
    return ExpansionTile(
      backgroundColor: Colors.cyan[50],
      collapsedBackgroundColor: Colors.cyan[50],
      tilePadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Row(
        children: [
          Icon(Icons.info, color: Colors.cyan.shade900),
          SizedBox(width: 8.0),
          Text(
            'Showing Travel Plans for:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(width: 10),
            Icon(Icons.location_on, color: Colors.cyan[900]!.withOpacity(0.75)),
            SizedBox(width: 8.0),
            Text([request.state, request.country].where((e) => e?.isNotEmpty ?? false).join(", "),
                style: TextStyle(fontSize: 14.0)),
          ]),
          SizedBox(height: 8),
          Row(children: [
            SizedBox(width: 10),
            Icon(Icons.calendar_today,
                color: Colors.cyan[900]!.withOpacity(0.75)),
            SizedBox(width: 8.0),
            Text('${formatDateRange(request.departure, request.arrival)}',
                style: TextStyle(fontSize: 14.0)),
          ]),
          SizedBox(height: 8),
        ],
      ),
      trailing: Icon(
        _customTileExpanded
            ? Icons.arrow_drop_down_circle
            : Icons.arrow_drop_down,
        color: Colors.cyan.shade900,
      ),
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
      children: <Widget>[
        ListTile(
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
                    SizedBox(width: 10.0),
                    Icon(Icons.person, color: Colors.cyan[900]!.withOpacity(0.75)),
                    SizedBox(width: 8.0),
                    Text('인원: ${request.numPeople}명', style: TextStyle(fontSize: 14.0)),
                    SizedBox(width: 16.0),
                    Icon(Icons.paid, color: Colors.cyan[900]!.withOpacity(0.75)),
                    SizedBox(width: 8.0),
                    Text('예산: ${request.budget}만원', style: TextStyle(fontSize: 14.0)),
                    SizedBox(width: 16.0),
                    Icon(Icons.hotel, color: Colors.cyan[900]!.withOpacity(0.75)),
                    SizedBox(width: 8.0),
                    Text('숙소: ${accommodationLabels[request.accommodation]}',
                        style: TextStyle(fontSize: 14.0)),
                  ]),),
                  SizedBox(height: 10),
                  Row(children: [
                    for (int i = 0; i < request.travelStyle.length; i++)
                      if (request.travelStyle[i])
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(travelStyleLabels[i],
                                style: TextStyle(fontSize: 14.0)),
                          ),
                        ),
                  ])
                ])
        ),
      ],
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

    return Expanded(
        child: ListView.builder(
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
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/travel_1.jpg'),
              radius: 28.0,
            ),
            title: Text(
              planName,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                summary,
                style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
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
    ));
  }
}
