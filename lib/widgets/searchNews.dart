import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/constant.dart';
import 'package:news_app/widgets/NewsCard.dart';

class SearchNewsList extends StatefulWidget{
  final List Address;
  @override
  _SearchNewsListState createState()=> _SearchNewsListState();

  SearchNewsList({this.Address});
}

class _SearchNewsListState extends State<SearchNewsList>{
  Future<SearchList> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost(widget.Address[1].toString());
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar:AppBar(title: Text("${widget.Address[0]} News "),),
        body:Container(
            height: MediaQuery.of(context).size.height,
            child:FutureBuilder<SearchList>(
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
class SearchList {
  final List<dynamic> articles;

  SearchList({this.articles});

  factory SearchList.fromJson(Map<String, dynamic> json) {
    return SearchList(
      articles: json['articles'],
    );
  }
}

Future<SearchList> fetchPost(String address) async {
  final response = await http.get('https://newsapi.org/v2/top-headlines?country=${address}&apiKey=${NEWS_API_API_KEY}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return SearchList.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}