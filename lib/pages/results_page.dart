import 'package:flutter/material.dart';
import 'package:travel_planner/pages/maps_page.dart';

class ResultsPage extends StatefulWidget {
  final dynamic travelPlan;
  final String state;
  final double budget;
  final int numPeople;
  final String date;
  final String type;

  ResultsPage({
    required this.travelPlan,
    required this.state,
    required this.budget,
    required this.numPeople,
    required this.date,
    required this.type,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Page', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan[900]),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Travel Plan: ${widget.travelPlan.name}'),
            Text('State: ${widget.state}'),
            Text('Budget: ${widget.budget}'),
            Text('Number of People: ${widget.numPeople}'),
            Text('Date: ${widget.date}'),
            Text('Accommodation Type: ${widget.type}'),
          ],
        ),
      ),
    );
  }
}