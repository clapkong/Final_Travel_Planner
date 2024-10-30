import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  //final String command; 
  final DateTime departure;
  final DateTime arrival;
  final String country;
  final String state;
  final String city;
  final int num_people;
  final double budget;
  final int accommodation;
  final List<bool> travel_style;

  SearchPage({
    required this.departure,
    required this.arrival,
    required this.country,
    required this.state,
    required this.city,
    required this.num_people,
    required this.budget,
    required this.accommodation,
    required this.travel_style,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display search result data
            Text('${widget.departure}'),
            Text('${widget.arrival}'),
            Text('${widget.country}'),
            Text('${widget.state}'),
            Text('${widget.city}'),
            Text('${widget.num_people}'),
            Text('${widget.budget}'),
            Text('${widget.accommodation}'),
            Text('${widget.travel_style}'),
          ],
        ),
      ),
    );
  }
}

