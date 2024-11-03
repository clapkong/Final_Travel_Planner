import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';

class HomePage extends StatefulWidget {
  final Function(DateTime, DateTime, String, String, String, int, double, int, List<bool>) onSearch;
  
  HomePage({required this.onSearch});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime departure = DateTime.now();
  DateTime date = DateTime.now();
  bool flag_from = false;
  bool flag = false;
  String country = "";
  String state = "";
  String city = "";
  String address = "";

  int _num_people = 1;
  double _budget = 20;
  int accommodation = 0;
  List<bool> travel_style = [false, false, false, false, false, false];

  void _incrementCounter() {
    setState(() {
      _num_people++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_num_people > 1) {
        _num_people--;
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
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.cyan[900]),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.75),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(25.0),
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
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.cyan[900]!,
                        ),
                      ),focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.cyan[900]!, 
                          width: 2.0, 
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.cyan[900]),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('음성 인식이 완료되었습니다.'),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Text('여행 스타일이나 특이사항을 AI에게 편하게 말씀해주세요!', style: TextStyle(color: Colors.cyan[900], fontSize: 11)),
              ],
            ),
            SizedBox(height:10),
            Divider(
            height: 30,
            color: Colors.grey[300],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.flight, color: Colors.cyan[900], size: 20), 
                SizedBox(width: 8),
                Text('여행 정보 입력 ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan[900])),
                
              ],
            ),
            SizedBox(height:5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('추가 정보를 입력해 주시면 AI가 더욱 정확하게 도와드릴 수 있습니다 :)'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.place, color: Colors.cyan[900], size: 18), 
                SizedBox(width: 8),
                Text('목적지(Destination): ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan[900])),
                
              ],
            ),
            SizedBox(height:5),
            Row(
              children: <Widget>[
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
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.cyan.shade100, width: 1)),

                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.cyan.shade100,
                        border:
                            Border.all(color: Colors.cyan.shade100, width: 1)),

                    ///placeholders for dropdown search field
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: "  Country",
                    stateDropdownLabel: "  State",
                    cityDropdownLabel: "  City",

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
                    dropdownDialogRadius: 15.0,

                    ///Search bar radius [OPTIONAL PARAMETER]
                    searchBarRadius: 15.0,

                    ///triggers once country selected in dropdown
                    onCountryChanged: (value) {
                      setState(() {
                        ///store value in country variable
                        country = value;
                        _updateAddress();
                      });
                    },

                    ///triggers once state selected in dropdown
                    onStateChanged: (value) {
                      setState(() {
                        ///store value in state variable
                        state = value ?? '';
                        _updateAddress();
                      });
                    },

                    ///triggers once city selected in dropdown
                    onCityChanged: (value) {
                      setState(() {
                        ///store value in city variable
                        city = value ?? '';
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
            SizedBox(height:10),
            Row(
              children:[
                Icon(Icons.schedule, color: Colors.cyan[900], size: 18), 
                SizedBox(width: 8),
                Text('여행 기간(Duration): ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan[900])),
                SizedBox(width: 20),
                Expanded(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                     ElevatedButton.icon(
                  icon: Icon(Icons.calendar_today),
                  label:Text(flag_from==false? 'From':"${departure.year.toString()}-${departure.month.toString().padLeft(2, '0')}-${departure.day.toString().padLeft(2, '0')}"),
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
                      flag_from = true;
                    }
                  },
                ),
                Spacer(),
                ElevatedButton.icon(
                  icon: Icon(Icons.calendar_today),
                  label: Text(
                    flag==false? 'To':"${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                  ),
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
                ),
                Spacer(),
                  ]
                ),
                )
              ]
            ),
            Text(departure.compareTo(date) > 0? '여행 일정을 확인해주세요.': '', style:TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Icon(Icons.group, color: Colors.cyan[900], size: 18), 
                SizedBox(width: 8),
                Text('여행 인원:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan[900])),
                SizedBox(width: 120),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _decrementCounter,
                      ),
                      Text('$_num_people'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _incrementCounter,
                      ),
                    ]
                  )
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Icon(Icons.attach_money, color: Colors.cyan[900], size: 18), 
                SizedBox(width: 8),
                Text('예산(만원):  ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan[900])),
                SizedBox(width: 80),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${_budget} 만원  "),
                      Slider(
                        value: _budget,
                        max: 2000,
                        divisions: 2000,
                        label: _budget.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _budget = value;
                          });
                        },
                      ),
                    ]
                  )
                ),
              ]
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Icon(Icons.hotel, color: Colors.cyan[900], size: 18), 
                SizedBox(width: 8),
                Text('선호하는 숙소 유형: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan[900])),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                  )
                ),
                
              ]
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.explore, color: Colors.cyan[900], size: 18), 
                SizedBox(width: 8),
                Text('여행 스타일: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.cyan[900])),
              ],
            ),
            SizedBox(height:5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Expanded(
                  child: Column(
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
                ),
                Expanded(
                  child: Column(
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
                ),
                Expanded(
                  child: Column(
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
                          Text('역사 탐방'),
                        ],
                      ),
                    ]
                  ),
                ),
                
                
                
              ]
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: const Text('여행 계획 만들기!'),
              onPressed: () {
                if (departure.compareTo(date) > 0){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("출발 일자와 도착 일자를 확인해주세요.")),
                    );
                  });
                }else{
                  widget.onSearch(departure, date, country, state, city, _num_people, _budget, accommodation, travel_style);
                }
                
              },
          ),
          ],
        ),
      )
    );
  }
}



