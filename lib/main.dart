import 'package:flutter/material.dart';
import 'package:movie/utils/theme.dart';
import 'package:movie/view/pages/home_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  final AppTheme _theme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme.appTheme(),
      home: HomePage(),
    );
  }
}


