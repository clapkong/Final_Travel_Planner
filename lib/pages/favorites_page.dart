import 'package:flutter/material.dart';
import 'package:travel_planner/main.dart';
import 'package:travel_planner/pages/results_page.dart'; // 결과 페이지 가져오기
import 'package:provider/provider.dart';

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultsPage(
                                travelPlan: favorite, // travelPlan 전달
                              ),
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
