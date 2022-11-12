import 'dart:convert';

import 'package:flutter/material.dart';

import 'filtermodel.dart';


class MyHome extends StatefulWidget{
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {


  String filterText="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 80)],
                gradient: LinearGradient(
                  colors: [Color(int.parse("0xFF00ACC1")),
                    Color(int.parse("0xFF64FFDA")),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,)
            ),

          ),
          title:Text("Flutter Filter Screen")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(child: SingleChildScrollView(child: Text( "Tap on Icon to Navigate to Filter Screen",maxLines: 20,style: TextStyle(fontSize: 20,color:Colors.red),))),
          ),
          Container(
              child: Center(
                child: MaterialButton(onPressed: ()async {
                  var result= await Navigator.push(context, MaterialPageRoute(builder: (ctx){
                    return FilterScreen();
                  }));

                  setState(() {
                    filterText="Filter values selected in Previous Screen\n ${result}";
                  });
                  print(result);

                },
                  child: Icon(Icons.filter_tilt_shift,size: 40,),
                ),
              )
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: SingleChildScrollView(child: Text( " \n ${filterText}",maxLines: 20,style: TextStyle(fontSize: 20,color:Colors.green),))),
            )),
          )
        ],
      ),
    );
  }
}


class FilterScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return FilterScreenState();
  }

}

class FilterScreenState extends State<FilterScreen>{
  var _areacontroller = TextEditingController();
  final List _categories1 = [];
  bool _modePressed1 = false;
  List<bool> _modeCheck1 = [false,false];
  List<dynamic> items1 = [];
  List<dynamic> itemsCheckbox1 = [];
  List<dynamic> _areas = [];
  List<dynamic> _allareas = [
    "Alapakkam",
    "Alwarpet",
    "Alwarthirunagar",
    "Ambattur",
    "Aminjikarai",
    "Anna Nagar",
    "Annanur",
    "Arumbakkam",
    "Ashok Nagar",
    "Avadi",
    "Ayanavaram",
    "Besant Nagar",
    "Basin Bridge",
    "Chepauk",
    "Chetput",
    "Chintadripet",
    "Chitlapakkam",
    "Choolai",
    "Choolaimedu",
    "Chrompet",
    "Egmore",
    "Ekkaduthangal",
    "Eranavur",
    "Ennore",
    "Foreshore Estate",
    "Fort St. George",
    "George Town",
    "Gopalapuram",
    "Government Estate",
    "Guindy",
    "Guduvancheri",
    "IIT Madras",
    "Injambakkam",
    "ICF",
    "Iyyapanthangal",
    "Jafferkhanpet",
    "Karapakkam",
    "Kattivakkam",
    "Kattupakkam",
    "Kazhipattur",
    "K.K. Nagar",
    "Keelkattalai",
    "Kattivakkam",
    "Kilpauk",
    "Kodambakkam",
    "Kodungaiyur",
    "Kolathur",
    "Korattur",
    "Korukkupet",
    "Kottivakkam",
    "Kotturpuram",
    "Kottur",
    "Kovilambakkam",
    "Koyambedu",
    "Kundrathur",
    "Madhavaram",
    "Madhavaram Milk Colony",
    "Madipakkam",
    "Madambakkam",
    "Maduravoyal",
    "Manali",
    "Manali New Town",
    "Manapakkam",
    "Mandaveli",
    "Mangadu",
    "Mannady",
    "Mathur",
    "Medavakkam",
    "Meenambakkam",
    "MGR Nagar",
    "Minjur",
    "Mogappair",
    "MKB Nagar",
    "Mount Road",
    "Moolakadai",
    "Moulivakkam",
    "Mugalivakkam",
    "Mudichur",
    "Mylapore",
    "Nandanam",
    "Nanganallur",
    "Nanmangalam",
    "Neelankarai",
    "Nemilichery",
    "Nesapakkam",
    "Nolambur",
    "Noombal",
    "Nungambakkam",
    "Otteri",
    "Padi",
    "Pakkam",
    "Palavakkam",
    "Pallavaram",
    "Pallikaranai",
    "Pammal",
    "Park Town",
    "Parry's Corner",
    "Pattabiram",
    "Pattaravakkam",
    "Pazhavanthangal",
    "Peerkankaranai",
    "Perambur",
    "Peravallur",
    "Perumbakkam",
    "Perungalathur",
    "Perungudi",
    "Pozhichalur",
    "Poonamallee",
    "Porur",
    "Pudupet",
    "Pulianthope",
    "Purasaiwalkam",
    "Puthagaram",
    "Puzhal",
    "Puzhuthivakkam/ Ullagaram",
    "Raj Bhavan",
    "Ramavaram",
    "Red Hills",
    "Royapettah",
    "Royapuram",
    "Saidapet",
    "Saligramam",
    "Santhome",
    "Sembakkam",
    "Selaiyur",
    "Shenoy Nagar",
    "Sholavaram",
    "Sholinganallur",
    "Sithalapakkam",
    "Sowcarpet",
    "St.Thomas Mount",
    "Surapet",
    "Tambaram",
    "Teynampet",
    "Tharamani",
    "T. Nagar",
    "Thirumangalam",
    "Thirumullaivoyal",
    "Thiruneermalai",
    "Thiruninravur",
    "Thiruvanmiyur",
    "Tiruverkadu",
    "Thiruvotriyur",
    "Thuraipakkam",
    "Tirusulam",
    "Tiruvallikeni",
    "Tondiarpet",
    "United India Colony",
    "Vandalur",
    "Vadapalani",
    "Valasaravakkam",
    "Vallalar Nagar",
    "Vanagaram",
    "Velachery",
    "Velappanchavadi",
    "Villivakkam",
    "Virugambakkam",
    "Vyasarpadi",
    "Washermanpet",
    "West Mambalam",
  ];
  void filterSearchResults1(String query) {
    List<dynamic> dummySearchList1 = <dynamic>[];
    dummySearchList1.addAll(_allareas);
    if(query.isNotEmpty) {
      List<String> dummyListData1 = <String>[];
      dummySearchList1.forEach((item1) {
        if(item1.contains(query.toLowerCase())) {
          dummyListData1.add(item1);
        }
        if(item1.contains(query.toUpperCase())) {
          dummyListData1.add(item1);
        }
      });
      setState(() {
        items1.clear();
        items1.addAll(dummyListData1);
      });
      return;
    } else {
      setState(() {
        items1.clear();
        items1.addAll(_allareas);

      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items1.add(_allareas);
  }

  var _subjectController = TextEditingController();
  final List _categories = [];
  bool _modePressed = false;
  List<bool> _modeCheck = [false,false];
  List<dynamic> items = [];
  List<dynamic> itemsCheckbox = [];
  List<dynamic> _subjects = [];
  List<dynamic> _allSubjects = ["math","science","english","history","civics","economics"];

  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = <dynamic>[];
    dummySearchList.addAll(_allSubjects);
    if(query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if(item.contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
        if(item.contains(query.toUpperCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_allSubjects);

      });
    }
  }

  bool _subjectPressed = false;
  bool _FeesPressed = false;
  bool isPaid=false;
  bool isFree=false;
  bool isLatest=false;
  bool isOld=false;
  bool isnew=false;
  bool isFilter=false;
  bool isClass1and2=false;
  bool isClass3and4=false;
  bool isClass5and6=false;
  bool isClass7and8=false;
  bool isClass9and10=false;
  bool isClass11and12=false;
  bool isAbove12=false;

  List<String>selected=List.empty(growable: true);
  List<BookF> filter_three = [
    BookF( "1","1000 - 5000", false),
    BookF( "2","5000 - 10000", false),
    BookF( "3","10000 - 15000", false),
    BookF( "12","15000 - 20000", false),
    BookF( "13","20000 - 25000", false),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 80)],
                gradient: LinearGradient(
                  colors: [Color(int.parse("0xFF00ACC1")),
                    Color(int.parse("0xFF64FFDA")),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,)
            ),

          ),
        leading: MaterialButton(
            onPressed: (){
              Navigator.pop(context,"");
            },child: Icon(Icons.arrow_back_ios,color:Colors.white)),
        backgroundColor: Colors.lightBlue,
        actions: [
          MaterialButton(onPressed: (){
            setState(() {
              filter_three.forEach((element) {
                element.isSelected=false;
              });

              isFilter=false;
              bool isClass1and2=false;
              bool isClass3and4=false;
              bool isClass5and6=false;
              bool isClass7and8=false;
              bool isClass9and10=false;
              bool isClass11and12=false;
              bool isAbove12=false;


              isLatest=false;
              isOld=false;

            });
          }),
          MaterialButton(onPressed: (){
            Map<String,dynamic>filters=Map();
            filters['isPaid']=(isPaid)?1:0;
            filters['isFree']=(isFree)?1:0;
            filters['Latest']=(isLatest)?1:0 ;
            filters['Old']=(isOld)?1:0 ;
            filters['isnew']=(isnew)?1:0;
            filters['1-2']=(isClass1and2)?1:0;
            filters['3-4']=(isClass3and4)?1:0;
            filters['5-6']=(isClass5and6)?1:0;
            filters['7-8']=(isClass7and8)?1:0;
            filters['9-10']=(isClass9and10)?1:0;
            filters['11-12']=(isClass11and12)?1:0;
            filters['above12']=(isAbove12)?1:0;
            filters['cat']=(selected);
            Navigator.pop(context, jsonEncode(filters));


          },child: Text("Apply",style: TextStyle(color:Colors.white),))
        ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Class",style:TextStyle(color:Colors.black)),
                  SizedBox(height: 10,),


                  Row(children: [
                    Checkbox(
                        value: isClass1and2, onChanged: (value){
                      setState(() {
                        isClass1and2=value!;
                        isFilter=true;
                      });

                    }), Text("Class 1-2",style:TextStyle(color:Colors.black)),
                    Row(children: [
                      Checkbox(value: isClass3and4, onChanged: (value){
                        setState(() {
                          isClass3and4=value!;

                        });
                      }),Text("Class 3-4")
                    ],),
                    Row(children: [
                      Checkbox(value: isClass5and6, onChanged: (value){
                        setState(() {
                          isClass5and6=value!;

                        });
                      }),Text("Class 5-6")
                    ],),



                  ]),
                  Row(children: [
                    Checkbox(
                        value: isClass7and8, onChanged: (value){
                      setState(() {
                        isClass7and8=value!;
                        isFilter=true;
                      });

                    }), Text("Class 7 -8",style:TextStyle(color:Colors.black)),
                    Row(children: [
                      Checkbox(value: isClass9and10, onChanged: (value){
                        setState(() {
                          isClass9and10=value!;

                        });
                      }),Text("Class 9 - 10")
                    ],),
                    Row(children: [
                      Checkbox(value: isClass11and12, onChanged: (value){
                        setState(() {
                          isClass11and12=value!;

                        });
                      }),Text("Class 11-12")
                    ],),



                  ]),
                  Row(children: [
                    Checkbox(
                        value: isAbove12, onChanged: (value){
                      setState(() {
                        isAbove12=value!;
                        isFilter=true;
                      });

                    }), Text("Above12",style:TextStyle(color:Colors.black)),
                   /* Row(children: [
                      Checkbox(value: isComputer, onChanged: (value){
                        setState(() {
                          isComputer=value!;

                        });
                      }),Text("Chemistry")
                    ],),
                    Row(children: [
                      Checkbox(value: isphysics, onChanged: (value){
                        setState(() {
                          isphysics=value!;

                        });
                      }),Text("physics")
                    ],),



                  ]),

                  Row(children: [
                    Checkbox(
                        value: isZoology, onChanged: (value){

                      setState(() {
                        isZoology=value!;

                      });
                    }), Text("Zoology",style:TextStyle(color:Colors.black)),

                    Row(children: [
                      Checkbox(value: isChemistry, onChanged: (value){
                        setState(() {
                          isChemistry=value!;

                        });
                      }),Text("Chemistry")
                    ],),
                    Row(children: [
                      Checkbox(value: isphysics, onChanged: (value){
                        setState(() {
                          isphysics=value!;

                        });
                      }),Text("physics")
                    ],),*/






                  ]),
                  SizedBox(height: 20,),
                  Divider(height: 2,color: Colors.grey,),

                  Text("Mode",style:TextStyle(color:Colors.black)),
                  SizedBox(height: 10,),
                  Row(children: [
                    Checkbox(
                        value: isLatest, onChanged: (value){
                      setState(() {
                        isLatest=value!;
                      });

                    }), Text("online",style:TextStyle(color:Colors.black)),

                  ]),Row(children: [
                    Checkbox(
                        value: isOld, onChanged: (value){
                      setState(() {
                        isOld=value!;
                      });

                    }), Text("Offline",style:TextStyle(color:Colors.black)),

                  ]),
                  Text("Subjects",style:TextStyle(color:Colors.black)),
                  Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "search subjects",
                          hintStyle: TextStyle(fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        style: TextStyle(fontSize: 14,),
                        controller: _subjectController,
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.75,
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height*0.3,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if(itemsCheckbox[index] == false) {
                                        if (_subjects.contains(items[index]) ==
                                            false)
                                          _subjects.add(items[index]);
                                        print(_subjects);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text('${items[index]}'),
                                      Spacer(),
                                      Checkbox(value: _modeCheck[0], onChanged: (value) {
                                        setState(() {
                                          if(_modeCheck[0] == true)
                                            _modeCheck[0] = false;
                                          else
                                            _modeCheck[0] = true;
                                          print(_allSubjects);
                                        });
                                      })
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    foregroundColor: Colors.lightBlue,
                                    backgroundColor: Colors.white,
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 20,),
                  Divider(height: 2,color: Colors.grey,),
                  Text("Fees",style:TextStyle(color:Colors.blue)),

                  SizedBox(height: 10,),


                  Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: techChips(filter_three,Colors.blue),
                  ),
                  Text("Location",style:TextStyle(color:Colors.black)),
                  Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "search Area",
                          hintStyle: TextStyle(fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        style: TextStyle(fontSize: 14,),
                        controller: _areacontroller,
                        onChanged: (value) {
                          filterSearchResults1(value);
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.75,
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height*0.3,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: items1.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if(itemsCheckbox1[index] == false) {
                                        if (_areas.contains(items1[index]) ==
                                            false)
                                          _areas.add(items1[index]);
                                        print(_areas);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text('${items1[index]}'),
                                      Spacer(),
                                      Checkbox(value: _modeCheck1[0], onChanged: (value) {
                                        setState(() {
                                          if(_modeCheck1[0] == true)
                                            _modeCheck1[0] = false;
                                          else
                                            _modeCheck1[0] = true;
                                          print(_allareas);
                                        });
                                      })
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    foregroundColor: Colors.lightBlue,
                                    backgroundColor: Colors.white,
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> techChips (List<BookF> _chipsList,color) {
    List<Widget> chips = [];
    for (int i=0; i< _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left:10, right: 5),
        child: FilterChip(
          selectedColor: color,
          label: Text(_chipsList[i].filter_title),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: color,
          selected: _chipsList[i].isSelected,
          checkmarkColor: Colors.white,
          onSelected: (bool value)
          {

            if(value)
            {
              selected.add(_chipsList[i].filter_id);
            }else
            {
              selected.remove(_chipsList[i].filter_id);
            }
            setState(() {
              _chipsList[i].isSelected = value;
            });


          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}