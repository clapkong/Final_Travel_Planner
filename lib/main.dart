import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_planner/pages/maps_page.dart';
import 'package:travel_planner/pages/search_page.dart';
import 'package:travel_planner/pages/favorites_page.dart';
import 'package:travel_planner/pages/results_page.dart';
import 'package:travel_planner/pages/home_page.dart';

List<Map<String, dynamic>> favoritesList = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Optimizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
        fontFamily: "Pretendard",
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _command = ""; //TODO
  DateTime _departure = DateTime.now();
  DateTime _arrival = DateTime.now();
  String _country ="";
  String _state = "";
  String _city = "";
  int _num_people = 1;
  double _budget = 20;
  int _accommodation = 0;
  List<bool> _travel_style = [false, false, false, false, false, false];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    // Initialize pages with the HomePage, SearchPage, MapsPage, and FavoritesPage
    _pages.addAll([
      HomePage(
        onSearch: (departure, arrival, country, state, city, num_people, budget, accommodation, travel_style) {
          // Update state when search is performed
          setState(() {
            _departure = departure;
            _arrival = arrival;
            _country = country;
            _state = state;
            _city = city;
            _num_people = num_people;
            _budget = budget;
            _accommodation = accommodation;
            _travel_style = travel_style;
            // Add search result to favorites
            /*_favorites.add({
              'departure': _departure,
              'arrival': _arrival,
              'country': _country,
              'state': _state,
              'city': _city,
              'num_people': _num_people,
              'budget': _budget,
              'accommodation': _accommodation,
              'travel_style': _travel_style,
            });*/
          });
          // Navigate to SearchPage with the provided data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
              departure: _departure,
              arrival: _arrival,
              country: _country,
              state: _state,
              city: _city,
              num_people: _num_people,
              budget: _budget,
              accommodation: _accommodation,
              travel_style: _travel_style,
              ),
            ),
          );
        },
      ),
      SearchPage(
              departure: _departure,
              arrival: _arrival,
              country: _country,
              state: _state,
              city: _city,
              num_people: _num_people,
              budget: _budget,
              accommodation: _accommodation,
              travel_style: _travel_style,
      ),
      MapsPage(
              date: '${_departure.year.toString()}.${_departure.month.toString().padLeft(2, '0')}.${_departure.day.toString().padLeft(2, '0')} - ${_arrival.year.toString()}.${_arrival.month.toString().padLeft(2, '0')}.${_arrival.day.toString().padLeft(2, '0')}',
              country: _country,
              state: _state,
      ),
      FavoritesPage(favoritesList: favoritesList),
    ]);
  }

  // Handle bottom navigation bar item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        // Rebuild pages dynamically based on current state
        children: _pages.map((page) {
          if (page is SearchPage) {
            return SearchPage(
              departure: _departure,
              arrival: _arrival,
              country: _country,
              state: _state,
              city: _city,
              num_people: _num_people,
              budget: _budget,
              accommodation: _accommodation,
              travel_style: _travel_style,
            );
          } else if (page is MapsPage) {
            return MapsPage(
              date: '${_departure.year.toString()}.${_departure.month.toString().padLeft(2, '0')}.${_departure.day.toString().padLeft(2, '0')} - ${_arrival.year.toString()}.${_arrival.month.toString().padLeft(2, '0')}.${_arrival.day.toString().padLeft(2, '0')}',
              country: _country,
              state: _state,
            );
          } else if (page is FavoritesPage) {
            return FavoritesPage(favoritesList: favoritesList);
          }
          return page;
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}






