import 'package:flutter/material.dart';
import 'package:news_app/widgets/sources.dart';

class HomeScreen  extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              child: Center(child: Text("See Sources   ",style: TextStyle(fontSize: 20),)),
            ),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SourcePage()));
            },
          )
        ],
      ),
      body: Center(
        child: Text("HomePage"),
      ),
    );
  }
}