import 'package:flutter/material.dart';
import 'package:travel_planner/main.dart';
import 'package:travel_planner/pages/results_page.dart'; // 결과 페이지 가져오기

class FavoritesPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoritesList;

  FavoritesPage({required this.favoritesList});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan[900]),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 가로에 2개의 열
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 3 / 2, // 카드의 비율 조정 (가로:세로 비율)
          ),
          itemCount: widget.favoritesList.length,
          itemBuilder: (context, index) {
            final favorite = widget.favoritesList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      travelPlan: favorite['travelPlan'], // 해당 정보를 제공하거나 원하는 값으로 설정하세요
                      state: favorite['state'] ?? '',
                      budget: favorite['budget'] ?? 20,
                      numPeople: favorite['num_people'] ?? 1,
                      date: favorite['date'] ?? '',
                      type: favorite['accommodation'] ?? '호텔',
                      travel_style: favorite['travel_style'] ?? [false, false, false, false, false, false],
                      travel_style_labels: ['휴양 및 힐링', '기념일', '호캉스', '가족여행', '관광','역사 탐방'],
                      country: favorite['country'] ?? '',
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
                          image: AssetImage('${favorite['path']}'),
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
                              'Trip to ${favorite['state']} ${favorite['title']}',
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
                                  '${favorite['state']}, ${favorite['country']}',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text(
                                  '${favorite['date']}',
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
