import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/constant.dart';
import 'package:news_app/widgets/onLocationTapNewsList.dart';

class OnTapLocation extends StatefulWidget{
  LatLng cood;
  @override
  _OnTapLocationState createState()=> _OnTapLocationState();

  OnTapLocation({this.cood});

}

class _OnTapLocationState extends State<OnTapLocation>{
  Future<Location> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost(widget.cood);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        FutureBuilder<Location>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LocationNewsList(Address: '${snapshot.data.subDivision} , ${snapshot.data.country}',);
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height:10),
                Text("Analyzing Location")
              ],
            ));
          },
        )
    );
  }

}

Future<Location> fetchPost(LatLng point) async {
  final response = await http.get('http://api.geonames.org/countrySubdivisionJSON?lat=${point.latitude}&lng=${point.longitude}&username=${GEOLOCATION_APIKEY}');

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return Location.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
}

class Location {
  var subDivision;
  var country;

  Location({this.subDivision,this.country});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      subDivision: json["adminName1"],
      country: json["countryName"]
    );
  }
}

