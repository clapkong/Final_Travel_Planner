import 'package:flutter/material.dart';
import 'package:travel_planner/main.dart';
import 'package:travel_planner/pages/results_page.dart'; // 결과 페이지 가져오기
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}
class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    // FavoritesProvider에서 데이터 가져오기
    final favoritesList = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan[900]),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.75),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favoritesList.isEmpty
            ? Center(
                child: Text(
                  '즐겨찾기를 추가해주세요!',
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
                itemCount: favoritesList.length,
                itemBuilder: (context, index) {
                  final favorite = favoritesList[index];
                  return GestureDetector(
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(
                            travelPlan: favorite, // travelPlan 전달
                          ),
                        ),
                      );*/
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
    );
  }
}