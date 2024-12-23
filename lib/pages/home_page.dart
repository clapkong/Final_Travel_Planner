import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:travel_planner/main.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner/pages/search_page.dart';

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

  bool flagSetDepartureDate = false; // 사용자가 출발 날짜 선택했는지 여부
  bool flagSetArrivalDate = false; //사용자가 도착 날짜 선택했는지 여부
  String address = ""; // 사용자가 선택한 국가 및 도시 

  List<String> travelStyleLables = ['휴양 및 힐링', '기념일', '호캉스', '가족여행', '관광','역사 탐방'];
  final TextEditingController _textController = TextEditingController();

  //Style 변수들
  final themeColor = Colors.cyan;
  final Color? themeColor900 = Colors.cyan[900];
  final subtitletextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan[900]);
  final double? subIconSize = 18;

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

  void _updateAddress() {
    setState(() {
      address = "$city, $state, $country";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgetAppBar(context, 'Home Page'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            //AI Command Textbox 
            _widgetAICommandInput(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.flight, color: themeColor900, size: 20), 
                SizedBox(width: 8),
                Text('여행 정보 입력 ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: themeColor900)),
                
              ],
            ),
            const SizedBox(height:5),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('추가 정보를 입력해 주시면 AI가 더욱 정확하게 도와드릴 수 있습니다 :)'),
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
            _widgetUserInputUpdate(),
          ],
        ),
      )
    );
  }
  //TODO: 수정 필요
  Widget _widgetAICommandInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
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
                  ),focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: themeColor900!, 
                      width: 2.0, 
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Text('여행 스타일이나 특이사항을 AI에게 편하게 말씀해주세요!', style: TextStyle(color: themeColor900, fontSize: 11)),
          ],
        ),
        SizedBox(height:10),
        Divider(
          height: 30,
          color: Colors.grey[300],
          ),
      ],
    );
  }
  Widget _widgetDestinationPicker(){
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
        SizedBox(height:5),
        Row(
          children: <Widget>[
            Expanded(
              child: CSCPicker(
                showStates: true, //enable state dropdown
                showCities: true, /// enable city drop down 
                flagState: CountryFlag.DISABLE, //disable flag
                
                //CSC 값 업데이트 
                onCountryChanged: (value) {
                  setState(() {
                    country = value;
                    _updateAddress();
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    state = value ?? '';
                    _updateAddress();
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    city = value ?? '';
                    _updateAddress();
                  });
                },

                //placeholders for dropdown
                countrySearchPlaceholder: "Country",
                stateSearchPlaceholder: "State",
                citySearchPlaceholder: "City",

                //labels for dropdown
                countryDropdownLabel: "  Country",
                stateDropdownLabel: "  State",
                cityDropdownLabel: "  City",

                //Styles
                //기본 Dropdown Box
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    border:
                        Border.all(color: Colors.cyan.shade100, width: 1)),

                //Disabled Dropdown box 
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.cyan.shade100,
                    border:
                        Border.all(color: Colors.cyan.shade100, width: 1)),

                //Selected item
                selectedItemStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),

                //DropdownDialog Heading
                dropdownHeadingStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),

                ///DropdownDialog Item
                dropdownItemStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),

                dropdownDialogRadius: 15.0,//Dialog box radius
                searchBarRadius: 15.0, //Search bar radius
              ),
            ),
          ],
        ),
        Text(address),
        SizedBox(height:10),
      ],
    );
  }
  Widget _widgetDatePicker(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:[
            Icon(Icons.schedule, color: themeColor900, size: subIconSize), 
            SizedBox(width: 8),
            Text('여행 기간(Duration): ', style: subtitletextStyle),
            SizedBox(width: 20),
            Expanded(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),

                //Departure Date Select Button
                ElevatedButton.icon(
                  icon: Icon(Icons.calendar_today),
                  label:Text(flagSetDepartureDate==false? 'From':formatDate(departure)),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: departure,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );
                    if(selectedDate != null){
                      setState((){  
                        departure = selectedDate;
                      });
                      flagSetDepartureDate = true;
                    }
                  },
                ),
                Spacer(),
                
                //Arrival Date Select Button
                ElevatedButton.icon(
                  icon: Icon(Icons.calendar_today),
                  label: Text(
                    flagSetArrivalDate==false? 'To':formatDate(arrival),
                  ),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: arrival,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );
                    if(selectedDate != null){
                      setState((){
                        arrival = selectedDate;
                      });
                      flagSetArrivalDate = true;
                    }
                  },
                ),
                Spacer(),
                ]
              ),
            )
          ]
        ),
        Text(departure.compareTo(arrival) > 0? '여행 일정을 확인해주세요.': '', style:TextStyle(color: Colors.red)
        ),
        SizedBox(height: 20),
      ],
    );
  }
  Widget _widgetNumPeopleCounter(){
    return NumPeopleCounter(
    numPeople: numPeople,
    increment: _incrementCounter,
    decrement: _decrementCounter,
    subtitleTextStyle: subtitletextStyle,
    iconColor: themeColor900,
    iconSize: subIconSize,
  );

  }
  Widget _widgetBudgetSlider(){
    return BudgetSlider(
    budget: budget,
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
  Widget _widgetAccommodationSelector(){
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
  Widget _widgetTravelStyleSelector(){
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
        SizedBox(height:5),
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
                      Text(travelStyleLables[index]),
                    ],
                  );
                }),
              ),
            );
          }),
        ),
        SizedBox(height: 30),
      ],
    );
  }
  Widget _widgetUserInputUpdate(){
    return Center(
      child: ElevatedButton(
        child: const Text('여행 계획 만들기!'),
        onPressed: () {
          if (departure.compareTo(arrival) > 0){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("출발 일자와 도착 일자를 확인해주세요.")),
              );
            });
          }
          else{
            if (_textController.text.isNotEmpty) {
              setState(() {
                command = _textController.text;
            });}
            final userInput = UserInput(
              command: command,
              departure: departure,
              arrival: arrival,
              country: country,
              state: state,
              city: city,
              numPeople: numPeople,
              budget: budget,
              accommodation: accommodation,
              travelStyle: travelStyle,
            );
            //UserInput Provider로 상태 변경
            context.read<UserInputProvider>().updateUserInput(userInput);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          }
        },
      )
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
  final double budget;
  final ValueChanged<double> onChanged;

  const BudgetSlider({
    required this.budget,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${budget} 만원  "),
        Slider(
          value: budget,
          max: 2000,
          divisions: 2000,
          label: budget.round().toString(),
          onChanged: onChanged,
        ),
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
    return Row(
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
            SizedBox(width: 20),
          ],
        );
      }),
    );
  }
}