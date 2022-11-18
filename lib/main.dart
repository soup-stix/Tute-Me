import 'package:flutter/material.dart';
import 'package:tute_me/forgotpassword.dart';
import 'package:tute_me/login.dart';
import 'package:tute_me/teacherprofile.dart';
import 'package:tute_me/register.dart';
import 'package:tute_me/resetpassword.dart';
import 'package:tute_me/homepage.dart';
import 'package:tute_me/student_register.dart';
import 'package:tute_me/listingnew.dart';
import 'package:tute_me/favourites_expanded.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tute_me/map.dart';
import 'package:tute_me/review.dart';
import 'package:tute_me/viewreviews.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      'listingnew':(context) => Listing(),
      'profile':(context) => MyProfile(),
      'favourites_expanded':(context) => Favourites_Expanded(),
      'map':(context) => Map(),
      'viewreviews':(context) => MyReview(id: null,),
      //'details':(context) => Details(),

    },
  ));
}
