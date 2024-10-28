import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 디버그 표시를 없앤다.
      debugShowCheckedModeBanner: false,
      title: 'Travel Optimizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
        fontFamily: "Pretendard",
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    MapsPage(),
    FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          ['Home', 'Search', 'Maps', 'Favorites'][_selectedIndex],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan[900]),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime date_from = DateTime.now();
  DateTime date = DateTime.now();
  bool flag_from = false;
  bool flag = false;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  int _counter = 1;
  double _currentSliderValue = 20;
  int accommodation = 0;
  List<bool> travel_style = [false, false, false, false, false, false];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _updateAddress() {
                setState(() {
                  address = "$cityValue, $stateValue, $countryValue";
                });
              }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          //AI Command Textbox 
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'AI Planner에게 여행 계획을 알려주세요!',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: () {
                  // Here you can add functionality to start voice recognition
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('음성 인식이 완료되었습니다.'),
                    ),
                  );
                },
              ),
            ],
          ),
          Text('여행 스타일이나 특이사항 등을 AI에게 편하게 말씀해주세요!'),
          SizedBox(height:30),
          Text('Give us a little more information about your joruney :)'), 
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Text('목적지(Desitnation): '),
              Expanded(
                child: CSCPicker(
                  ///Enable disable state dropdown [OPTIONAL PARAMETER]
                  showStates: true,

                  /// Enable disable city drop down [OPTIONAL PARAMETER]
                  showCities: true,

                  ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                  flagState: CountryFlag.DISABLE,

                  ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade300,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  ///placeholders for dropdown search field
                  countrySearchPlaceholder: "Country",
                  stateSearchPlaceholder: "State",
                  citySearchPlaceholder: "City",

                  ///labels for dropdown
                  countryDropdownLabel: "Country",
                  stateDropdownLabel: "State",
                  cityDropdownLabel: "City",

                  ///Disable country dropdown (Note: use it with default country)
                  //disableCountry: true,

                  ///selected item style [OPTIONAL PARAMETER]
                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                  dropdownHeadingStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),

                  ///DropdownDialog Item style [OPTIONAL PARAMETER]
                  dropdownItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),

                  ///Dialog box radius [OPTIONAL PARAMETER]
                  dropdownDialogRadius: 10.0,

                  ///Search bar radius [OPTIONAL PARAMETER]
                  searchBarRadius: 10.0,

                  ///triggers once country selected in dropdown
                  onCountryChanged: (value) {
                    setState(() {
                      ///store value in country variable
                      countryValue = value;
                      _updateAddress();
                    });
                  },

                  ///triggers once state selected in dropdown
                  onStateChanged: (value) {
                    setState(() {
                      ///store value in state variable
                      stateValue = value ?? '';
                      _updateAddress();
                    });
                  },

                  ///triggers once city selected in dropdown
                  onCityChanged: (value) {
                    setState(() {
                      ///store value in city variable
                      cityValue = value ?? '';
                      _updateAddress();
                    });
                  },

                  ///Show only specific countries using country filter
                  // countryFilter: ["United States", "Canada", "Mexico"],
                ),
              ),
              ],
          ),
          Text(address),
          //여행 기간
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('여행 기간(Duration): '),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: date_from,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  );
                  if(selectedDate != null){
                    setState((){
                      date_from = selectedDate;
                    });
                    flag_from = true;
                  }
                },
                child: Text(
                  flag_from==false? 'From':"${date_from.year.toString()}-${date_from.month.toString().padLeft(2, '0')}-${date_from.day.toString().padLeft(2, '0')}",
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                  );
                  if(selectedDate != null){
                    setState((){
                      date = selectedDate;
                    });
                    flag = true;
                  }
                },
                child: Text(
                  flag==false? 'To':"${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                ),
              ),
            ]
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('여행 인원:'),
              SizedBox(width:50),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _decrementCounter,
              ),
              Text(
                '$_counter',
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _incrementCounter,
              ),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('예산(만원):  '),
              Text("${_currentSliderValue} "),
              Slider(
                value: _currentSliderValue,
                max: 2000,
                divisions: 2000,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
            ]
          ),
          //선호하는 숙소 유형
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('선호하는 숙소 유형: '),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: accommodation,
                    onChanged: (value) {
                      setState(() {
                        accommodation = value!;
                      });
                    },
                  ),
                  Text('호텔'),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: accommodation,
                    onChanged: (value) {
                      setState(() {
                        accommodation = value!;
                      });
                    },
                  ),
                  Text('게하'),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: accommodation,
                    onChanged: (value) {
                      setState(() {
                        accommodation = value!;
                      });
                    },
                  ),
                  Text('리조트'),
                ],
              ),
              SizedBox(width: 20),
              Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: accommodation,
                    onChanged: (value) {
                      setState(() {
                        accommodation = value!;
                      });
                    },
                  ),
                  Text('Airbnb'),
                ],
              ),
              SizedBox(width: 20),
            ]
          ),
          SizedBox(height: 10),
          //여행 스타일
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('여행 스타일: '),
              Column(
                children:[
                  Row(
                    children: [
                      Checkbox(
                        value: travel_style[0],
                        onChanged: (value) {
                          setState(() {
                            travel_style[0] = value!;
                          });
                        },
                      ),
                      Text('휴양 및 힐링'),
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: travel_style[3],
                        onChanged: (value) {
                          setState(() {
                            travel_style[3] = value!;
                          });
                        },
                      ),
                      Text('가족 여행'),
                    ],
                  ),
                ]
              ),
              Column(
                children:[
                  Row(
                    children: [
                      Checkbox(
                        value: travel_style[1],
                        onChanged: (value) {
                          setState(() {
                            travel_style[1] = value!;
                          });
                        },
                      ),
                      Text('기념일'),
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: travel_style[4],
                        onChanged: (value) {
                          setState(() {
                            travel_style[4] = value!;
                          });
                        },
                      ),
                      Text('관광'),
                    ],
                  ),
                ]
              ),
              Column(
                children:[
                  Row(
                    children: [
                      Checkbox(
                        value: travel_style[2],
                        onChanged: (value) {
                          setState(() {
                            travel_style[2] = value!;
                          });
                        },
                      ),
                      Text('호캉스'),
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: travel_style[5],
                        onChanged: (value) {
                          setState(() {
                            travel_style[5] = value!;
                          });
                        },
                      ),
                      Text('가족여행'),
                    ],
                  ),
                ]
              ),
            ]
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Maps Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorites Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
