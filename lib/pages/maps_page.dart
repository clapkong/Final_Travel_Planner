import 'package:flutter/material.dart';
import 'package:travel_planner/pages/home_page.dart';
import 'package:travel_planner/main.dart';


class MapsPage extends StatefulWidget {
  //final String command; 
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
  final DraggableScrollableController sheetController = DraggableScrollableController();

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
    // Prevent zooming out beyond the initial size and ensure image stays within bounds
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Page', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan[900]),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.75),
      ),
      body: Column(
        children:[
          Container(
            color: Colors.cyan[50],
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SafeArea(
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
                                Text('Trip to ${widget.state}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.75))),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.cyan[900]!.withOpacity(0.75)),
                                SizedBox(width: 8.0),
                                Text('${widget.state}, ${widget.country}', style: TextStyle(fontSize: 14.0)),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.cyan[900]!.withOpacity(0.75)),
                                SizedBox(width: 8.0),
                                Text(widget.date, style: TextStyle(fontSize: 14.0)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.cyan[900]!.withOpacity(0.75)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                InteractiveViewer(
                  transformationController: _transformationController,
                  boundaryMargin: EdgeInsets.zero, // Increased boundary margin to prevent image from going out of bounds
                  minScale: 1.0, // Set minimum scale to prevent zooming out too much
                  child:Image.asset(
                    '../assets/images/map.png',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 2,
                    height: MediaQuery.of(context).size.height * 2,
                  ),
                ),
                Positioned(
                  right: 16.0,
                  bottom: 16.0,
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
              ]
            )
          ),
        ]
      )
    );
  }
}