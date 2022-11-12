import 'package:flutter/material.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/profile.dart';
class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _subjectController = TextEditingController();
  var _areaController = TextEditingController();
  final List _categories = [];
  final List _appliedFilters = [];
  List<bool> _modeCheck = List.filled(2, false);
  List<bool> _typeCheck = List.filled(2, false);
  List<bool> _priceCheck = List.filled(5, false);
  List<bool> _classCheck = List.filled(12, false);
  List<dynamic> items = [];
  List<dynamic> areaItems = [];
  List<dynamic> areaItemsCheckbox = [];
  List<dynamic> itemsCheckbox = [];
  List<dynamic> _subjects = [];
  List<dynamic> _area = [];
  List<dynamic> _allSubjects = ["math","science","english","history","civics","economics"];
  List<dynamic> _allArea = ["Alapakkam", "Alwarpet", "Alwarthirunagar", "Ambattur", "Aminjikarai", "Anna Nagar", "Annanur", "Arumbakkam", "Ashok Nagar", "Avadi", "Ayanavaram", "Besant Nagar", "Basin Bridge", "Chepauk", "Chetput", "Chintadripet", "Chitlapakkam", "Choolai", "Choolaimedu", "Chrompet", "Egmore", "Ekkaduthangal", "Eranavur", "Ennore", "Foreshore Estate", "Fort St. George", "George Town", "Gopalapuram", "Government Estate", "Guindy", "Guduvancheri", "IIT Madras", "Injambakkam", "ICF", "Iyyapanthangal", "Jafferkhanpet", "Karapakkam", "Kattivakkam", "Kattupakkam", "Kazhipattur", "K.K. Nagar", "Keelkattalai", "Kattivakkam", "Kilpauk", "Kodambakkam", "Kodungaiyur", "Kolathur", "Korattur", "Korukkupet", "Kottivakkam", "Kotturpuram", "Kottur", "Kovilambakkam", "Koyambedu", "Kundrathur", "Madhavaram", "Madhavaram Milk Colony", "Madipakkam", "Madambakkam", "Maduravoyal", "Manali", "Manali New Town", "Manapakkam", "Mandaveli", "Mangadu", "Mannady", "Mathur", "Medavakkam", "Meenambakkam", "MGR Nagar", "Minjur", "Mogappair", "MKB Nagar", "Mount Road", "Moolakadai", "Moulivakkam", "Mugalivakkam", "Mudichur", "Mylapore", "Nandanam", "Nanganallur", "Nanmangalam", "Neelankarai", "Nemilichery", "Nesapakkam", "Nolambur", "Noombal", "Nungambakkam", "Otteri", "Padi", "Pakkam", "Palavakkam", "Pallavaram", "Pallikaranai", "Pammal", "Park Town", "Parry's Corner", "Pattabiram", "Pattaravakkam", "Pazhavanthangal", "Peerkankaranai", "Perambur", "Peravallur", "Perumbakkam", "Perungalathur", "Perungudi", "Pozhichalur", "Poonamallee", "Porur", "Pudupet", "Pulianthope", "Purasaiwalkam", "Puthagaram", "Puzhal", "Puzhuthivakkam/ Ullagaram", "Raj Bhavan", "Ramavaram", "Red Hills", "Royapettah", "Royapuram", "Saidapet", "Saligramam", "Santhome", "Sembakkam", "Selaiyur", "Shenoy Nagar", "Sholavaram", "Sholinganallur", "Sithalapakkam", "Sowcarpet", "St.Thomas Mount", "Surapet", "Tambaram", "Teynampet", "Tharamani", "T. Nagar", "Thirumangalam", "Thirumullaivoyal", "Thiruneermalai", "Thiruninravur", "Thiruvanmiyur", "Tiruverkadu", "Thiruvotriyur", "Thuraipakkam", "Tirusulam", "Tiruvallikeni", "Tondiarpet", "United India Colony", "Vandalur", "Vadapalani", "Valasaravakkam", "Vallalar Nagar", "Vanagaram", "Velachery", "Velappanchavadi", "Villivakkam", "Virugambakkam", "Vyasarpadi", "Washermanpet", "West Mambalam",];
  List<dynamic> _mode = ["Online", "Offline"];
  List<dynamic> _type = ["Group", "Individual"];
  List<dynamic> _price = ["From 500 to 1000", "From 1000 to 2500", "From 2500 to 5000", "From 5000 to 10000", "More than 10000"];
  bool _subjectPressed = false;
  bool _typePressed = false;
  bool _modePressed = true;
  bool _pricePressed = false;
  bool _classPressed = false;
  bool _areaPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.addAll(_allSubjects);
    areaItems.addAll(_allArea);
  }

  void filterSubjectSearchResults(String query) {
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

  void filterAreaSearchResults(String query) {
    List<dynamic> dummySearchList = <dynamic>[];
    dummySearchList.addAll(_allArea);
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
        areaItems.clear();
        areaItems.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        areaItems.clear();
        areaItems.addAll(_allArea);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Filters", style: TextStyle(fontSize: 25, color: Colors.lightBlue),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.lightBlue,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Row(
        children: [
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextButton(onPressed: () {
                  setState(() {
                    _modePressed = true;
                    _subjectPressed = false;
                    _typePressed = false;
                    _pricePressed = false;
                    _classPressed = false;
                    _areaPressed = false;
                  });
                }, child: Text("Mode")),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextButton(onPressed: () {
                  setState(() {
                    _modePressed = false;
                    _subjectPressed = true;
                    _typePressed = false;
                    _pricePressed = false;
                    _classPressed = false;
                    _areaPressed = false;
                  });
                }, child: Text("Subjects")),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextButton(onPressed: () {
                  setState(() {
                    _modePressed = false;
                    _subjectPressed = false;
                    _typePressed = true;
                    _pricePressed = false;
                    _classPressed = false;
                    _areaPressed = false;
                  });
                }, child: Text("Type")),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextButton(onPressed: () {
                  setState(() {
                    _modePressed = false;
                    _subjectPressed = false;
                    _typePressed = false;
                    _pricePressed = true;
                    _classPressed = false;
                    _areaPressed = false;
                  });
                }, child: Text("Price")),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextButton(onPressed: () {
                  setState(() {
                    _modePressed = false;
                    _subjectPressed = false;
                    _typePressed = false;
                    _pricePressed = false;
                    _classPressed = true;
                    _areaPressed = false;
                  });
                }, child: Text("Class")),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.3,
                child: TextButton(onPressed: () {
                  setState(() {
                    _modePressed = false;
                    _subjectPressed = false;
                    _typePressed = false;
                    _pricePressed = false;
                    _classPressed = false;
                    _areaPressed = true;
                  });
                }, child: Text("Area")),
              ),
              //SizedBox(width: MediaQuery.of(context).size.width*0.3,),
            ],
          ),
          VerticalDivider(thickness: 0.5,color: Colors.black,),
          Column(
            children: [
              _modePressed == true ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      height: MediaQuery.of(context).size.height*0.7,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _mode.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if(_modeCheck[index] == true)
                                      _modeCheck[index] = false;
                                    else
                                      _modeCheck[index] = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text('${_mode[index]}'),
                                    Spacer(),
                                    Checkbox(value: _modeCheck[index], onChanged: (value) {
                                      setState(() {
                                        if(_modeCheck[index] == true)
                                          _modeCheck[index] = false;
                                        else
                                          _modeCheck[index] = true;
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
                      ),/*Row(
                        children: [
                          Text("Online", style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
                          Spacer(),
                          Checkbox(value: _modeCheck[0], onChanged: (value) {
                            setState(() {
                              if(_modeCheck[0] == true)
                                _modeCheck[0] = false;
                              else
                                _modeCheck[0] = true;
                            });
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      child: Row(
                        children: [
                          Text("Offline", style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
                          Spacer(),
                          Checkbox(value: _modeCheck[1], onChanged: (value) {
                            setState(() {
                              if(_modeCheck[1] == true)
                                _modeCheck[1] = false;
                              else
                                _modeCheck[1] = true;
                            });
                          }),
                        ],
                      ),*/
                    )
                  ],
                ),
              ) : Container(),
              _subjectPressed == true ? SizedBox(
                width: MediaQuery.of(context).size.width*0.65,
                height: MediaQuery.of(context).size.height*0.8,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: " search subjects",
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
                        filterSubjectSearchResults(value);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width*0.65,
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height*0.72,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
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
                                    Checkbox(value: false, onChanged: (value) {})
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
              ) : Container(),
              _typePressed == true ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      height: MediaQuery.of(context).size.height*0.7,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _type.length,
                          itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                  setState(() {
                                  if(_typeCheck[index] == true)
                                  _typeCheck[index] = false;
                                  else
                                  _typeCheck[index] = true;
                                  });
                                  },
                                  child: Row(
                                      children: [
                                      Text('${_type[index]}'),
                                      Spacer(),
                                      Checkbox(value: _typeCheck[index], onChanged: (value) {
                                        setState(() {
                                          if(_typeCheck[index] == true)
                                            _typeCheck[index] = false;
                                          else
                                            _typeCheck[index] = true;
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
                      ),/*Row(
                        children: [
                          Text("Online", style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
                          Spacer(),
                          Checkbox(value: _typeCheck[0], onChanged: (value) {
                            setState(() {
                              if(_typeCheck[0] == true)
                                _typeCheck[0] = false;
                              else
                                _typeCheck[0] = true;
                            });
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      child: Row(
                        children: [
                          Text("Offline", style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
                          Spacer(),
                          Checkbox(value: _typeCheck[1], onChanged: (value) {
                            setState(() {
                              if(_typeCheck[1] == true)
                                _typeCheck[1] = false;
                              else
                                _typeCheck[1] = true;
                            });
                          }),
                        ],
                      ),*/
                    )
                  ],
                ),
              ) : Container(),
              _pricePressed == true ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      height: MediaQuery.of(context).size.height*0.8,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _price.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if(_priceCheck[index] == true)
                                      _priceCheck[index] = false;
                                    else
                                      _priceCheck[index] = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text('${_price[index]}'),
                                    Spacer(),
                                    Checkbox(value: _priceCheck[index], onChanged: (value) {
                                      setState(() {
                                        if(_priceCheck[index] == true)
                                          _priceCheck[index] = false;
                                        else
                                          _priceCheck[index] = true;
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
                      ),/*Row(
                        children: [
                          Text("Online", style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
                          Spacer(),
                          Checkbox(value: _modeCheck[0], onChanged: (value) {
                            setState(() {
                              if(_modeCheck[0] == true)
                                _modeCheck[0] = false;
                              else
                                _modeCheck[0] = true;
                            });
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      child: Row(
                        children: [
                          Text("Offline", style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
                          Spacer(),
                          Checkbox(value: _modeCheck[1], onChanged: (value) {
                            setState(() {
                              if(_modeCheck[1] == true)
                                _modeCheck[1] = false;
                              else
                                _modeCheck[1] = true;
                            });
                          }),
                        ],
                      ),*/
                    )
                  ],
                ),
              ) : Container(),
              _classPressed == true ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      height: MediaQuery.of(context).size.height*0.8,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if(_classCheck[index] == true)
                                      _classCheck[index] = false;
                                    else
                                      _classCheck[index] = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text('Class ${index + 1}'),
                                    Spacer(),
                                    Checkbox(value: _classCheck[index], onChanged: (value) {
                                      setState(() {
                                        if(_classCheck[index] == true)
                                          _classCheck[index] = false;
                                        else
                                          _classCheck[index] = true;
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
                      ),/*Row(
                        children: [
                          Text("Online", style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
                          Spacer(),
                          Checkbox(value: _modeCheck[0], onChanged: (value) {
                            setState(() {
                              if(_modeCheck[0] == true)
                                _modeCheck[0] = false;
                              else
                                _modeCheck[0] = true;
                            });
                          }),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      child: Row(
                        children: [
                          Text("Offline", style: TextStyle(color: Colors.lightBlue, fontSize: 20),),
                          Spacer(),
                          Checkbox(value: _modeCheck[1], onChanged: (value) {
                            setState(() {
                              if(_modeCheck[1] == true)
                                _modeCheck[1] = false;
                              else
                                _modeCheck[1] = true;
                            });
                          }),
                        ],
                      ),*/
                    )
                  ],
                ),
              ) : Container(),
              _areaPressed == true ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.65,
                      height: MediaQuery.of(context).size.height*0.8,
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: " search area",
                              hintStyle: TextStyle(fontSize: 14),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            style: TextStyle(fontSize: 14,),
                            controller: _areaController,
                            onChanged: (value) {
                              filterAreaSearchResults(value);
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: MediaQuery.of(context).size.width*0.65,
                            color: Colors.transparent,
                            height: MediaQuery.of(context).size.height*0.72,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: areaItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if(areaItemsCheckbox[index] == false) {
                                            if (_area.contains(areaItems[index]) ==
                                                false)
                                              _area.add(areaItems[index]);
                                            print(_area);
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text('${areaItems[index]}'),
                                          Spacer(),
                                          Checkbox(value: false, onChanged: (value) {})
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
                    ),
                  ],
                ),
              ) : Container(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlueAccent,
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent,
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Spacer(),
                  IconButton(
                    onPressed: () {
                    },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Home",
                    icon: Icon(Icons.home_rounded),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Map())),
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Locate",
                    icon: Icon(Icons.location_on_outlined,),
                    iconSize: 35,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile())),
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Account",
                    icon: Icon(Icons.person_outline_rounded,),
                    iconSize: 35,
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}