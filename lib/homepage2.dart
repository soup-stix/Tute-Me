import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tute_me/books.dart';
import 'package:tute_me/favourites.dart';

import 'package:tute_me/map.dart';
import 'package:tute_me/favourites_expanded.dart';
import 'package:tute_me/listingnew.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/student_register.dart';

class HomePage2 extends StatefulWidget {

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2>{
  final List _categories = [];
  final _database = FirebaseDatabase.instance.reference();
  dynamic _data;

  @override
  void initState(){
    super.initState();
    _activeListners();
    _get_Teachers_ID();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _get_Teachers_ID();
  }

  void _activeListners(){
    _database.child('Teachers_ID').onValue.listen((event) {
      _get_Teachers_ID();
      //print(teacher);
    });
  }

  void _get_Teachers_ID() async {
    _data = await _database.child('Teachers_ID').get();
    if (_data.exists) {
      _data.value.forEach((k, v) {
        print(k);
        if (_categories.contains(v) == false){
          setState(() {
            _categories.add(v);
          });

          //print(_categories);
        }
      });
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Material(
            borderRadius: BorderRadius.circular(90),
            clipBehavior: Clip.antiAlias,
            elevation: 8,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile()));
              },
              child: Ink.image(
                  image: NetworkImage(

                    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
                  ),
                  height: 45,
                  width: 53,
                  fit: BoxFit.fill
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
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
        title: Text("𝕋𝕦𝕥𝕖-𝕄𝔼", style: TextStyle(fontSize: 30, color: Colors.white),),
        centerTitle: true,
        leading: Builder(builder: (context) =>
            IconButton(
              icon: Icon(Icons.menu_rounded),
              onPressed: () {
                Scaffold.of(context).openDrawer();
                //print(faculty);
              },
            ),

        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.teal.shade300,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile())),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width*1,
                      child: Text("My Profile", style: TextStyle(fontSize: 20),)
                  )
              ),
              TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Map())),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width*1,
                      child: Text("Locator", style: TextStyle(fontSize: 20),)
                  )
              ),
              TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Student_Register())),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width*1,
                      child: Text("Find Tutor", style: TextStyle(fontSize: 20),)
                  )
              ),
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width*1,
                      child: Text("Homepage", style: TextStyle(fontSize: 20),)
                  )
              ),




            ],
          ),
        ),
      ),
      body:
      Container(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                padding: EdgeInsets.all(10),
                color: Color.fromARGB(255, 73, 189, 246),
                child:
                Container(
                  height: MediaQuery.of(context).size.height*0.06,
                  width: MediaQuery.of(context).size.width*0.95,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black12),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Icon(Icons.search_rounded),
                      ),
                      Text("Search", style: TextStyle(color: Colors.black, fontSize: 20),),
                    ],
                  ),
                ),
              ),
              Container(
                color: Color.fromARGB(255, 73, 189, 246),
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Popular Teachers" ,style: TextStyle(color: Colors.black,fontSize: 30,),),
                    Spacer(),
                    IconButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Favourites_Expanded())),
                        icon: Icon(Icons.arrow_forward_rounded)),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.25,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),color: Color.fromARGB(255, 73, 189, 246),),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.18,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, index){
                            return MyFavourites(child: _categories[index]);
                          }
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(Icons.keyboard_arrow_down_outlined),
                    ),
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height*0.75,
                child: ListView.builder(
                    itemCount: _categories.length,
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context, index){
                      return MyFavourites(child: _categories[index]);
                    }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(

        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 50,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 80)],
              gradient: LinearGradient(
                colors: [Color(int.parse("0xFF00ACC1")),
                  Color(int.parse("0xFF64FFDA")),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,)
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
