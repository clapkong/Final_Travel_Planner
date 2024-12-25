// lib/pages/results_page.dart
import 'package:flutter/material.dart';
import 'favorites_page.dart';
import '../widgets/itinerary.dart';

class ResultsPage extends StatelessWidget {
  final Map<String, dynamic> travelPlan;

  ResultsPage({required this.travelPlan});

  @override
  Widget build(BuildContext context) {
    final String name = travelPlan["name"] ?? "No Name";

    return Scaffold(
      appBar: AppBar(title: Text('Results Detail')),
      body: Column(
        children: [
          SizedBox(height: 30),
          Text("일정: $name", style: TextStyle(fontSize: 20)),
          SizedBox(height: 30),
          Expanded(
            child: _buildScheduleList(travelPlan),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleList(Map<String, dynamic> planData) {
    final dayMap = convertChatGPTPlanToDayMap(planData);
    return ScheduleList(scheduleData: dayMap, currency: planData!["currency"]);
  }

  Map<String, List<Map<String, dynamic>>> convertChatGPTPlanToDayMap(
      Map<String, dynamic> planData) {
    final List<dynamic> days = planData["days"] ?? [];
    final Map<String, List<Map<String, dynamic>>> result = {};

    for (var day in days) {
      final dayIndex = day["day"];
      final itineraryList = day["itinerary"] ?? [];
      result["Day$dayIndex"] = List<Map<String, dynamic>>.from(itineraryList);
    }

    return result;
  }
}
