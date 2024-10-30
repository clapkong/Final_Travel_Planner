import 'package:flutter/material.dart';
import 'package:travel_planner/pages/results_page.dart';

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
  late String date;
  late String country;
  late String state;
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
    date = '${widget.departure.year.toString()}.${widget.departure.month.toString().padLeft(2, '0')}.${widget.departure.day.toString().padLeft(2, '0')} - ${widget.departure.year.toString()}.${widget.arrival.month.toString().padLeft(2, '0')}.${widget.arrival.day.toString().padLeft(2, '0')}';
    country = widget.country;
    state = widget.state;
    num_people = widget.num_people;
    budget = widget.budget; // 여기서 budget, num_people, accommodation, travel_style 초기화
    accommodation = widget.accommodation;
    travel_style = widget.travel_style;
  }

//ChatGPT로 생성한 가상 관광지
  final List<TravelPlan> travel_plans = [
    TravelPlan(img: 'assets/images/travel_1.jpg', hotel: '신라', keyword: '자연적', name: "#1", price: 0.0, summary: '사르바 항구 산책, 미라노 궁 투어, 라펠라 숲 트레킹'),
    TravelPlan(img: 'assets/images/travel_2.jpg', hotel: '메리어트', keyword: '평온함', name: "#2", price: 10.0, summary: '아르보 바자 탐방, 실비아 호수 유람, 에덴 교회 방문'),
    TravelPlan(img: 'assets/images/travel_3.jpg', hotel: '조선', keyword: '예술적', name: "#3", price: 40.0, summary: '나리아 미술관, 로미타 정원 산책, 라빈다 성 투어'),
    TravelPlan(img: 'assets/images/travel_4.jpg', hotel: '하얏트', keyword: '여유로움', name: "#4", price: 30.0, summary: '이솔리 해변 수영, 루체르 전망대, 파르니 마을 체험'),
    TravelPlan(img: 'assets/images/travel_5.jpg', hotel: '쉐라톤', keyword: '향토적', name: "#5", price: 15.0, summary: '라코나 시장 구경, 플로렌 언덕 트레킹, 바르미 오솔길 산책'),
    TravelPlan(img: 'assets/images/travel_6.jpg', hotel: '콘래드', keyword: '고풍적', name: "#6", price: 10.0, summary: '페르노 성 방문, 사피르 정원 산책, 로살리 박물관'),
    TravelPlan(img: 'assets/images/travel_7.jpg', hotel: '한화', keyword: '역사적', name: "#7", price: 20.0, summary: '엘토아 해양 박물관, 나리아 성벽 투어, 세라노 거리 예술'),
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
                                Text('${widget.departure.year.toString()}.${widget.departure.month.toString().padLeft(2, '0')}.${widget.departure.day.toString().padLeft(2, '0')} - ${widget.departure.year.toString()}.${widget.arrival.month.toString().padLeft(2, '0')}.${widget.arrival.day.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 14.0)),
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
              return InkWell(
                onTap: () {
                  // 여기에 아이템을 클릭했을 때 실행할 동작을 정의하세요.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(
                        travelPlan: travel_plans[index],
                        state: state,
                        budget: budget,
                        numPeople: num_people,
                        date: date,
                        type: accommodation_labels[accommodation],
                      ),
                    ),
                  );
                },
              child: TravelPlanCard(travel_plan: travel_plans[index], state: state, budget: budget, num_people: num_people, date: date, type: accommodation_labels[accommodation]),);
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
  final String date;
  final String state;
  final int num_people;
  final double budget;
  final String type;

  TravelPlanCard({required this.travel_plan, required this.state, required this.budget, required this.num_people, required this.date, required this.type});

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
              child: Image.asset(
                travel_plan.img, // 이미지 경로 사용
                fit: BoxFit.cover, // 이미지가 잘 맞도록 설정
              ),
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
                        label: Text('${num_people}명'),
                        avatar: Icon(Icons.person, size: 14),
                      ),
                      SizedBox(width: 8),
                      Chip(
                        label: Text('${travel_plan.hotel} ${type}'),
                        avatar: Icon(Icons.hotel, size: 14),
                      ),
                      SizedBox(width: 8),
                      Chip(
                        label: Text('${travel_plan.keyword}'),
                        avatar: Icon(Icons.tag, size: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // 여행 계획 정보 텍스트
                  Text('Trip to ${state} ${travel_plan.name}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₩ ${(budget+travel_plan.price)/2} 만원',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${travel_plan.summary}',
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Date: ${date}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
  final String img;
  final String hotel;
  final String keyword;
  final String name;
  final double price;
  final String summary;

  TravelPlan({
    required this.img,
    required this.hotel,
    required this.keyword,
    required this.name,
    required this.price,
    required this.summary,
  });
}

