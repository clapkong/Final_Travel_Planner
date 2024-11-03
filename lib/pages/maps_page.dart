import 'package:flutter/material.dart';
import 'package:travel_planner/pages/home_page.dart';
import 'package:travel_planner/main.dart';
bool isSwipeUp =false;

class MapsPage extends StatefulWidget {
  final String date;
  final String country;
  final String state;

  MapsPage({
    required this.date,
    required this.country,
    required this.state,
  });

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  double _currentScale = 1.0;
  final TransformationController _transformationController = TransformationController();
  bool isSwipeUp = false;

  void _zoomIn() {
    setState(() {
      _currentScale += 0.2;
      _updateTransformation();
    });
  }

  void _zoomOut() {
    setState(() {
      if (_currentScale > 1.0) {
        _currentScale -= 0.2;
        _updateTransformation();
      }
    });
  }

  void _updateTransformation() {
    _transformationController.value = Matrix4.identity()
      ..scale(_currentScale)
      ..translate(
        _transformationController.value.getTranslation().x.clamp(
            -MediaQuery.of(context).size.width * (_currentScale - 1),
            MediaQuery.of(context).size.width * (_currentScale - 1)),
        _transformationController.value.getTranslation().y.clamp(
            -MediaQuery.of(context).size.height * (_currentScale - 1),
            MediaQuery.of(context).size.height * (_currentScale - 1)),
      );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maps Page',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan[900]),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.75),
      ),
      body: SafeArea(
        child: GestureDetector(
          onPanEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy > -100) {
              setState(() {
                isSwipeUp = true;
              });
            } else {
              setState(() {
                isSwipeUp = false;
              });
            }
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.cyan[50],
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Trip to ${widget.state}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black.withOpacity(0.75))),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.cyan[900]!.withOpacity(0.75)),
                                      SizedBox(width: 8.0),
                                      Text('${widget.state}, ${widget.country}',
                                          style: TextStyle(fontSize: 14.0)),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Colors.cyan[900]!.withOpacity(0.75)),
                                      SizedBox(width: 8.0),
                                      Text(widget.date, style: TextStyle(fontSize: 14.0)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit,
                                  color: Colors.cyan[900]!.withOpacity(0.75)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        InteractiveViewer(
                          transformationController: _transformationController,
                          boundaryMargin: EdgeInsets.zero,
                          minScale: 1.0,
                          child: Image.asset(
                            '../assets/images/map.png',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 2,
                            height: MediaQuery.of(context).size.height * 2,
                          ),
                        ),
                        Positioned(
                          right: 16.0,
                          bottom: !isSwipeUp ? size.height * 0.37 : size.height * 0.07,
                          child: Column(
                            children: [
                              FloatingActionButton(
                                heroTag: "zoomIn",
                                onPressed: _zoomIn,
                                child: Icon(Icons.add, color: Colors.cyan[900]),
                              ),
                              SizedBox(height: 10),
                              FloatingActionButton(
                                heroTag: "zoomOut",
                                onPressed: _zoomOut,
                                child: Icon(Icons.remove, color: Colors.cyan[900]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //참고 코드: https://github.com/raj4477/Templates/blob/main/CustomDraggableBottomSheet.dart
              AnimatedPositioned(
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 300),
                top: !isSwipeUp ? size.height * 0.5 : size.height * 0.8,
                child: GestureDetector(
                  onPanEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dy > -100) {
                      setState(() {
                        isSwipeUp = true;
                      });
                    } else {
                      setState(() {
                        isSwipeUp = false;
                      });
                    }
                  },
                  child: CustomBottomSheet(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int currentDay = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Icon(
              isSwipeUp ? Icons.expand_more_outlined : Icons.expand_less_outlined,
              size: 30,
              color: Colors.cyan,
            ),
          ),
          SizedBox(height: 20),
          Text('- 여행 일정 -', style:TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color:Colors.black.withOpacity(0.75))),
           SizedBox(height: 15),
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
          ),SizedBox(height: 20),
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
                      children: getScheduleItemsForDay(currentDay), 
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
    List<Widget> getScheduleItemsForDay(int day) {
    if (day == 1) {
      return [
        ScheduleItem(
          index: 1,
          time: '10:00 - 11:30',
          title: '호텔 체크인',
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
      ];
    } else if (day == 2) {
      return [
        ScheduleItem(
          index: 1,
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
          index: 2,
          time: '12:30 - 13:00',
          title: '지하철 타고 이동',
          location: '국립중앙박물관',
          subwayInfo: '2호선, 신촌역역 4번 출구',
          icons: [
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
      ];
    } else {
      return [
        ScheduleItem(
          index: 1,
          time: '10:00 - 11:30',
          title: '호텔 체크아웃',
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
      ];
    }
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

