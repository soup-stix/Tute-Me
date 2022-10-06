import 'package:flutter/material.dart';
import 'package:tute_me/forgotpassword.dart';
import 'package:tute_me/login.dart';
import 'package:tute_me/profile.dart';
import 'package:tute_me/register.dart';
import 'package:tute_me/resetpassword.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/student_register.dart';
import 'package:tute_me/books.dart';
import 'package:tute_me/cycles.dart';
import 'package:tute_me/listingnew.dart';
import 'package:tute_me/favourites_expanded.dart';
import 'package:tute_me/favourites.dart';
import 'package:tute_me/map.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //initialRoute: 'details',
    initialRoute: 'login',
    routes: {
      'register':(context) => MyRegister(),
      'login':(context) => MyLogin(),
      'forgotpassword':(context) => ForgotPassword(),
      'resetpassword':(context) => ResetPassword(),
      'homepage':(context) => HomePage(),
      'homepage':(context) => Student_Register(),
      'books':(context) => Books(),
      'cycles':(context) => Cycles(),
      'listingnew':(context) => Listing(),
      'profile':(context) => MyProfile(),
      'favourites_expanded':(context) => Favourites_Expanded(),
      'map':(context) => Map(),
      //'details':(context) => Details(),

    },
  ));
}


