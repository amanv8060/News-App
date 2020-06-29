import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/constant.dart';
import 'package:news_app/widgets/NewsCard.dart';
import 'package:news_app/widgets/categoryCard.dart';
import 'package:news_app/widgets/individualNews.dart';

class CategoryNewsList extends StatefulWidget{
  final String Address;
  @override
  _CategoryNewsListState createState()=> _CategoryNewsListState();

  CategoryNewsList({this.Address});
}

class _CategoryNewsListState extends State<CategoryNewsList>{
  Future<CategoryList> post;
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
          color: Colors.black12,
            height: MediaQuery.of(context).size.height,
            child:FutureBuilder<CategoryList>(
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
class CategoryList {
  final List<dynamic> articles;

  CategoryList({this.articles});

  factory CategoryList.fromJson(Map<String, dynamic> json) {
    return CategoryList(
      articles: json['articles'],
    );
  }
}

Future<CategoryList> fetchPost(String category) async {
  final response = await http.get('https://newsapi.org/v2/top-headlines?category=${category}&country=in&pageSize=100&apiKey=${NEWS_API_API_KEY}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return CategoryList.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}