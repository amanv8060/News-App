import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app/widgets/onTapLocation.dart';

import 'package:news_app/widgets/sources.dart';
import 'dart:async';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  Set<Marker> _markers={};
  Completer<GoogleMapController> _controller = Completer();


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
  );


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _handleTap,
      )
    );
  }
  _handleTap(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: point.toString(),
        ),
        onTap: ()=>
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OnTapLocation(cood: point))),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>OnTapLocation(cood: point)));

  }
}




//import 'package:flutter/material.dart';
//import 'package:news_app/widgets/sources.dart';
//
//class NewsScreen extends StatefulWidget {
//  @override
//  _NewsScreenState createState() => _NewsScreenState();
//}
//
//class _NewsScreenState extends State<NewsScreen>{
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("News App"),
//        actions: <Widget>[
//          GestureDetector(
//            child: Container(
//              child: Center(child: Text("See Sources   ",style: TextStyle(fontSize: 20),)),
//            ),
//            onTap: (){
//              Navigator.push(context,MaterialPageRoute(builder: (context)=>SourcePage()));
//            },
//          )
//        ],
//      ),
//      //todo implement body
//      body: Center(
//        child: Text("News Screen"),
//      ),
//    );
//  }
//}