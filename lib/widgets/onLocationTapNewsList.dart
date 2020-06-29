import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/constant.dart';
import 'package:news_app/widgets/NewsCard.dart';

class LocationNewsList extends StatefulWidget{
  final String Address;
  @override
  _LocationNewsListState createState()=> _LocationNewsListState();

  LocationNewsList({this.Address});
}

class _LocationNewsListState extends State<LocationNewsList>{
  Future<LocationList> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost(widget.Address);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar:AppBar(title: Text("${widget.Address} News "),),
        body:Container(
      height: MediaQuery.of(context).size.height,
        child:FutureBuilder<LocationList>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int length=snapshot.data.articles.length;
              return Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: ListView.builder(
                    itemCount: length ,
                    itemBuilder: (BuildContext context, int index){
                      return NewsCard(snapshot.data.articles[index]);
                    }),
              );
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        )
        )
    );
  }
}
class LocationList {
  final List<dynamic> articles;

  LocationList({this.articles});

  factory LocationList.fromJson(Map<String, dynamic> json) {
    return LocationList(
      articles: json['articles'],
    );
  }
}

Future<LocationList> fetchPost(String address) async {
  final response = await http.get('https://newsapi.org/v2/everything?q=${address} news&apiKey=${NEWS_API_API_KEY}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return LocationList.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}