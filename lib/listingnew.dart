import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/profile.dart';
import 'package:geocoder/geocoder.dart';

class Listing extends StatefulWidget {
  const Listing({Key? key}) : super(key: key);

  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {

  final _database = FirebaseDatabase.instance.reference();

  bool _loadingWidget = false;
  bool _showSubjectList = false;
  bool _chipClassMade = false;
  bool _chipSubjectMade = false;
  bool _showChipButtons = false;
  List<String> _values = [];
  List<bool> _selected = [];
  List<dynamic> _subjects = [];
  List<bool> _selectedSubjects = [];
  dynamic _latitude;
  dynamic _longitude;
  dynamic _modeValue;
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  List _searchResult = [];
  List<dynamic> _allSubjects = ["Math","Science","English","History","Civics","Economics"];

  List<dynamic> items = [];

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    if(_values.length > 0)
      _chipClassMade = true;
    else
      _chipClassMade = false;
    if(_subjects.length > 0)
      _chipSubjectMade = true;
    else
      _chipSubjectMade = false;
  }

  @override
  void initState() {
    items.addAll(_allSubjects);
    super.initState();

    // Start listening to changes.
    _nameController.addListener(_printLatestValue);
    _addressController.addListener(_printLatestValue);
    _phoneController.addListener(_printLatestValue);
    _subjectController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

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

  void _printLatestValue() {
    print('Address field: ${_addressController.text}');
    print('Name field: ${_nameController.text}');
    print('Phone field: ${_phoneController.text}');
    print('subject field: ${_subjectController.text}');
    subjectSearch();
  }

  void _getlocation() async{
    var addresses = await Geocoder.local.findAddressesFromQuery(_addressController.text);
    var first = addresses.first;
    var location = first.coordinates.toMap();
    setState(() {
      _latitude = location['latitude'];
      _longitude = location['longitude'];
    });
    print(first.coordinates.toMap());
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          backgroundColor: Colors.white,
          title: Center(child: Text("Loading",style: TextStyle(fontSize: 30,color: Colors.lightBlue),)),
          actions: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  CircularProgressIndicator(),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,)
                  //Text("Loading",style: TextStyle(fontSize: 20,color: Colors.lightBlue),),
                ],
              ),
            ),
          ],
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }

  void subjectSearch() {
    _allSubjects.forEach((item) {
      print("test");
      print(_subjectController.text);
      if(item.contains(_subjectController.text) == true){
        _searchResult.add(item);
        print(_searchResult);
      }
    });
  }

  Widget buildClassChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _values.length; i++) {
      RawChip actionChip = RawChip(
        selected: _selected[i],
        label: Text(_values[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove class",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _selected[i] = !_selected[i];
            _chipClassMade = true;
          });
        },
        onDeleted: () {
          _values.removeAt(i);
          _selected.removeAt(i);

          setState(() {
            _values = _values;
            _selected = _selected;
          });
        },
        showCheckmark: false,
      );
      chips.add(actionChip);
      chips.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  Widget buildSubjectChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _subjects.length; i++) {
      RawChip actionChip = RawChip(
        selected: true,
        label: Text(_subjects[i],style: TextStyle(fontSize: 15,color: Colors.black),),
        backgroundColor: Colors.white,
        selectedColor: Colors.lightBlue,
        deleteButtonTooltipMessage: "Remove class",
        deleteIcon: Icon(Icons.close_rounded,size: 15,color: Colors.black,),
        onPressed: () {
          setState(() {
            _chipClassMade = true;
          });
        },
        onDeleted: () {
          setState(() {
            _subjects.removeAt(i);
          });
        },
        showCheckmark: false,
      );
      chips.add(actionChip);
      chips.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  Widget buildClassButtons() {
    List<Widget> buttons = [];

    for (int i = 1; i < 13; i++) {
      TextButton buttonChip = TextButton(
          style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              if (_values.contains('class $i') == false) {
                _values.add('class $i');
                _selected.add(true);
              }
            });
          },
          child: Text("class $i", style: TextStyle(fontSize: 15,color: Colors.lightBlue),)
      );
      buttons.add(buttonChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }

  Widget buildSubjectButtons() {
    List<Widget> buttons = [];

    for (int i = 1; i < _searchResult.length; i++) {
      TextButton buttonChip = TextButton(
          style: ButtonStyle(enableFeedback: true,),
          onPressed: () {
            setState(() {
              if (_values.contains('class $i') == false) {
                _values.add('class $i');
                _selected.add(true);
              }
            });
          },
          child: Text("class $i", style: TextStyle(fontSize: 15,color: Colors.lightBlue),)
      );
      buttons.add(buttonChip);
      buttons.add(SizedBox(width: MediaQuery.of(context).size.width*0.01,));
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: buttons,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add a Tutor", style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Name",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextField(
                  decoration: InputDecoration(
                    hintText: "name",
                    hintStyle: TextStyle(fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(fontSize: 14,),
                  controller: _nameController,
                  //maxLines: 3,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Address",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextField(
                  decoration: InputDecoration(
                    hintText: "address",
                    hintStyle: TextStyle(fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(fontSize: 14,),
                  controller: _addressController,
                  //maxLines: 3,
                ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  Align(
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                    child: Text("Mode",
                      style: TextStyle(color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  DropdownButtonFormField(
                    dropdownColor: Colors.white,
                    icon: Icon(
                    Icons.keyboard_arrow_down_rounded, color: Colors.lightBlue,),
                  hint: Text("Choose a Mode"),
                  items: [
                    "Online",
                    "Offline",

                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: TextStyle(fontSize: 14, color: Colors.black),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    print(newValue);
                    _modeValue = newValue;
                  },
                  decoration: const InputDecoration(
                    enabled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Phone number",
                    style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
                //SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                TextField(
                  decoration: InputDecoration(
                    hintText: "ph no",
                    hintStyle: TextStyle(fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(fontSize: 14,),
                  controller: _phoneController,
                  //maxLines: 3,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Classes",
                    style: TextStyle(color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _chipClassMade ? Container(
                  height: MediaQuery.of(context).size.height*0.08,
                  child: buildClassChips(),
                ) : Container(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "class",
                    hintStyle: TextStyle(fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(fontSize: 14,),
                  onTap: () {
                    setState(() {
                      _showChipButtons = true;
                      _chipClassMade = true;
                    });
                  },
                  onSubmitted: (value) {
                    setState(() { _showChipButtons = false;});
                  },
                ),
                _showChipButtons ? Container(
                  height: MediaQuery.of(context).size.height*0.08,
                  child: buildClassButtons(),
                ) : Container(),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Align(
                  alignment: Alignment.centerLeft,
                  //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                  child: Text("Subjects",
                    style: TextStyle(color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _chipSubjectMade ? Container(
                  height: MediaQuery.of(context).size.height*0.08,
                  child: buildSubjectChips(),
                ) : Container(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "subjects",
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
                  onTap: () {
                    setState(() {
                      _showSubjectList = true;
                    });
                  },
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  onSubmitted: (value) {
                    setState(() {
                      _showSubjectList = false;
                    });
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                _showSubjectList ?
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height*0.3,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if(_subjects.contains(items[index]) == false)
                                  _subjects.add(items[index]);
                                print(_subjects);
                                _chipSubjectMade = true;
                              });
                            },
                              child: Text('${items[index]}'),
                              style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          )
                      ),
                      );
                    },
                  ),
                ) : Container(),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        print(_values);
                        setState(() {
                          _getlocation();
                          _loadingWidget = true;
                          _onLoading();
                          Future.delayed(Duration(seconds: 3), (){
                            _database.child('Teachers').child(_phoneController.text).set({
                              'name': _nameController.text,
                              'coordinates': {'latitude': _latitude,'longitude':_longitude}
                            });
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                title: Icon(Icons.check_circle, size: MediaQuery.of(context).size.height*0.125, color: Colors.lightBlue, shadows: [BoxShadow(
                                  color: Colors.black38,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0,4),
                                )],
                                ),
                                actions: <Widget>[
                                  Column(
                                    children: [
                                      Text('Tutor Added Successfully !', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                      Row(
                                        children: [
                                          Spacer(),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Click here", style: TextStyle(fontSize: 14, fontFamily: 'poppins', color: Colors.lightBlue),)
                                          ),
                                          Text("to continue", style: TextStyle(fontSize: 14, fontFamily: 'poppins'),),
                                          Spacer(),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                        });
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.lightBlue)
                              )
                          )
                      ),
                      child: Text("Add", style: TextStyle(fontSize: 14),)
                  ),
                ),
              ]
          ),
        ),
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