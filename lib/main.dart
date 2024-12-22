import 'package:flutter/material.dart';
import 'package:travel_planner/pages/maps_page.dart';
import 'package:travel_planner/pages/search_page.dart';
import 'package:travel_planner/pages/favorites_page.dart';
import 'package:travel_planner/pages/home_page.dart';
import 'package:provider/provider.dart';

// 상태 관리
List<Map<String, dynamic>> favoritesList = [];

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

List<Widget> getScheduleItemsForDay(Map<String, dynamic> scheduleData, int day) {
  String dayKey = 'Day$day';
  if (!scheduleData.containsKey(dayKey)) {
    return [Text('해당 날짜의 일정이 없습니다.')];
  }

  return (scheduleData[dayKey] as List<dynamic>).map<Widget>((item) {
    return Column(
      children: [
        ScheduleItem(
          index: item['index'],
          time: item['time'],
          title: item['title'],
          location: item['location'] ?? null,
          subwayInfo: item['subwayInfo'] ?? null,
          cost: item.containsKey('cost') ? '${item['cost']} ₩' : null,
          icons: List<IconData>.generate(
            3, // 기본 아이콘 갯수
            (index) => Icons.image,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }).toList();
}

//사용자가 입력폼에 입력한 내용을 클래스로 묶기 (버튼 누르면 한 번에 업데이트)
class UserInput {
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

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserInputProvider(),
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
    MapsPage(),         // 지도 페이지
    FavoritesPage(favoritesList: favoritesList),    // 즐겨찾기 페이지
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






