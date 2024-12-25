// lib/pages/favorites_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/itinerary.dart';

/// 예시 pseudodata
import '../pseudodata.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _searchQuery = '';
  late List<dynamic> _filteredFavorites;

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
            .where((favorite) =>
                favorite.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesList = context.watch<FavoritesProvider>().favorites;

    if (_filteredFavorites.isEmpty && _searchQuery.isEmpty) {
      _filteredFavorites = favoritesList;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
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
          Expanded(
            child: _filteredFavorites.isEmpty
                ? Center(
                    child: Text(
                      'No favorites found!',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredFavorites.length,
                    itemBuilder: (context, index) {
                      final favorite = _filteredFavorites[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            '[${favorite.state}] ${favorite.title}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    '${favorite.state}, ${favorite.country}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      size: 14, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    '${favorite.date}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage(favorite.path), // 임의 이미지
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<FavoritesProvider>().removeFavorite(
                                  favorite.searchID, favorite.travelPlanID);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('즐겨찾기에서 삭제되었습니다.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) => DraggableScrollableSheet(
                                expand: false,
                                initialChildSize: 0.66,
                                minChildSize: 0.4,
                                maxChildSize: 0.9,
                                builder: (context, scrollController) {
                                  return Container(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '[${favorite.state}] ${favorite.title} 일정',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today,
                                                color: Colors.cyan[900],
                                                size: 18),
                                            SizedBox(width: 5),
                                            Text('Date: ${favorite.date}',
                                                style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(
                                          child: favorite.planData != null
                                              ? _buildChatGptSchedule(
                                                  favorite.planData!,
                                                )
                                              : _buildPseudoDataSchedule(
                                                  favorite.travelPlanID),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatGptSchedule(Map<String, dynamic> planData) {
    final Map<String, dynamic> dayMap = convertChatGPTPlanToDayMap(planData);
    debugPrint(planData.toString());
    return ScheduleList(
        scheduleData: dayMap,
        currency: planData["currency"]
    );
  }

  Widget _buildPseudoDataSchedule(int travelPlanID) {
    return ScheduleList(
      scheduleData: fetchItineraryById(dbjson, travelPlanID),
      currency: "KRW"
    );
  }

  Map<String, List<Map<String, dynamic>>> convertChatGPTPlanToDayMap(
      Map<String, dynamic> planData) {
    final List<dynamic> days = planData["days"] ?? [];
    final Map<String, List<Map<String, dynamic>>> result = {};

    for (var day in days) {
      final dayIndex = day["day"];
      final itineraryList = day["itinerary"] ?? [];
      result["Day$dayIndex"] = List<Map<String, dynamic>>.from(itineraryList);
    }

    return result;
  }
}
