import 'package:corona_tracker/constant.dart';
import 'package:corona_tracker/screens/homePage.dart';
import 'package:flutter/material.dart';

void main() { 
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona Tracker',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
         //   body1: TextStyle(color: kBodyTextColor),
          )),
      home: HomeScreen(),
    );
  }
}


  

