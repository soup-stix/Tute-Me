import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tute_me/books.dart';
import 'package:tute_me/favourites.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/favourites_expanded.dart';
import 'package:tute_me/listingnew.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/student_register.dart';
class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _subjectController = TextEditingController();
  final List _categories = [];
  bool _modePressed = false;
  List<bool> _modeCheck = [false,false];
  List<dynamic> items = [];
  List<dynamic> itemsCheckbox = [];
  List<dynamic> _subjects = [];
  List<dynamic> _allSubjects = ["math","science","english","history","civics","economics"];
  bool _subjectPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.addAll(_allSubjects);
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
              TextButton(onPressed: () {
                setState(() {
                  _modePressed = true;
                  _subjectPressed = false;
                });
              }, child: Text("Mode")),
              TextButton(onPressed: () {
                setState(() {
                  _modePressed = false;
                  _subjectPressed = true;
                });
              }, child: Text("Subjects")),
              TextButton(onPressed: () {}, child: Text("Subjects")),
              TextButton(onPressed: () {}, child: Text("Subjects")),
            ],
          ),
          VerticalDivider(thickness: 0.5,color: Colors.black,),
          Column(
            children: [
              _modePressed == true ? Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: Row(
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
                      width: MediaQuery.of(context).size.width*0.75,
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
                      ),
                    )
                  ],
                ),
              ) : Container(),
              _subjectPressed == true ? SizedBox(
                width: MediaQuery.of(context).size.width*0.75,
                child: Column(
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