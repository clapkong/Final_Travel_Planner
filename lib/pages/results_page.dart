import 'package:flutter/material.dart';
import 'package:travel_planner/pages/maps_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_planner/main.dart';
import 'package:travel_planner/pages/favorites_page.dart';

class ResultsPage extends StatefulWidget {
  final dynamic travelPlan;
  final String state;
  final double budget;
  final int numPeople;
  final String date;
  final String type;
  final List<bool> travel_style;
  final List<String> travel_style_labels;
  final String country;

  ResultsPage({
    required this.travelPlan,
    required this.state,
    required this.budget,
    required this.numPeople,
    required this.date,
    required this.type,
    required this.travel_style,
    required this.travel_style_labels,
    required this.country,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late String path;
  late String hotel;
  late String keyword;
  late String name;
  late double price;
  late String summary;

  late String date;
  late String state;
  late int num_people;
  late double budget;
  late String type; //accommodation

  late List<bool> travel_style;
  late List<String> travel_style_labels;
  late String country;

   @override
  void initState() {
    super.initState();
    path = widget.travelPlan.img;
    hotel = widget.travelPlan.hotel;
    keyword = widget.travelPlan.keyword;
    name = widget.travelPlan.name;
    price = widget.travelPlan.price;
    summary = widget.travelPlan.summary;

    date = widget.date;
    country = widget.country;
    state = widget.state;
    num_people = widget.numPeople;
    budget = widget.budget;
    type = widget.type;
    travel_style = widget.travel_style;
    travel_style_labels = widget.travel_style_labels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detailed Page',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan[900]),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          CarouselWithOverlay(img: path, title: name, country: country, state: state, keyword: keyword, date: date, num_people: num_people, budget: budget, type:type, travel_style: travel_style, travel_style_labels: travel_style_labels),
          SizedBox(height: 20),
          Expanded(
            child:ListView(
              padding: const EdgeInsets.all(16.0),
              children:[
                Stack(
                  children:[
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: DashedLine(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScheduleItem(
                          index: 1,
                          time: '10:00 - 11:30',
                          title: '호텔 체크인',
                          location: '${hotel} ${type}',
                          icons: [
                            Icons.image,
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 2,
                          time: '11:30 - 12:30',
                          title: '점심',
                          location: '서울, 종로구 483',
                          subwayInfo: '4호선, 동대문역 4번 출구',
                          cost: '40,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 3,
                          time: '13:00 - 14:00',
                          title: '박물관 방문',
                          location: '국립중앙박물관',
                          icons: [
                            Icons.image,
                            Icons.play_circle,
                            Icons.video_library,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 4,
                          time: '15:00 - 16:00',
                          title: '커피 한 잔',
                          location: '카페 베네, 서울',
                          cost: '10,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 5,
                          time: '16:30 - 17:30',
                          title: '공원 산책',
                          location: '남산공원, 서울',
                          icons: [
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 6,
                          time: '18:00 - 19:00',
                          title: '저녁 식사',
                          location: '명동교자, 서울',
                          subwayInfo: '4호선, 명동역',
                          cost: '50,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                            Icons.image,
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 7,
                          time: '19:30 - 20:00',
                          title: '거리 쇼핑',
                          location: '명동 쇼핑 거리',
                          icons: [
                            Icons.video_library,
                            Icons.image,
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 8,
                          time: '20:30 - 21:30',
                          title: '야경 감상',
                          location: 'N서울타워',
                          cost: '15,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                            Icons.image,
                            Icons.video_library,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 9,
                          time: '09:00 - 09:30',
                          title: '아침 식사',
                          location: '호텔 레스토랑',
                          icons: [
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 10,
                          time: '09:45 - 10:45',
                          title: '사원 방문',
                          location: '조계사',
                          icons: [
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 11,
                          time: '11:00 - 12:00',
                          title: '경복궁 투어',
                          location: '경복궁, 서울',
                          cost: '3,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                            Icons.image,
                            Icons.play_circle,
                            Icons.play_circle,
                            Icons.video_library,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 12,
                          time: '12:30 - 13:30',
                          title: '북촌 점심 식사',
                          location: '북촌 한옥마을',
                          subwayInfo: '3호선, 안국역',
                          cost: '35,000 ₩',
                          icons: [
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 13,
                          time: '14:00 - 15:00',
                          title: '북촌 한옥마을 방문',
                          location: '북촌 한옥마을',
                          icons: [
                            Icons.video_library,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 14,
                          time: '15:30 - 16:00',
                          title: '차 시음',
                          location: '인사동 찻집',
                          cost: '12,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 15,
                          time: '16:30 - 17:00',
                          title: '인사동 탐방',
                          location: '인사동 거리',
                          icons: [
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 16,
                          time: '17:30 - 18:30',
                          title: '창덕궁 방문',
                          location: '창덕궁, 서울',
                          cost: '8,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                            Icons.video_library,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 17,
                          time: '19:00 - 20:30',
                          title: '한식 BBQ 저녁',
                          location: '마포구, 서울',
                          cost: '70,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 18,
                          time: '21:00 - 22:00',
                          title: '한강 유람선 투어',
                          location: '여의도 한강공원',
                          cost: '20,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 19,
                          time: '10:00 - 11:00',
                          title: '코엑스 아쿠아리움 방문',
                          location: '코엑스몰, 강남',
                          cost: '28,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                            Icons.image,
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                        ScheduleItem(
                          index: 20,
                          time: '11:30 - 12:30',
                          title: '강남 점심 식사',
                          location: '강남구',
                          subwayInfo: '2호선, 강남역',
                          cost: '45,000 ₩',
                          icons: [
                            Icons.image,
                            Icons.image,
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ]
                )
              ]
            )
          )
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
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapsPage()),
                    );*/
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
                color: Colors.blue,
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
                              fontWeight: FontWeight.bold,
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
  final int num_people;
  final double budget;
  final String type;
  final List<bool> travel_style;
  final List<String> travel_style_labels;
  CarouselWithOverlay({required this.img, required this.title, required this.country, required this.state, required this.keyword, required this.date, required this.num_people, required this.budget, required this.type, required this.travel_style, required this.travel_style_labels});
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
  late final int num_people;
  late final double budget;
  late final String type;
  late final List<bool> travel_style;
  late final List<String> travel_style_labels;
  late final String path;

  void _addFavorite(String path, String title, String country, String state, String keyword, String date, int num_people, double budget, String type, List<bool> travel_style) {
    setState(() {
      favoritesList.add({
        'title': title,
        'country': country,
        'state': state,
        'keyword': keyword,
        'date': date,
        'num_people': num_people,
        'budget': budget,
        'accommodation': type,
        'travel_style': travel_style,
        'path': path,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    title = widget.title;
    country = widget.country;
    state = widget.state;
    keyword = widget.keyword;
    date = widget.date;
    num_people = widget.num_people;
    budget = widget.budget;
    type = widget.type;
    travel_style = widget.travel_style;
    travel_style_labels = widget.travel_style_labels;
    path = widget.img;
    imageList = [
      path, //프로필 이미지와 동일한 이미지 carousel에 넣었음
    'assets/images/carousel_1.jpg',
    'assets/images/carousel_2.jpg',
  ];}

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
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
                isFavorite = !isFavorite;

                 _addFavorite(path, title, country, state, keyword, date, num_people, budget, type, travel_style);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(favoritesList: favoritesList),
                  ),
                );
                
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
                                Text('여행 기간: ${date}')
                                ]),
                          Row(children:[Icon(Icons.person, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('인원: ${num_people}')
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
                            for (int i = 0; i < travel_style.length; i++)
                              if (travel_style[i])
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Chip(
                                    label: Text('# ${travel_style_labels[i]}', style: TextStyle(fontSize: 14.0)),
                                  ),
                                ),
                          ]),
                        ]
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // 다이얼로그 닫기
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
                  Text('More informations', style: TextStyle(fontSize: 14.0, color: Colors.white)),])
            )
          ),
        ),
      ],
    );
  }
}
