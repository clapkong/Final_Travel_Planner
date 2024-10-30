import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final List<Map<String, dynamic>> favorites;

  FavoritesPage({required this.favorites});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Page'),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: widget.favorites.length,
          itemBuilder: (context, index) {
            final favorite = widget.favorites[index];
            // Display each favorite item in a ListTile
            return ListTile(
              title: Text('Search query: ${favorite['country']}, ${favorite['state']}, ${favorite['city']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected date: ${favorite['departure'].toLocal()}'),
                  Text('Selected date: ${favorite['arrival'].toLocal()}'),
                  Text('Number: ${favorite['num_people']}'),
                  //Text('Number: ${favorite['budget']}'),
                  //Text('Number: ${favorite['accommodation']}'),
                  //Text('Boolean values: ${favorite['travel_style'].join(', ')}'),
                ],
              ),
              isThreeLine: true,
            );
          },
        ),
      ),
    );
  }
}