import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewinApp extends StatefulWidget {
  final String link;
  final String heading;

  ViewinApp({this.link, this.heading});

  @override
  _ViewinAppState createState() => _ViewinAppState();
}

class _ViewinAppState extends State<ViewinApp> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool _isLoading = false;
  num _stackIndex=1;

  @override
  void initState() {
    super.initState();
    _stackIndex=1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.heading),
      ),
//    withZoom: true,
      body: IndexedStack(
        index: _stackIndex,
        children: <Widget>[
                WebView(
                  initialUrl: widget.link,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (String url) {
                    print("Finished Loadiing${url}");
                    setState(() {
                      _stackIndex=0;
                    });
                  },
                ),
                Container(child:
                  Center(
                    child: CircularProgressIndicator(),
                  ),)
              ],
      ),
      bottomNavigationBar:
          BottomAppBar(
              color:Colors.deepPurple,child: ListTile(title: Text("You are Viewing this page inside app"))),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
