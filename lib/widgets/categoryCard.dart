import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:news_app/widgets/categoryList.dart';

class CategoryCard extends StatelessWidget{
  final String name;
  final String heading;
  CategoryCard({this.name,this.heading="hey"});


  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width*0.9;
    double heit=MediaQuery.of(context).size.height/3.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('   ${heading}',style: TextStyle(fontSize: 24),),
          ],
        ),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.all(10.0),
            width:wid,
            height: heit,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage("lib/assets/${name}"),
                fit: BoxFit.fill
              )
            ),
          ),
          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryNewsList(Address: heading,))),
        ),
      ],
    );
  }
}