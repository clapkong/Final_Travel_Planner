import 'package:flutter/material.dart';
import 'package:travel_planner/pages/maps_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_planner/main.dart';
import 'package:travel_planner/pages/favorites_page.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/pages/search_page.dart';

Map<String, List<Map<String, dynamic>>> pseudoItinerary = {
  "Day1":[
    {
        "index": 1,
        "time": "10:00 - 11:30",
        "title": "호텔 체크인",
        "location": "서울 신라 호텔",
        "coordinate": "37.5503, 126.9908"
    },
    {
        "index": 2,
        "time": "11:30 - 12:30",
        "title": "점심",
        "location": "서울, 종로구 483",
        "coordinate": "37.5503, 126.9908",
        "subwayInfo": "4호선, 동대문역 4번 출구",
        "cost": 40000
    },
    {
        "index": 3,
        "time": "13:00 - 14:00",
        "title": "박물관 방문",
        "location": "국립중앙박물관",
        "coordinate": "37.5231, 126.9802"
    },
    {
        "index": 4,
        "time": "15:00 - 16:00",
        "title": "커피 한 잔",
        "location": "카페 베네, 서울",
        "coordinate": "37.5482, 127.0077",
        "cost": 10000
    },
    {
        "index": 5,
        "time": "16:30 - 17:30",
        "title": "공원 산책",
        "location": "남산공원, 서울",
        "coordinate": "37.5514, 126.9882"
    },
    {
        "index": 6,
        "time": "18:00 - 19:00",
        "title": "저녁 식사",
        "location": "명동교자, 서울",
        "coordinate": "37.5600, 126.9862",
        "subwayInfo": "4호선, 명동역",
        "cost": 50000
    },
    {
        "index": 7,
        "time": "19:30 - 20:00",
        "title": "거리 쇼핑",
        "location": "명동 쇼핑 거리",
        "coordinate": "37.5610, 126.9858"
    },
    {
        "index": 8,
        "time": "20:30 - 21:30",
        "title": "야경 감상",
        "location": "N서울타워",
        "coordinate": "37.5512, 126.9880",
        "cost": 15000
    }
  ],
  "Day2": [
    {
        "index": 1,
        "time": "09:00 - 09:30",
        "title": "아침 식사",
        "location": "호텔 레스토랑",
        "coordinate": "37.5503, 126.9908"
    },
    {
        "index": 2,
        "time": "09:45 - 10:45",
        "title": "사원 방문",
        "location": "조계사",
        "coordinate": "37.5741, 126.9818"
    },
    {
        "index": 3,
        "time": "11:00 - 12:00",
        "title": "경복궁 투어",
        "location": "경복궁, 서울",
        "coordinate": "37.5796, 126.9770",
        "cost": 3000
    },
    {
        "index": 4,
        "time": "12:30 - 13:30",
        "title": "북촌 점심 식사",
        "location": "북촌 한옥마을",
        "coordinate": "37.5825, 126.9857",
        "subwayInfo": "3호선, 안국역",
        "cost": 35000
    },
    {
        "index": 5,
        "time": "14:00 - 15:00",
        "title": "북촌 한옥마을 방문",
        "location": "북촌 한옥마을",
        "coordinate": "37.5825, 126.9857"
    },
    {
        "index": 6,
        "time": "15:30 - 16:00",
        "title": "차 시음",
        "location": "인사동 찻집",
        "coordinate": "37.5712, 126.9860",
        "cost": 12000
    },
    {
        "index": 7,
        "time": "16:30 - 17:00",
        "title": "인사동 탐방",
        "location": "인사동 거리",
        "coordinate": "37.5712, 126.9860"
    },
    {
        "index": 8,
        "time": "17:30 - 18:30",
        "title": "창덕궁 방문",
        "location": "창덕궁, 서울",
        "coordinate": "37.5823, 126.9910",
        "cost": 8000
    },
    {
        "index": 9,
        "time": "19:00 - 20:30",
        "title": "한식 BBQ 저녁",
        "location": "마포구, 서울",
        "coordinate": "37.5565, 126.9245",
        "cost": 70000
    },
    {
        "index": 10,
        "time": "21:00 - 22:00",
        "title": "한강 유람선 투어",
        "location": "여의도 한강공원",
        "coordinate": "37.5292, 126.9348",
        "cost": 20000
    }
  ],
  "Day3":[
    {
        "index": 1,
        "time": "10:00 - 11:30",
        "title": "호텔 체크아웃",
        "location": "신라 호텔",
        "coordinate": "37.5503, 126.9908"
    },
    {
        "index": 2,
        "time": "11:30 - 12:30",
        "title": "점심",
        "location": "서울, 종로구 483",
        "subwayInfo": "4호선, 동대문역 4번 출구",
        "cost": 40000,
        "coordinate": "37.5741, 126.9818"
    },
    {
        "index": 3,
        "time": "13:00 - 14:00",
        "title": "박물관 방문",
        "location": "국립중앙박물관",
        "coordinate": "37.5231, 126.9802"
    },
    {
        "index": 4,
        "time": "15:00 - 16:00",
        "title": "커피 한 잔",
        "location": "카페 베네, 서울",
        "cost": 10000,
        "coordinate": "37.5482, 127.0077"
    },
    {
        "index": 5,
        "time": "16:30 - 17:30",
        "title": "공원 산책",
        "location": "남산공원, 서울",
        "coordinate": "37.5514, 126.9882"
    },
    {
        "index": 6,
        "time": "18:00 - 19:00",
        "title": "저녁 식사",
        "location": "명동교자, 서울",
        "subwayInfo": "4호선, 명동역",
        "cost": 50000,
        "coordinate": "37.5600, 126.9862"
    }
  ]
};

class ResultsPage extends StatefulWidget {
  final dynamic travelPlan;

  ResultsPage({
    required this.travelPlan,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late dynamic travelPlan;
  late int currentDay;

  late String title;
  late String img1;
  late String img2;
  late String img3;
  late String hotel;
  late String keyword;
  late double price;
  late String summary;

   @override
  void initState() {
    super.initState();
    travelPlan = widget.travelPlan;
    currentDay = 1;

    title = travelPlan.title;
    img1 = travelPlan.img1;
    img2 = travelPlan.img2;
    img3 = travelPlan.img3;
    hotel = travelPlan.hotel;
    keyword = travelPlan.keyword;
    price = travelPlan.price;
    summary = travelPlan.summary;
  }
  
  @override
  Widget build(BuildContext context) {
    final travelInfo = context.watch<UserInputProvider>().userInput;

    if (travelInfo == null) {
      return Scaffold(
        appBar: widgetAppBar(context, 'Detailed Page'),
        body: Center(child: Text('저장된 여행 정보가 없습니다.')),
      );
    }

    String date = formatDateRange(travelInfo.departure, travelInfo.arrival);
    String country = travelInfo.country;
    String state = travelInfo.state;
    int numPeople = travelInfo.numPeople;
    double budget = travelInfo.budget;
    String type = accommodationLabels[travelInfo.accommodation];
    List<bool> travelStyle = travelInfo.travelStyle;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detailed Page',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan[900]),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.75),
      ),
      body: Column(
        children: [
          CarouselWithOverlay(img: img1, title: title, country: country, state: state, keyword: keyword, date: date, numPeople: numPeople, budget: budget, type:type, travelStyle: travelStyle, travelStyleLables: travelStyleLabels, travelPlan: travelPlan),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
            ...List.generate(3, (index) { 
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text('Day ${index + 1}'),
                  selected: currentDay == (index + 1),
                  onSelected: (bool selected) {
                    setState(() {
                      currentDay = index + 1;
                    });
                  },
                ),
              );
            })],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: DashedLine(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getScheduleItemsForDay(pseudoItinerary,currentDay), 
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '예상 금액: ₩ ${(budget*0.8 + price*0.2).round()} 만원',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapsPage()),
                    );
                  },
                  child: Text('지도에서 보기'),
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('선택하기'),
                ),
              ],
            ),
          ),
        ),
    );
  }
}


class DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double dashWidth = 4;
        double dashSpace = 4;
        final double dashCount = constraints.constrainHeight() / (dashWidth + dashSpace);
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount.floor(), (index) =>
              SizedBox(
                width: 2,
                height: dashWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
        );
      },
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final int index;
  final String time;
  final String title;
  final String? location;
  final String? subwayInfo;
  final String? cost;
  final List<IconData> icons;

  const ScheduleItem({
    required this.index,
    required this.time,
    required this.title,
    this.location,
    this.subwayInfo,
    this.cost,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          child: Center(
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyan.shade900,
              ),
              child: Center(
                child: Text(
                  index.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan[900]
                ),
              ),
              SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      if (location != null) ...[
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 8),
                            Expanded(child: Text(location!)),
                          ],
                        ),
                      ],
                      if (subwayInfo != null) ...[
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.directions_subway),
                            SizedBox(width: 8),
                            Expanded(child: Text(subwayInfo!)),
                          ],
                        ),
                      ],
                      if (cost != null) ...[
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.attach_money),
                            SizedBox(width: 8),
                            Text(cost!),
                          ],
                        ),
                      ],
                      SizedBox(height: 16),
                      Row(
                        children: icons
                            .map((icon) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: IconButton(
                                    icon: Icon(icon),
                                    onPressed: () {},
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CarouselWithOverlay extends StatefulWidget {
  final String img;
  final String title;
  final String country;
  final String state;
  final String keyword;
  final String date;
  final int numPeople;
  final double budget;


  final String type;
  final List<bool> travelStyle;
  final List<String> travelStyleLables;
  final dynamic travelPlan;
  CarouselWithOverlay({required this.img, required this.title, required this.country, required this.state, required this.keyword, required this.date, required this.numPeople, required this.budget, required this.type, required this.travelStyle, required this.travelStyleLables, required this.travelPlan});
  @override
  _CarouselWithOverlayState createState() => _CarouselWithOverlayState();
}

class _CarouselWithOverlayState extends State<CarouselWithOverlay> {
  late final List<String> imageList;
  late final String title;
  late final String state;
  late final String country;
  late final String keyword;
  late final String date;
  late final int numPeople;
  late final double budget;
  late final String type;
  late final List<bool> travelStyle;
  late final List<String> travelStyleLables;
  late final String path;
  late final dynamic travelPlan;

  void _addFavorite(String path, String title, String country, String state, String keyword, String date, int numPeople, double budget, String type, List<bool> travelStyle, dynamic travelPlan) {
    setState(() {
      favoritesList.add({
        'title': title,
        'country': country,
        'state': state,
        'keyword': keyword,
        'date': date,
        'numPeople': numPeople,
        'budget': budget,
        'accommodation': type,
        'travelStyle': travelStyle,
        'path': path,
        'travelPlan': travelPlan,//favorite page의 card를 눌러서 results_page를 여는 방법을 위해 필요
      });
    });
  }

  @override
  void initState() {
    super.initState();
    title = widget.title;
    state = widget.state;
    keyword = widget.keyword;
    path = widget.img;
    travelPlan = widget.travelPlan;
    imageList = [
    'assets/images/carousel_2.jpg',
    'assets/images/carousel_2.jpg',
    'assets/images/carousel_2.jpg',
  ];
    isFavorite = favoritesList.any((favorite) =>
      favorite['title'] == title &&
      favorite['country'] == country &&
      favorite['state'] == state &&
      favorite['keyword'] == keyword &&
      favorite['date'] == date &&
      favorite['numPeople'] == numPeople &&
      favorite['budget'] == budget &&
      favorite['accommodation'] == type
    );
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final travelInfo = context.watch<UserInputProvider>().userInput;

    if (travelInfo == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Search Page')),
        body: Center(child: Text('저장된 여행 정보가 없습니다.')),
      );
    }

    String date =
        '${travelInfo.departure.year.toString()}.${travelInfo.departure.month.toString().padLeft(2, '0')}.${travelInfo.departure.day.toString().padLeft(2, '0')} - ${travelInfo.arrival.year.toString()}.${travelInfo.arrival.month.toString().padLeft(2, '0')}.${travelInfo.arrival.day.toString().padLeft(2, '0')}';

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
          ),
          items: imageList.map((item) => 
            Container(
              width: double.infinity,
              child: Image.asset(item, fit: BoxFit.cover, width: double.infinity),
            )
          ).toList(),
        ),
        Positioned(
          top: 100.0,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Trip to ${state} ${title}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10.0,
          left: 10.0,
          child:Text("# ${keyword}", style:TextStyle(color: Colors.white, fontSize: 12.0))
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  // Remove item from favoritesList
                  favoritesList.removeWhere((favorite) =>
                    favorite['title'] == title &&
                    favorite['country'] == country &&
                    favorite['state'] == state &&
                    favorite['date'] == date &&
                    favorite['numPeople'] == numPeople &&
                    favorite['budget'] == budget &&
                    favorite['accommodation'] == type
                  );
                } else {
                  // Add item to favoritesList
                  _addFavorite(path, title, country, state, keyword, date, numPeople, budget, type, travelStyle, travelPlan);
                }

                isFavorite = !isFavorite;
              });
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            color: Colors.black.withOpacity(0.5),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(children:[Icon(Icons.info_outline, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('Information')
                                ]),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Row(children:[Icon(Icons.location_on, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('여행지: ${widget.state}, ${widget.country}', style: TextStyle(fontSize: 14.0)),]), SizedBox(height:5), 
                          Row(children:[Icon(Icons.calendar_today, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('여행 기간: ${widget.date}')
                                ]),
                          Row(children:[Icon(Icons.person, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('인원: ${widget.numPeople}')
                                ]),
                          Row(children:[Icon(Icons.paid, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('예산: ${widget.budget}')
                                ]),
                          Row(children:[Icon(Icons.hotel, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('숙소 유형: ${widget.type}')
                                ]),
                          Text('\n 여행 목적: '),
                          Row(children:[
                            for (int i = 0; i < widget.travelStyle.length; i++)
                              if (widget.travelStyle[i])
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Chip(
                                    label: Text('# ${travelStyleLables[i]}', style: TextStyle(fontSize: 14.0)),
                                  ),
                                ),
                          ]),
                        ]
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); 
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children:[
                  Icon(Icons.info_outline, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Text('More information', style: TextStyle(fontSize: 14.0, color: Colors.white)),])
            )
          ),
        ),
      ],
    );
  }
}