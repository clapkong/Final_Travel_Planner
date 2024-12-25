// lib/widgets/itinerary.dart
import 'package:flutter/material.dart';

Map<String, List<Map<String, dynamic>>> fetchItineraryById(
    Map<String, dynamic> dbjson, int id) {
  if (dbjson.containsKey('travel_itinery') &&
      dbjson['travel_itinery'].containsKey('$id')) {
    return Map<String, List<Map<String, dynamic>>>.from(
        dbjson['travel_itinery']['$id']);
  }
  return {};
}

class ScheduleList extends StatefulWidget {
  final Map<String, dynamic> scheduleData;
  final String currency;

  const ScheduleList({
    required this.scheduleData,
    required this.currency,
  });

  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  int currentDay = 1;

  @override
  Widget build(BuildContext context) {
    final dayKeys = widget.scheduleData.keys.toList(); // ["Day1", "Day2", ...]
    dayKeys.sort(); // "Day1", "Day2" 순서대로

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(dayKeys.length, (index) {
              final dayLabel = dayKeys[index];
              final numericDay = index + 1;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(dayLabel), // "Day1", "Day2"
                  selected: currentDay == numericDay,
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        currentDay = numericDay;
                      });
                    }
                  },
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 20),
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
                    children: _getScheduleItemsForDay(currentDay, dayKeys),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _getScheduleItemsForDay(int day, List<String> dayKeys) {
    if (day - 1 < 0 || day - 1 >= dayKeys.length) {
      return [SizedBox(height: 20), Center(child: Text('해당 날짜의 일정 없음'))];
    }

    final dayKey = dayKeys[day - 1]; // 예: "Day1"
    if (!widget.scheduleData.containsKey(dayKey)) {
      return [SizedBox(height: 20), Center(child: Text('해당 날짜의 일정 없음'))];
    }

    final dayList = widget.scheduleData[dayKey] as List<dynamic>;
    return dayList.map<Widget>((item) {
      return Column(
        children: [
          ScheduleItem(
            index: item['index'],
            time: item['time'] ?? '',
            title: item['title'] ?? '',
            location: item['location'] ?? '',
            subwayInfo: item['subwayInfo'] ?? '',
            cost: item.containsKey('cost') ? '${item['cost']} ${widget.currency}' : null,
          ),
          SizedBox(height: 16),
        ],
      );
    }).toList();
  }
}

class DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double dashHeight = 4;
        double dashSpace = 4;
        final double dashCount =
            constraints.constrainHeight() / (dashHeight + dashSpace);
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount.floor(),
            (index) => SizedBox(
              width: 2,
              height: dashHeight,
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
  final String location;
  final String? subwayInfo;
  final String? cost;

  const ScheduleItem({
    required this.index,
    required this.time,
    required this.title,
    required this.location,
    this.subwayInfo,
    this.cost,
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan[900],
                ),
              ),
              SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (location.isNotEmpty)
                        _buildInfoRow(Icons.location_on, location),
                      if (subwayInfo != null && subwayInfo!.isNotEmpty)
                        _buildInfoRow(Icons.directions_subway, subwayInfo!),
                      if (cost != null)
                        _buildInfoRow(Icons.attach_money, cost!),
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700], size: 16),
          SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
