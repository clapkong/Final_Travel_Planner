import 'package:flutter/material.dart';
import 'package:travel_planner/pages/home_page.dart';
import 'package:travel_planner/main.dart';
import 'package:travel_planner/pages/results_page.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/pseudodata.dart';
import 'package:travel_planner/widgets/itinerary.dart';

bool isSwipeUp =false;

class MapsPage extends StatefulWidget {

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
    final travelInfo = context.watch<UserInputProvider>().userInput;
    if (travelInfo == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Search Page')),
        body: Center(child: Text('저장된 여행 정보가 없습니다.')),
      );
    }

    String date =
        '${travelInfo.departure.year.toString()}.${travelInfo.departure.month.toString().padLeft(2, '0')}.${travelInfo.departure.day.toString().padLeft(2, '0')} - ${travelInfo.arrival.year.toString()}.${travelInfo.arrival.month.toString().padLeft(2, '0')}.${travelInfo.arrival.day.toString().padLeft(2, '0')}';
    
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
                                      Text('Trip to ${travelInfo.state}',
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
                                      Text('${travelInfo.state}, ${travelInfo.country}',
                                          style: TextStyle(fontSize: 14.0)),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Colors.cyan[900]!.withOpacity(0.75)),
                                      SizedBox(width: 8.0),
                                      Text(date, style: TextStyle(fontSize: 14.0)),
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
          Flexible(child:ScheduleList(scheduleData: pseudoItinerary)),
        ],
      ),
    );
  }
}
