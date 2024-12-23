import 'package:flutter/material.dart';

class ScheduleList extends StatefulWidget {
  final Map<String, dynamic> scheduleData;

  const ScheduleList({
    required this.scheduleData,
  });

  @override
  _ScheduleListState createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  int currentDay = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            ...List.generate(widget.scheduleData.keys.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text('Day ${index + 1}'),
                  selected: currentDay == (index + 1),
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        currentDay = index + 1;
                      });
                    }
                  },
                ),
              );
            }),
          ],
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
                    children: getScheduleItemsForDay(widget.scheduleData, currentDay),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<Widget> getScheduleItemsForDay(Map<String, dynamic> scheduleData, int day) {
  String dayKey = 'Day$day';
  if (!scheduleData.containsKey(dayKey)) {
    return [Text('해당 날짜의 일정이 없습니다.')];
  }

  return (scheduleData[dayKey] as List<dynamic>).map<Widget>((item) {
    return Column(
      children: [
        ScheduleItem(
          index: item['index'],
          time: item['time'],
          title: item['title'],
          location: item['location'] ?? null,
          subwayInfo: item['subwayInfo'] ?? null,
          cost: item.containsKey('cost') ? '${item['cost']} ₩' : null,
        ),
        SizedBox(height: 16),
      ],
    );
  }).toList();
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

  const ScheduleItem({
    required this.index,
    required this.time,
    required this.title,
    this.location,
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
                        ],
                      ),
                      if (location != null) buildInfoRow(Icons.location_on, location!),
                      if (subwayInfo != null) buildInfoRow(Icons.directions_subway, subwayInfo!),
                      if (cost != null) buildInfoRow(Icons.attach_money, cost!),
                      SizedBox(height: 16),
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

  Widget buildInfoRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
}
