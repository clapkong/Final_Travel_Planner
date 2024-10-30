import 'package:flutter/material.dart';


class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  double _currentScale = 1.0;
  final TransformationController _transformationController = TransformationController();

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
    return Center(
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
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  onPressed: _zoomOut,
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}
