
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:tute_me/cards.dart';
import 'package:tute_me/editprofile.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/favourites.dart';
import 'package:tute_me/listingnew.dart';

class MyProfile2 extends StatefulWidget {
  const MyProfile2({Key? key}) : super(key: key);

  @override
  _MyProfileState2 createState() => _MyProfileState2();
}

class _MyProfileState2 extends State<MyProfile2> {
  bool _isSelected = true;
  bool _isSelected2 = false;
  bool _isSelected3 = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
                onPressed: () => Navigator.pop(context),
              ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
              children: [
                SizedBox(height: 10,),
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width*0.2,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/iconbg.png', fit: BoxFit.fill,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                Align(
                  alignment: Alignment.center,
                  child: Text("Anand", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Align(
                  alignment: Alignment.center,
                  child: Text("anand2010332@ssn.edu.in", style: TextStyle(fontSize: 16),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                SizedBox(
                  width: 165,
                  height: 32,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.lightBlueAccent)
                              )
                          )
                      ),
                      child: Text("Edit Profile", style: TextStyle(fontSize: 14),)
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  height: MediaQuery.of(context).size.width*0.12,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: Colors.grey.shade200),
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),


                      ChoiceChip(label: Text("My Subjects"),
                          backgroundColor: Colors.grey.shade200,
                          labelStyle: TextStyle(
                            color: _isSelected2 ? Colors.white : Colors.lightBlueAccent,
                          ),
                          selectedColor: Colors.lightBlueAccent,
                          selected: _isSelected2,
                          onSelected: (newboolValue){
                            setState(() {
                              _isSelected2 = newboolValue;
                              _isSelected = false;
                              //_isSelected3 = false;
                            });
                          }
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                _isSelected ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [Text("No Subjects")],)/*ListView.builder(
                        itemCount: _listed.length,
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index){
                          return MyFavourites(child: _listed[index]);
                        }
                    ),*/
                ) : Container(),
                _isSelected2 ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [Text("No Subjects")],/*ListView.builder(
                        itemCount: _listed.length,
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index){
                          return MyFavourites(child: _listed[index]);
                        }
                    ),*/
                  ),
                ) : Container(),
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
                 /* IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Cart",
                    icon: Icon(Icons.home_outlined),
                    iconSize: 35,
                  ),*/
                  Spacer(),
                  /*IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Map()));
                    },
                    hoverColor: Colors.black,
                    color: Colors.white,
                    highlightColor: Colors.black12,
                    tooltip: "Locate",
                    icon: Icon(Icons.location_on_outlined,),
                    iconSize: 35,
                  ),*/
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