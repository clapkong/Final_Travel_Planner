import 'package:flutter/material.dart';
import 'package:travel_planner/pages/search_page.dart';
import 'package:travel_planner/pages/favorites_page.dart';
import 'package:travel_planner/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//전역 변수
final List<String> accommodationLabels = ['호텔', '게스트하우스', '리조트', 'Airbnb'];
List<String> travelStyleLabels = ['휴양 및 힐링', '기념일', '호캉스', '가족여행', '관광','역사 탐방'];

Widget widgetEmptyPage() {
  return Center(
    child: Text('Home Page에서 여행 정보를 입력해주세요!'),
  );
}

PreferredSizeWidget widgetAppBar(BuildContext context, String pageName) {
  return AppBar(
    title: Text(
      '${pageName}',
      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan[900]),
    ),
    backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.75),
  );
}

String formatDateRange(DateTime departure, DateTime arrival) {
    return '${formatDate(departure)} - ${formatDate(arrival)}';
}

String formatDate(DateTime date){
  return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}

//사용자가 입력폼에 입력한 내용을 클래스로 묶기 (버튼 누르면 한 번에 업데이트)
class UserInput {
  final int search_id;
  final String command;
  final DateTime departure;
  final DateTime arrival;
  final String country;
  final String state;
  final String city;
  final int numPeople;
  final double budget;
  final int accommodation;
  final List<bool> travelStyle;

  UserInput({
    required this.search_id,
    required this.command,
    required this.departure,
    required this.arrival,
    required this.country,
    required this.state,
    required this.city,
    required this.numPeople,
    required this.budget,
    required this.accommodation,
    required this.travelStyle,
  });
}

//
class UserInputProvider with ChangeNotifier {
  UserInput? _userInput;

  UserInput? get userInput => _userInput;

  void updateUserInput(UserInput userInput) {
    _userInput = userInput;
    notifyListeners();
  }
}

class FavoritesItem {
  final String title;
  final String country;
  final String state;
  final String path;
  final String date;
  final int searchID;
  final int travelPlanID;

  FavoritesItem({required this.title, required this.country, required this.state, required this.path, required this.searchID, required this.travelPlanID, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'country': country,
      'state': state,
      'path': path,
      'date': date,
      'searchID': searchID,
      'travelPlanID': travelPlanID,
    };
  }

  factory FavoritesItem.fromMap(Map<String, dynamic> map) {
    return FavoritesItem(
      title: map['title'],
      country: map['country'],
      state: map['state'],
      path: map['path'],
      date: map['date'],
      searchID: map['searchID'],
      travelPlanID: map['travelPlanID'],
    );
  }
}

class FavoritesStorage {
  static const _favoritesKey = 'favoritesList';

  // Save the list of favorites
  static Future<void> saveFavorites(List<FavoritesItem> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = favorites.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList(_favoritesKey, jsonList);
  }

  // Load the list of favorites
  static Future<List<FavoritesItem>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_favoritesKey);

    if (jsonList == null) return [];

    return jsonList.map((item) => FavoritesItem.fromMap(jsonDecode(item))).toList();
  }

  // Add a single favorite item
  static Future<void> addFavorite(FavoritesItem item) async {
    final favorites = await loadFavorites();
    favorites.add(item);
    await saveFavorites(favorites);
  }

  // Remove a single favorite item
  static Future<void> removeFavorite(int searchID, int travelPlanID) async {
    final favorites = await loadFavorites();
    favorites.removeWhere(
        (item) => item.searchID == searchID && item.travelPlanID == travelPlanID);
    await saveFavorites(favorites);
  }
}

class FavoritesProvider extends ChangeNotifier {
  List<FavoritesItem> _favorites = [];

  List<FavoritesItem> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favorites = await FavoritesStorage.loadFavorites();
    notifyListeners();
  }

  void addFavorite(FavoritesItem item) async {
    _favorites.add(item);
    await FavoritesStorage.saveFavorites(_favorites);
    notifyListeners();
  }

  void removeFavorite(int searchID, int travelPlanID) async {
    _favorites.removeWhere((item) => item.searchID == searchID && item.travelPlanID == travelPlanID);
    await FavoritesStorage.saveFavorites(_favorites);
    notifyListeners();
  }

  bool isFavorite(int searchID, int travelPlanID) {
    return _favorites.any(
        (item) => item.searchID == searchID && item.travelPlanID == travelPlanID);
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInputProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
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

  final List<Widget> _pages = [
    HomePage(),         // 여행 정보 입력 페이지
    SearchPage(),       // 검색 결과 페이지
    FavoritesPage(),    // 즐겨찾기 페이지
  ];

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
        children: _pages,
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
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}






