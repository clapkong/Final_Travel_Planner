import 'package:flutter/material.dart';
import 'package:travel_planner/pages/results_page.dart';
import 'package:travel_planner/pages/home_page.dart';
import 'package:travel_planner/main.dart';
import 'package:provider/provider.dart';

//ChatGPT로 생성한 가상 관광지
final List<Map<String, dynamic>> pseudoTravelPlan = [{
      "id": 1,
      "search_id": 1,
      "title": "자연과 트레킹",
      "img1": "assets/images/travel_1.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "신라",
      "keyword": "자연적",
      "price": 0.0,
      "summary": "사르바 항구 산책, 미라노 궁 투어, 라펠라 숲 트레킹"
    },
    {
      "id": 2,
      "search_id": 1,
      "title": "호수와 평온함",
      "img1": "assets/images/travel_2.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "메리어트",
      "keyword": "평온함",
      "price": 10.0,
      "summary": "아르보 바자 탐방, 실비아 호수 유람, 에덴 교회 방문"
    },
    {
      "id": 3,
      "search_id": 1,
      "title": "예술과 정원",
      "img1": "assets/images/travel_3.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "조선",
      "keyword": "예술적",
      "price": 40.0,
      "summary": "나리아 미술관, 로미타 정원 산책, 라빈다 성 투어"
    },
    {
      "id": 4,
      "search_id": 1,
      "title": "해변과 여유",
      "img1": "assets/images/travel_4.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "하얏트",
      "keyword": "여유로움",
      "price": 30.0,
      "summary": "이솔리 해변 수영, 루체르 전망대, 파르니 마을 체험"
    },
    {
      "id": 5,
      "search_id": 1,
      "title": "시장과 오솔길",
      "img1": "assets/images/travel_5.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "쉐라톤",
      "keyword": "향토적",
      "price": 15.0,
      "summary": "라코나 시장 구경, 플로렌 언덕 트레킹, 바르미 오솔길 산책"
    },
    {
      "id": 6,
      "search_id": 1,
      "title": "성과 정원",
      "img1": "assets/images/travel_6.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "콘래드",
      "keyword": "고풍적",
      "price": 10.0,
      "summary": "페르노 성 방문, 사피르 정원 산책, 로살리 박물관"
    },
    {
      "id": 7,
      "search_id": 1,
      "title": "예술 여행",
      "img1": "assets/images/travel_7.jpg",
      "img2": "assets/images/carousel_1.jpg",
      "img3": "assets/images/carousel_2.jpg",
      "hotel": "한화",
      "keyword": "역사적",
      "price": 20.0,
      "summary": "엘토아 해양 박물관, 나리아 성벽 투어, 세라노 거리 예술"
    }];


class TravelPlan {
  final int id;
  final int search_id;
  final String title;
  final String img1;
  final String img2;
  final String img3;
  final String hotel;
  final String keyword;
  final double price;
  final String summary;

  TravelPlan({
    required this.id,
    required this.search_id,
    required this.title,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.hotel,
    required this.keyword,
    required this.price,
    required this.summary,
  });
}

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}



class _SearchPageState extends State<SearchPage> {
  bool _customTileExpanded = false;

  final List<TravelPlan> travel_plans = pseudoTravelPlan.map((plan) {
  return TravelPlan(
    id: plan["id"],
    search_id: plan["search_id"],
    title: plan["title"],
    img1: plan["img1"],
    img2: plan["img2"], 
    img3: plan["img3"],
    hotel: plan["hotel"],
    keyword: plan["keyword"],
    price: plan["price"],
    summary: plan["summary"],
  );
  }).toList();

  @override
  Widget build(BuildContext context) {
    final travelInfo = context.watch<UserInputProvider>().userInput;

    if (travelInfo == null) {
      return Scaffold(
        appBar: AppBar(
        title: Text('Search Page', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan[900]),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.75),
        ),
        body: Center(child: Text('Home Page에서 여행 정보를 입력해주세요!')),
      );
    }

    String date =
        '${travelInfo.departure.year.toString()}.${travelInfo.departure.month.toString().padLeft(2, '0')}.${travelInfo.departure.day.toString().padLeft(2, '0')} - ${travelInfo.arrival.year.toString()}.${travelInfo.arrival.month.toString().padLeft(2, '0')}.${travelInfo.arrival.day.toString().padLeft(2, '0')}';
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan[900]),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.75),
      ),
      body:Column(
        children:<Widget>[
          ExpansionTile(
            backgroundColor: Colors.cyan[50],
            collapsedBackgroundColor: Colors.cyan[50],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children:[
              SizedBox(height:5),
              Row(
                children: [
                  SizedBox(width:10),
                  Text('Showing Travel Plans for: ', style:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75))), 
                ]
              ),
              SizedBox(height:8)]
            ),
          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, 
          children: [Row(children:[SizedBox(width:10),Icon(Icons.location_on, color: Colors.cyan[900]!.withOpacity(0.75)),
                                SizedBox(width: 8.0),
                                Text('${travelInfo.state}, ${travelInfo.country}', style: TextStyle(fontSize: 14.0)),]), 
                                SizedBox(height:8), 
                    Row(children:[SizedBox(width:10),Icon(Icons.calendar_today, color: Colors.cyan[900]!.withOpacity(0.75)),
                                SizedBox(width: 8.0),
                                Text('${travelInfo.departure.year.toString()}.${travelInfo.departure.month.toString().padLeft(2, '0')}.${travelInfo.departure.day.toString().padLeft(2, '0')} - ${travelInfo.arrival.year.toString()}.${travelInfo.arrival.month.toString().padLeft(2, '0')}.${travelInfo.arrival.day.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 14.0)),
                              ]),SizedBox(height:8),],),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.cyan[900]!.withOpacity(0.75)),
                onPressed: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                },
              ),
              Icon(
                _customTileExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
              ),
            ],
          ),
          children: <Widget>[
            ListTile(title: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
              Row(children:[SizedBox(width: 10.0),Icon(Icons.person, color: Colors.cyan[900]!.withOpacity(0.75)),
                                SizedBox(width: 8.0),
                                Text('인원: ${travelInfo.numPeople}명', style: TextStyle(fontSize: 14.0)),
                                SizedBox(width: 16.0),
                                Icon(Icons.paid, color: Colors.cyan[900]!.withOpacity(0.75)),
                                SizedBox(width: 8.0),
                                Text('예산: ${travelInfo.budget}만원', style: TextStyle(fontSize: 14.0)),
                                SizedBox(width: 16.0),
                                Icon(Icons.hotel, color: Colors.cyan[900]!.withOpacity(0.75)),
                                SizedBox(width: 8.0),
                                Text('숙소: ${accommodationLabels[travelInfo.accommodation]}', style: TextStyle(fontSize: 14.0)),
                                ]), SizedBox(height:10),
              Row(children:[
                for (int i = 0; i < travelInfo.travelStyle.length; i++)
                  if (travelInfo.travelStyle[i])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: Text('${travelStyleLabels[i]}', style: TextStyle(fontSize: 14.0)),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(
                        travelPlan: travel_plans[index],
                      ),
                    ),
                  );
                },
              child: TravelPlanCard(travel_plan: travel_plans[index], state: travelInfo.state, budget: travelInfo.budget, num_people: travelInfo.numPeople, date: date, type: accommodationLabels[travelInfo.accommodation]),);
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), 
      ),
      elevation: 2.0, 
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              // 여행 계획 이미지 (샘플로 아이콘 사용)
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset(
                  travel_plan.img1, // 이미지 경로 사용
                  fit: BoxFit.cover, // 이미지가 잘 맞도록 설정
                ),
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
                  Text('Trip to ${state} #${travel_plan.title}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '₩ ${(budget*0.8+travel_plan.price*0.2).round()} 만원',//계산 결과가 budget과 어느정도 비슷하나, 음수가 나오지 않게 하기 위해 랜덤하게 만든 임의의 함수.
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.cyan.shade900),
                  ),
                  SizedBox(height: 3),
                  Text(
                    '${travel_plan.summary}',
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey, fontStyle: FontStyle.italic,),
                  ),
                  SizedBox(height: 3),
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