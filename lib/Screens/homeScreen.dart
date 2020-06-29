import 'package:flutter/material.dart';
import 'package:news_app/widgets/categoryCard.dart';
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
      body: Container(
        color: Colors.black12,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CategoryCard(name: "entertainment.webp",heading: "Entertainment",),
              Divider(),
              CategoryCard(name:"business.jpg",heading: "Business",),
              Divider(),
              CategoryCard(name:"general.png",heading: "General",),
              Divider(),
              CategoryCard(name: "health.jpg",heading: "Health",),
              Divider(),
              CategoryCard(name: "science.png",heading: "Science",),
              Divider(),
              CategoryCard(name: "sports.jpg",heading: "Sports",),
              Divider(),
              CategoryCard(name:"technology.jpeg",heading: "Technology",)
              
            ],
          ),
        ),
      ),
    );
  }
}