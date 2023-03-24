import 'package:flutter/material.dart';

import 'app_constants.dart';

class AppTheme {

  ThemeData appTheme() {
    return ThemeData(
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 18, color: Colors.white,  fontWeight: FontWeight.w400,),
        headline3: TextStyle(fontSize: 17, color: Colors.white,  ),
        headline4: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600, ),
        headline5: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600, ),
        headline6: TextStyle(fontSize: 15, color: Colors.white, ),
        bodyText1: TextStyle(fontSize: 16, color: Colors.white, ),
        bodyText2: TextStyle(fontSize: 16, color: Colors.white, fontStyle: FontStyle.italic),
        subtitle1: TextStyle(fontSize: 14, color: Colors.white38, ),
      ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: bottomNavigationBarColor,
    selectedIconTheme: IconThemeData(
      color: selectedItemColor
    ),
  unselectedItemColor: unselectedItemColor,
),
      scaffoldBackgroundColor: backgroundColor,
      primarySwatch: Colors.blueGrey,
      primaryColor: backgroundColor,
      indicatorColor: const Color(0xFFFFFFee),
      dividerColor: unselectedItemColor,
      appBarTheme: const AppBarTheme(color: backgroundColor, elevation: 0),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0xff1e272e),
        prefixStyle: TextStyle(
          color: Colors.blue,
        ),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
