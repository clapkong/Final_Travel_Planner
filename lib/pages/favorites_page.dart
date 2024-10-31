import 'package:flutter/material.dart';
import 'package:travel_planner/main.dart';

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
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/carousel_1.jpg'),
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
                            '${favorite['title']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Departure date: ${favorite['date']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Arrival date: ${favorite['date']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Number of people: ${favorite['num_people']}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/*'Search query: ${favorite['country']}, ${favorite['state']}, ${favorite['city']}'*/