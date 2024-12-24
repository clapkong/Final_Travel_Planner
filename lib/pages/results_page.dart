// lib/pages/results_page.dart
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final Map<String, dynamic> travelPlan;

  ResultsPage({required this.travelPlan});

  @override
  Widget build(BuildContext context) {
    final String name = travelPlan["name"] ?? "No Name";
    final List<dynamic> days = travelPlan["days"] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('Results Detail')),
      body: Column(
        children: [
          Text("일정: $name", style: TextStyle(fontSize: 20)),
          Expanded(
            child: ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, index) {
                final dayPlan = days[index];
                return _buildDayCard(dayPlan);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard(Map<String, dynamic> dayPlan) {
    final dayIndex = dayPlan["day"];
    final itinerary = dayPlan["itinerary"] ?? [];

    return Card(
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Day $dayIndex"),
            SizedBox(height: 8),
            ...(itinerary as List).map((item) {
              final time = item["time"] ?? "";
              final title = item["title"] ?? "";
              final location = item["location"] ?? "";
              final cost = item["cost"] ?? 0;
              return ListTile(
                title: Text("$time | $title"),
                subtitle: Text("$location, 비용: $cost"),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
