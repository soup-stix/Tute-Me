

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tute_me/homepage2.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/register.dart';
import 'package:tute_me/forgotpassword.dart';
import 'package:tute_me/homepage.dart';


class newvalue {
  static const String FirstItem = 'Teacher';
  static const String SecondItem = 'Student';


  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,

  ];
}

void choiceAction(String choice) {
  if (choice == newvalue.FirstItem) {



  } else if (choice == newvalue.SecondItem) {

  }
  }


class MyLogin extends StatefulWidget{
  const MyLogin({Key?key}): super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        //decoration: BoxDecoration(
            //image: DecorationImage(
                //image: AssetImage('assets/loginresale.jpeg'),fit: BoxFit.fill)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  //top: MediaQuery.of(context).size.height*0.3,
                    left: MediaQuery.of(context).size.width*0.05,
                    right: MediaQuery.of(context).size.width*0.05),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.08),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        height: MediaQuery.of(context).size.height*0.12,
                        child: Center(child: Text("𝕋𝕦𝕥𝕖-𝕄𝔼", style: TextStyle(fontSize: 60, color: Colors.lightBlueAccent),))//SvgPicture.asset("assets/Re-Sale Logo.svg"),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Align(
                      alignment: Alignment.centerLeft,
                      //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.3),
                      child: Text('Log In',
                        style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),





                    Align(
                      alignment: Alignment.centerLeft,
                      //padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.05,top:MediaQuery.of(context).size.height*0.35),
                      child: Text('Welcome back, Log In to continue',
                        style: TextStyle(color: Colors.grey.shade500,fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: 'Email-ID',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.02,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Login As',
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownButtonFormField(
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded, color: Colors.lightBlue,),
                      hint: Text("Choose a Mode"),
                      items: [
                        "Teacher",
                        "Student",
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                            style: TextStyle(fontSize: 14, color: Colors.black),),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue == 'Teacher'){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }
                        else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage2()));
                        }
                        print(newValue);

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 40,
                          /*child: ElevatedButton(


                              onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage())),

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
                              child: Text("Log In", style: TextStyle(fontSize: 14),)
                          ),*/
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?", style: TextStyle(color: Colors.grey.shade500,fontSize: 15, fontWeight: FontWeight.bold),),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  primary: Colors.lightBlueAccent,
                                ),
                                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const MyRegister())),
                                child: Text('Sign Up', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              ),
                            ]
                        ),
                      ]
                    )
                  ],

                ),
              ),
            )
          ],
          //child: floatingActionButton: FloatingActionButton(onPressed: none),
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage())),

        backgroundColor: Colors.black,
        child: const Icon(Icons.house_rounded),
      ),
    );
  }
}

