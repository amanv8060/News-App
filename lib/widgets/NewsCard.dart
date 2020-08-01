import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:news_app/widgets/individualNews.dart';

class NewsCard extends StatelessWidget {
  var currentList;

  NewsCard(var currentList) {
    this.currentList = currentList;
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width / 1.5;
    double heit = MediaQuery.of(context).size.height / 5;
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.all(10.0),
          width: wid,
          height: heit - 30,
          child: Card(
//              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              elevation: 10,
              shadowColor: Colors.black,
              child: Center(
                child: ListTile(
                  title: Text(currentList["title"]),
                ),
              )),
        ),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (BuildContext context) {return IndividualNews(article: currentList,);})));
  }
}
