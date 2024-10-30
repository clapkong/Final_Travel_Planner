import 'package:flutter/material.dart';
import 'package:travel_planner/pages/maps_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
          Text(
            'This is a text below the carousel', //hotel, summary, price, mappage navigation
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
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
    imageList = [
      widget.img, //프로필 이미지와 동일한 이미지 carousel에 넣었음
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
          child:Text("# ${keyword}", style:TextStyle(color: Colors.white, fontSize: 10.0))
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
