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
    return Scaffold(
      appBar: widgetAppBar(context, 'Search Page'),
      body: travelInfo == null
      ? widgetEmptyPage()
      : Column(
        children:<Widget>[
        _widgetExpansionTile(context, travelInfo, formatDateRange(travelInfo.departure, travelInfo.arrival)),
        const SizedBox(height:10),
        _widgetTravelPlanListView(context)
        ]
      )
    );
  }
  Widget _widgetExpansionTile(BuildContext context, UserInput travelInfo, String date){
    return ExpansionTile(
      backgroundColor: Colors.cyan[50],
      collapsedBackgroundColor: Colors.cyan[50],
      // Expansion Tile 제목
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
      // Tile 세부 내용 
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Row(
            children:[
              SizedBox(width:10),
              Icon(Icons.location_on, color: Colors.cyan[900]!.withOpacity(0.75)),
              SizedBox(width: 8.0),
              Text('${travelInfo.state}, ${travelInfo.country}', style: TextStyle(fontSize: 14.0)),
            ]
          ), 
          SizedBox(height:8), 
          Row(
            children:[
              SizedBox(width:10),
              Icon(Icons.calendar_today, color: Colors.cyan[900]!.withOpacity(0.75)),
              SizedBox(width: 8.0),
              Text('$date', style: TextStyle(fontSize: 14.0)),
              ]
          ),
          SizedBox(height:8),
        ],
      ),
      //오른쪽 아이콘들
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
      //Expand된 타일 내용
      children: <Widget>[
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children:[
              Row(
                children:[
                  SizedBox(width: 10.0),
                  Icon(Icons.person, color: Colors.cyan[900]!.withOpacity(0.75)),
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
                ]
              ), 
              SizedBox(height:10),
              Row(
                children:[
                for (int i = 0; i < travelInfo.travelStyle.length; i++)
                  if (travelInfo.travelStyle[i])
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: Text(travelStyleLabels[i], style: TextStyle(fontSize: 14.0)),
                      ),
                    ),
                  ]
                )
              ]
            )
          ),
        ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
    );
  }
  Widget _widgetTravelPlanListView(context){
    return Expanded(
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
          child: TravelPlanCard(travel_plan: travel_plans[index]),);
        },
      ),  
    );
  }
}

class TravelPlanCard extends StatelessWidget {
  final TravelPlan travel_plan;
  TravelPlanCard({required this.travel_plan});

  @override
  Widget build(BuildContext context) {
    final travelInfo = context.watch<UserInputProvider>().userInput;

    if (travelInfo == null) {
      return SizedBox();
    }

    String date = formatDateRange(travelInfo.departure, travelInfo.arrival);
    
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
                        label: Text('${travelInfo.numPeople}명'),
                        avatar: Icon(Icons.person, size: 14),
                      ),
                      SizedBox(width: 8),
                      Chip(
                        label: Text('${travel_plan.hotel} ${accommodationLabels[travelInfo.accommodation]}'),
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
                  Text('[${travelInfo.state}] ${travel_plan.title}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '₩ ${travel_plan.price} 만원',
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