import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  //final String command; 
  final DateTime departure;
  final DateTime arrival;
  final String country;
  final String state;
  final String city;
  final int num_people;
  final double budget;
  final int accommodation;
  final List<bool> travel_style;

  SearchPage({
    required this.departure,
    required this.arrival,
    required this.country,
    required this.state,
    required this.city,
    required this.num_people,
    required this.budget,
    required this.accommodation,
    required this.travel_style,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late int num_people;
  late double budget;
  late int accommodation;
  late List<bool> travel_style;
  bool _customTileExpanded = false;
  List<String> accommodation_labels = ['호텔', '게스트하우스', '리조트', 'Airbnb'];
  List<String> travel_style_labels = ['휴양 및 힐링', '기념일', '호캉스', '가족여행', '관광','역사 탐방'];

  @override
  void initState() {
    super.initState();
    num_people = widget.num_people;
    budget = widget.budget; // 여기서 budget, num_people, accommodation, travel_style 초기화
    accommodation = widget.accommodation;
    travel_style = widget.travel_style;
  }

  final List<TravelPlan> travel_plans = [
    TravelPlan(name: 'Travel Plan Name', year: 2021, price: 55000, seats: 4, date: '2023-11-01'),
    TravelPlan(name: 'Travel Plan Name', year: 2020, price: 41000, seats: 5, date: '2023-10-15'),
    TravelPlan(name: 'Travel Plan Name', year: 2019, price: 39000, seats: 4, date: '2023-09-05'),
    TravelPlan(name: 'Travel Plan Name', year: 2021, price: 57000, seats: 4, date: '2023-12-20'),
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan[900]),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:Column(
        children:<Widget>[
          ExpansionTile(
            backgroundColor: Colors.cyan[50],
            collapsedBackgroundColor: Colors.cyan[50],
            
          title: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text('Showing Travel Plans for: ', style:TextStyle(fontSize: 18.0)), SizedBox(height:5)]),
          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, 
          children: [Row(children:[Icon(Icons.location_on, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('${widget.state}, ${widget.country}', style: TextStyle(fontSize: 14.0)),]), SizedBox(height:5), 
                    Row(children:[Icon(Icons.calendar_today, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('${widget.departure.year.toString()}.${widget.departure.month.toString().padLeft(2, '0')}.${widget.arrival.day.toString().padLeft(2, '0')} - ${widget.departure.year.toString()}.${widget.arrival.month.toString().padLeft(2, '0')}.${widget.arrival.day.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 14.0)),
                              ])],),
          trailing: Icon(
            _customTileExpanded
                ? Icons.arrow_drop_down_circle
                : Icons.arrow_drop_down,
          ),
          children: <Widget>[
            ListTile(title: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
              Row(children:[Icon(Icons.person, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('인원: ${num_people}명', style: TextStyle(fontSize: 14.0)),
                                SizedBox(width: 16.0),
                                Icon(Icons.paid, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('예산: ${budget}만원', style: TextStyle(fontSize: 14.0)),
                                SizedBox(width: 16.0),
                                Icon(Icons.hotel, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('숙소: ${accommodation_labels[accommodation]}', style: TextStyle(fontSize: 14.0)),
                                ]), SizedBox(height:10),
              Row(children:[
                for (int i = 0; i < travel_style.length; i++)
                  if (travel_style[i])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: Text('# ${travel_style_labels[i]}', style: TextStyle(fontSize: 14.0)),
                      ),
                    ),
              ])])),
          ],
          onExpansionChanged: (bool expanded) {
            setState(() {
              _customTileExpanded = expanded;
            });
          },
        ),
        SizedBox(height:10),
        Expanded(
          child: ListView.builder(
            itemCount: travel_plans.length,
            itemBuilder: (context, index) {
              return TravelPlanCard(travel_plan: travel_plans[index]);
            },
          ),  
        ),
        ]
      )
    );
  }
}

class TravelPlanCard extends StatelessWidget {
  final TravelPlan travel_plan;

  TravelPlanCard({required this.travel_plan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            // 여행 계획 이미지 (샘플로 아이콘 사용)
            Container(
              width: 100,
              height: 100,
              color: Colors.grey[300], // 임시로 색상을 사용해 이미지 위치 표시
              child: Icon(Icons.directions_car, size: 50),
            ),
            SizedBox(width: 16),
            // 오른쪽 정보 영역
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 칩들
                  Row(
                    children: [
                      Chip(
                        label: Text('Small'),
                        avatar: Icon(Icons.person, size: 16),
                      ),
                      SizedBox(width: 8),
                      Chip(
                        label: Text('${travel_plan.seats} Seats'),
                        avatar: Icon(Icons.hotel, size: 16),
                      ),
                      SizedBox(width: 8),
                      Chip(
                        label: Text('Auto'),
                        avatar: Icon(Icons.tag, size: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // 여행 계획 정보 텍스트
                  Text(
                    travel_plan.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${travel_plan.price} ₩',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Date: ${travel_plan.date}',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TravelPlan {
  final String name;
  final int year;
  final int price;
  final int seats;
  final String date;

  TravelPlan({
    required this.name,
    required this.year,
    required this.price,
    required this.seats,
    required this.date,
  });
}

