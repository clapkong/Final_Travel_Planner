// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:csc_picker/csc_picker.dart';
import '../pages/custom_csc_picker.dart';

import '../providers/travel_search_provider.dart';
import '../models/travel_search_request.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String command = "";
  DateTime departure = DateTime.now();
  DateTime arrival = DateTime.now();
  String country = "";
  String state = "";
  String city = "";
  int numPeople = 1;
  double budget = 20.0;
  int accommodation = 0;
  List<bool> travelStyle = [false, false, false, false, false, false];
  bool flagSetDepartureDate = false;
  bool flagSetArrivalDate = false;
  String address = "";
  String currency = "KRW";

  //numPeople increment
  void _incrementCounter() {
    setState(() {
      numPeople++;
    });
  }

  //numPeople decrement
  void _decrementCounter() {
    setState(() {
      if (numPeople > 1) {
        numPeople--;
      }
    });
  }

  //Style 변수들
  final themeColor = Colors.cyan;
  final Color? themeColor900 = Colors.cyan[900];
  final subtitletextStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan[900]);
  final double? subIconSize = 18;

  final TextEditingController _textController = TextEditingController();

  void _updateAddress() {
    setState(() {
      address = [city, state, country].where((e) => e?.isNotEmpty ?? false).join(", ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.unfocus();
      }
    },
    child: Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            _widgetAICommandInput(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.flight, color: themeColor900, size: 20),
                SizedBox(width: 8),
                Text('여행 정보 입력 ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeColor900)),
              ],
            ),
            const SizedBox(height: 5),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text('추가 정보를 입력해 주시면 AI가 더욱 정확하게 도와드릴 수 있습니다 :)', softWrap:true, overflow:TextOverflow.visible),
                )
              ],
            ),
            const SizedBox(height: 20),
            _widgetDestinationPicker(),
            _widgetDatePicker(),
            _widgetNumPeopleCounter(),
            _widgetBudgetSlider(),
            const SizedBox(height: 3),
            _widgetAccommodationSelector(),
            const SizedBox(height: 15),
            _widgetTravelStyleSelector(),
            _widgetCurrencySelector(),
            const SizedBox(height: 30),
            _widgetUserInputUpdate(),
          ],
        ),
      ),
    ),);
  }

  Widget _widgetAICommandInput() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _textController,
            autofocus: false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'AI Planner에게 여행 계획을 알려주세요!',
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: themeColor900!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: themeColor900!,
                  width: 2.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              Text(
                '추가 특이사항/스타일 등을 자유롭게 적어보세요.',
                style: TextStyle(color: themeColor900, fontSize: 11),
              ),
            ],
          ),
          SizedBox(height: 10),
          Divider(height: 30, color: Colors.grey[300]),
        ],

    );
  }


  Widget _widgetDestinationPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.place, color: themeColor900, size: subIconSize),
            SizedBox(width: 8),
            Text('목적지(Destination): ', style: subtitletextStyle),
          ],
        ),
        SizedBox(height: 5),
        CSCPicker(
          showStates: true,
          showCities: true,
          onCountryChanged: (value) {
            setState(() {
              country = value;
              _updateAddress();
            });
          },
          onStateChanged: (value) {
            setState(() {
              if (value != 'State') {
                state = value ?? '';
                _updateAddress();
              }
            });
          },
          onCityChanged: (value) {
            setState(() {
              if (value != 'City') {
                city = value ?? '';
                _updateAddress();
              }
            });
          },
          onChanged: () {
            setState(() {FocusScope.of(context).unfocus();});
          },
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
              border: Border.all(color: Colors.cyan.shade100, width: 1)),

          //Disabled Dropdown box
          disabledDropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.cyan.shade100,
              border: Border.all(color: Colors.cyan.shade100, width: 1)),

          //Selected item
          selectedItemStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),

          //DropdownDialog Heading
          dropdownHeadingStyle: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),

          ///DropdownDialog Item
          dropdownItemStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),

          searchBarRadius: 15.0, //Search bar radius
        ),
        Text(address),
        SizedBox(height: 10),
      ],
    );
  }

  //'${departure.year}.${departure.month}.${departure.day}'
  //'${arrival.year}.${arrival.month}.${arrival.day}'
  Widget _widgetDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(Icons.schedule, color: themeColor900, size: subIconSize),
          SizedBox(width: 8),
          Text('여행 기간(Duration): ', style: subtitletextStyle),
          SizedBox(width: 10),
          Expanded(
            child: SingleChildScrollView( scrollDirection: Axis.horizontal, child:Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Spacer(),
              SizedBox(width: 5),

              //Departure Date Select Button
              ElevatedButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text(flagSetDepartureDate == false
                    ? 'From'
                    : '${departure.year}.${departure.month}.${departure.day}'),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: departure,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (selectedDate != null) {
                    setState(() {
                      departure = selectedDate;
                    });
                    flagSetDepartureDate = true;
                  }
                },
              ),
              // Spacer(),
              SizedBox(width: 5),

              //Arrival Date Select Button
              ElevatedButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text(
                  flagSetArrivalDate == false
                      ? 'To'
                      : '${arrival.year}.${arrival.month}.${arrival.day}',
                ),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: arrival,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  );
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (selectedDate != null) {
                    setState(() {
                      FocusScope.of(context).unfocus();
                      arrival = selectedDate;
                    });
                    flagSetArrivalDate = true;
                  }
                },
              ),
              // Spacer(),
              SizedBox(width: 5),
            ]),),
          )
        ]),
        Text(departure.compareTo(arrival) > 0 ? '여행 일정을 확인해주세요.' : '',
            style: TextStyle(color: Colors.red)),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _widgetNumPeopleCounter() {
    return NumPeopleCounter(
      numPeople: numPeople,
      increment: _incrementCounter,
      decrement: _decrementCounter,
      subtitleTextStyle: subtitletextStyle,
      iconColor: themeColor900,
      iconSize: subIconSize,
    );
  }

  Widget _widgetBudgetSlider() {
    return BudgetSlider(
      budget_raw: budget,
      onChanged: (value) {
        setState(() {
          budget = value;
        });
      },
      subtitleTextStyle: subtitletextStyle,
      iconColor: themeColor900,
      iconSize: subIconSize,
    );
  }

  Widget _widgetAccommodationSelector() {
    return AccommodationSelector(
      accommodation: accommodation,
      onChanged: (value) {
        setState(() {
          accommodation = value!;
        });
      },
      subtitleTextStyle: subtitletextStyle,
      iconColor: themeColor900,
      iconSize: subIconSize,
    );
  }

  Widget _widgetTravelStyleSelector() {
    List<String> travelStyleLabels = [
      '휴양 및 힐링',
      '기념일',
      '호캉스',
      '가족여행',
      '관광',
      '역사 탐방'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.explore, color: themeColor900, size: subIconSize),
            SizedBox(width: 8),
            Text('여행 스타일: ', style: subtitletextStyle),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (colIndex) {
            return Expanded(
              child: Column(
                children: List.generate(2, (rowIndex) {
                  int index = colIndex * 2 + rowIndex;
                  return Row(
                    children: [
                      Checkbox(
                        value: travelStyle[index],
                        onChanged: (value) {
                          setState(() {
                            travelStyle[index] = value!;
                          });
                        },
                      ),
                      Expanded(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Text(travelStyleLabels[index]),)),
                    ],
                  );
                }),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _widgetCurrencySelector() {
    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.currency_exchange,
                color: themeColor900, size: subIconSize),
            SizedBox(width: 8),
            Text('통화: ', style: subtitletextStyle),
          ],
        ),
        DropdownButton<String>(
          value: currency,
          items: <String>['KRW', 'USD', 'JPY', 'EUR']
              .map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              currency = val ?? "KRW";
            });
          },
        ),
      ],
    );
  }

  Widget _widgetUserInputUpdate() {
    return ElevatedButton(
      child: const Text('여행 계획 만들기!'),
      onPressed: () {
        if (departure.compareTo(arrival) > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("출발 일자와 도착 일자를 확인해주세요.")),
          );
          return;
        }
        command = _textController.text;

        final req = TravelSearchRequest(
          departure: departure,
          arrival: arrival,
          country: country,
          state: state,
          city: city,
          numPeople: numPeople,
          budget: budget,
          currency: currency,
          accommodation: accommodation,
          travelStyle: travelStyle,
          command: command,
        );

        context.read<TravelSearchProvider>().updateRequest(req);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
    );
  }
}

abstract class SimpleInputField extends StatelessWidget {
  final TextStyle subtitleTextStyle;
  final Color? iconColor;
  final double? iconSize;
  final String label;
  final IconData icon;

  const SimpleInputField({
    required this.subtitleTextStyle,
    required this.iconColor,
    required this.iconSize,
    required this.label,
    required this.icon,
    Key? key,
  }) : super(key: key);

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: iconSize),
        SizedBox(width: 8),
        Text(label, style: subtitleTextStyle),
        Expanded(
          child: buildContent(context),
        ),
      ],
    );
  }
}

class NumPeopleCounter extends SimpleInputField {
  final int numPeople;
  final VoidCallback increment;
  final VoidCallback decrement;

  const NumPeopleCounter({
    required this.numPeople,
    required this.increment,
    required this.decrement,
    required TextStyle subtitleTextStyle,
    Color? iconColor,
    double? iconSize,
  }) : super(
          subtitleTextStyle: subtitleTextStyle,
          iconColor: iconColor,
          iconSize: iconSize,
          label: '여행 인원:',
          icon: Icons.group,
        );
  @override
  Widget buildContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: decrement,
        ),
        Text('$numPeople'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: increment,
        ),
      ],
    );
  }
}

class BudgetSlider extends SimpleInputField {
  final double budget_raw;
  final ValueChanged<double> onChanged;

  const BudgetSlider({
    required this.budget_raw,
    required this.onChanged,
    required TextStyle subtitleTextStyle,
    Color? iconColor,
    double? iconSize,
  }) : super(
          subtitleTextStyle: subtitleTextStyle,
          iconColor: iconColor,
          iconSize: iconSize,
          label: '예산(만원):',
          icon: Icons.attach_money,
        );

  @override
  Widget buildContent(BuildContext context) {
    final int budget = budget_raw.round() <= 20 ? budget_raw.round()*5 : (budget_raw.round() <= 38 ? budget_raw.round()*50-900 : budget_raw.round()*100-2800);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 80, child: Text(" ${budget} 만원"),
        ),
        Expanded(child: Slider(
          value: budget_raw,
          max: 51,
          divisions: 51,
          label: budget.toString(),
          onChanged: onChanged,
        ),),
      ],
    );
  }
}

class AccommodationSelector extends SimpleInputField {
  final int accommodation;
  final ValueChanged<int?> onChanged;

  const AccommodationSelector({
    required this.accommodation,
    required this.onChanged,
    required TextStyle subtitleTextStyle,
    Color? iconColor,
    double? iconSize,
  }) : super(
          subtitleTextStyle: subtitleTextStyle,
          iconColor: iconColor,
          iconSize: iconSize,
          label: '선호하는 숙소 유형:',
          icon: Icons.hotel,
        );

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView( scrollDirection: Axis.horizontal, child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        String label;
        switch (index) {
          case 0:
            label = '호텔';
            break;
          case 1:
            label = '게하';
            break;
          case 2:
            label = '리조트';
            break;
          case 3:
            label = 'Airbnb';
            break;
          default:
            label = '';
        }
        return Row(
          children: [
            Radio(
              value: index,
              groupValue: accommodation,
              onChanged: onChanged,
            ),
            Text(label),
            SizedBox(width: 5),
          ],
        );
      }),
    ),);
  }
}
