import 'package:flutter/material.dart';
import 'package:travel_planner/main.dart';
import 'package:travel_planner/pages/results_page.dart'; // 결과 페이지 가져오기
import 'package:provider/provider.dart';
import 'package:travel_planner/widgets/itinerary.dart';
import 'package:travel_planner/pseudodata.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _searchQuery = ''; // 검색어를 저장
  late List<dynamic> _filteredFavorites; // 필터링된 즐겨찾기 리스트

  @override
  void initState() {
    super.initState();
    _filteredFavorites = [];
  }

  void _filterFavorites(String query, List<dynamic> favoritesList) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredFavorites = favoritesList;
      } else {
        _filteredFavorites = favoritesList
            .where((favorite) => favorite.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // FavoritesProvider에서 데이터 가져오기
    final favoritesList = context.watch<FavoritesProvider>().favorites;

    // 초기 상태에서 전체 목록을 필터링된 목록으로 설정
    if (_filteredFavorites.isEmpty && _searchQuery.isEmpty) {
      _filteredFavorites = favoritesList;
    }

    return Scaffold(
      appBar: widgetAppBar(context, 'Favorites'),
      body: Column(
        children: [
          // 검색창
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: (query) => _filterFavorites(query, favoritesList),
            ),
          ),
          // 즐겨찾기 목록
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // 좌우 16px 패딩 추가
              child: _filteredFavorites.isEmpty
                ? Center(
                    child: Text(
                      'No favorites found!',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 가로에 2개의 열
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 3 / 2, // 카드의 비율 조정 (가로:세로 비율)
                    ),
                    itemCount: _filteredFavorites.length,
                    itemBuilder: (context, index) {
                      final favorite = _filteredFavorites[index];
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // 스크롤 가능하게 설정
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) => DraggableScrollableSheet(
                              expand: false,
                              initialChildSize: 0.66, // 초기 높이를 화면의 2/3로 설정
                              minChildSize: 0.4, // 최소 높이를 화면의 40%로 설정
                              maxChildSize: 0.9, // 최대 높이를 화면의 90%로 설정
                              builder: (context, scrollController) {
                                return Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '[${favorite.state}] ${favorite.title} 일정',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2, // 길이가 긴 제목도 처리 가능하도록 설정
                overflow: TextOverflow.ellipsis, // 제목이 길면 생략 처리
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // 버튼 색상
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              ),
              onPressed: () {
                // 즐겨찾기 삭제 기능
                context
                    .read<FavoritesProvider>()
                    .removeFavorite(favorite.searchID, favorite.travelPlanID);
                Navigator.pop(context); // Bottom Sheet 닫기
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${favorite.title}가 즐겨찾기에서 삭제되었습니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(Icons.delete, size: 16, color: Colors.white),
              label: Text(
                '삭제',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
                                      Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.cyan[900], size: 18),
                              SizedBox(width: 5),
                              Text('Date: ${favorite.date}', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                                      SizedBox(height: 10),
                                      // ScheduleList를 포함하는 Flexible
                                      Flexible(
                                        child: ScheduleList(
                                          scheduleData: pseudoItinerary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('${favorite.path}'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.35),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                height: double.infinity,
                                width: double.infinity,
                              ),
                              Positioned(
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '[${favorite.state}] ${favorite.title}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, color: Colors.grey),
                                          SizedBox(width: 8.0),
                                          Text(
                                            '${favorite.state}, ${favorite.country}',
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today, color: Colors.grey),
                                          SizedBox(width: 8.0),
                                          Text(
                                            '${favorite.date}',
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
