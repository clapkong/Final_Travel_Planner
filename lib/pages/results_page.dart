import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_planner/main.dart';
import 'package:travel_planner/pages/favorites_page.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/pages/search_page.dart';
import 'package:travel_planner/pseudodata.dart';
import 'package:travel_planner/widgets/itinerary.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late double price;

   @override
  void initState() {
    super.initState();
    travelPlan = widget.travelPlan;
    currentDay = 1;
    price = travelPlan.price;
  }
  
  @override
  Widget build(BuildContext context) {
    final travelInfo = context.watch<UserInputProvider>().userInput;

    if (travelInfo == null) {
      return Scaffold(
        appBar: widgetAppBar(context, 'Detailed Page'),
        body: widgetEmptyPage(),
      );
    }

    return Scaffold(
      appBar: widgetAppBar(context, 'Detailed Page'),
      body: Column(
        children: [
          CarouselWithOverlay(travelInfo:travelInfo, travelPlan: travelPlan),
          SizedBox(height: 20),
          Flexible(child:ScheduleList(scheduleData: pseudoItinerary)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '예상 금액: ₩ ${(price).round()} 만원',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

class CarouselWithOverlay extends StatefulWidget {
  final UserInput travelInfo;
  final dynamic travelPlan;
  CarouselWithOverlay({required this.travelInfo, required this.travelPlan});
  @override
  _CarouselWithOverlayState createState() => _CarouselWithOverlayState();
}

class _CarouselWithOverlayState extends State<CarouselWithOverlay> {
  late final List<String> imageList;
  late final UserInput travelInfo;
  late final dynamic travelPlan;

  late String date;
  late String country;
  late String state;
  late int numPeople;
  late double budget;
  late String type;
  late List<bool> travelStyle;
  late String title;
  late String keyword;
  late String path;
  late int searchID;
  late int travelPlanID;

  @override
  void initState() {
    super.initState();
    travelInfo = widget.travelInfo;
    travelPlan = widget.travelPlan;
    
    imageList = [
    travelPlan.img1,
    travelPlan.img2,
    travelPlan.img3,
    ];

    date = formatDateRange(travelInfo.departure, travelInfo.arrival);
    country = travelInfo.country;
    state = travelInfo.state;
    numPeople = travelInfo.numPeople;
    budget = travelInfo.budget;
    type = accommodationLabels[travelInfo.accommodation];
    travelStyle = travelInfo.travelStyle;

    title = travelPlan.title;
    keyword = travelPlan.keyword;
    path =  travelPlan.img1;
    searchID = travelPlan.search_id;
    travelPlanID = travelPlan.id;
  }

  @override
  Widget build(BuildContext context) {
    final travelInfo = context.watch<UserInputProvider>().userInput;
    final favoritesProvider = context.read<FavoritesProvider>();
    final isFavorite = context.read<FavoritesProvider>().isFavorite(searchID, travelPlanID);

    if (travelInfo == null) {
      return SizedBox();
    }

    String date = formatDateRange(travelInfo.departure, travelInfo.arrival);

    return Stack(
      children: [
        //이미지 Carousel Slider
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

        //제목
        Positioned(
          top: 100.0,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              '[${state}] ${title}',
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

        //좌측 상단 키워드
        Positioned(
          top: 10.0,
          left: 10.0,
          child:Text("# ${keyword}", style:TextStyle(color: Colors.white, fontSize: 12.0))
        ),

        //즐겨찾기 (Favorites)
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
                  favoritesProvider.removeFavorite(searchID, travelPlanID);
                } else {
                  // Add item to favoritesList
                  favoritesProvider.addFavorite(FavoritesItem(
                    title: title,
                    country: country,
                    state: state,
                    date: date,
                    path: path,
                    searchID: searchID,
                    travelPlanID: travelPlanID,
                  ));
                }
              });
            },
          ),
        ),

        //Dialogue
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
                                Text('여행지: ${state}, ${country}', style: TextStyle(fontSize: 14.0)),]), SizedBox(height:5), 
                          Row(children:[Icon(Icons.calendar_today, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('여행 기간: ${date}')
                                ]),
                          Row(children:[Icon(Icons.person, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('인원: ${numPeople}')
                                ]),
                          Row(children:[Icon(Icons.paid, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('예산: ${budget}')
                                ]),
                          Row(children:[Icon(Icons.hotel, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('숙소 유형: ${type}')
                                ]),
                          Text('\n 여행 목적: '),
                          Row(children:[
                            for (int i = 0; i < travelStyle.length; i++)
                              if (travelStyle[i])
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Chip(
                                    label: Text('# ${travelStyleLabels[i]}', style: TextStyle(fontSize: 14.0)),
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