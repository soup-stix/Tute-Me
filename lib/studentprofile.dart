
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:tute_me/cards.dart';
import 'package:tute_me/teachereditprofile.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/favourites.dart';
import 'package:tute_me/listingnew.dart';
import 'package:tute_me/studenteditprofile.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  _StudentProfile createState() => _StudentProfile();
}

class _StudentProfile extends State<StudentProfile> {
  bool _isSelected = true;
  bool _isSelected2 = false;
  bool _isSelected3 = false;


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
          ),),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage2()));
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(232, 18, 215, 241)),
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
                  width: MediaQuery.of(context).size.width*0.6,
                  height: MediaQuery.of(context).size.width*0.12,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: Colors.grey.shade200),
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                      ChoiceChip(label: Text("My Teachers"),
                          backgroundColor: Colors.grey.shade200,
                          selectedColor: Color.fromARGB(232, 18, 215, 241),
                          labelStyle: TextStyle(
                            color: _isSelected ? Colors.white : Color.fromARGB(232, 18, 215, 241),

                      ),
                          selected: _isSelected,
                          onSelected: (newboolValue){
                            setState(() {
                              _isSelected = newboolValue;
                              _isSelected2 = false;
                              //_isSelected3 = false;
                            });
                          }
                      ),



                      ChoiceChip(label: Text("My Subjects"),
                          backgroundColor: Colors.grey.shade200,
                          labelStyle: TextStyle(
                            color: _isSelected2 ? Colors.white : Color.fromARGB(232, 18, 215, 241),
                          ),
                          selectedColor: Color.fromARGB(232, 18, 215, 241),
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
                  ),
                  Spacer(),
                  IconButton(
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