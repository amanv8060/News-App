import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/mainScreen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}
