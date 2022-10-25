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
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/student_register.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final List _categories = [
    ["assets/gajju.jpg","Dr. Gajendra Purohit","Math for children in such a way that they will fall in love","assets/book.png","Bikes/Cycles","Buy books and other assignment needs"],
    ["assets/gajju.jpg","Dr. Gajendra Purohit","Biology for children in such a way that they will fall in love","assets/book.png","Calculators","Buy books and other assignment needs"],
    ["assets/gajju.jpg","Dr. Gajendra Purohit","Physics for children in such a way that they will fall in love","assets/book.png","Random","Buy books and other assignment needs"],
  ];
  final _database = FirebaseDatabase.instance.reference();

  @override
    void initState(){
      super.initState();
      //_database.child('Teachers').push().set({'name': 'Dr. Arulkumar'});
      _activeListners();
    }

    void _activeListners(){
      final _teachers = _database.child('Teachers').onValue.listen((event) {
        final Object? teacher = event.snapshot.value;
        print(teacher);
      });
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightBlueAccent,
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
          backgroundColor: Colors.lightBlueAccent,
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
                TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Listing())),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width*1,
                        child: Text("Add Tutor", style: TextStyle(fontSize: 20),)
                    )
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              //SizedBox(height: MediaQuery.of(context).size.height*0.1,),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
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
              SizedBox(height: MediaQuery.of(context).size.height*0.005,),
              Padding(
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
                ),/*Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Favourites" ,style: TextStyle(color: Colors.black,fontSize: 30,),)
                ),*/
              ),
              Expanded(
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
      ),
    );
  }
}
