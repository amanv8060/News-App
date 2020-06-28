import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/constant.dart';

class SourcePage extends StatefulWidget{
  @override
  _SourcePageState createState()=> _SourcePageState();
}

class _SourcePageState extends State<SourcePage>{
  Future<Sources> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:Text("Our Sources")),
        body: FutureBuilder<Sources>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int length=snapshot.data.sources.length;
              return Container(
                height: MediaQuery.of(context).size.height*0.8,
                child: ListView.builder(
                  itemCount: length ,
                    itemBuilder: (BuildContext context, int index){
                    return ListTile(
                      //todo implement Url Launch
                      title: Text(snapshot.data.sources[index]["name"]),
                    );
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
    );
  }
}
class Sources {
  final List<dynamic> sources;

  Sources({this.sources});

  factory Sources.fromJson(Map<String, dynamic> json) {
    return Sources(
      sources: json['sources'],
    );
  }
}

Future<Sources> fetchPost() async {
  final response = await http.get('https://newsapi.org/v2/sources?language=en&apiKey=${NEWS_API_API_KEY}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return Sources.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}