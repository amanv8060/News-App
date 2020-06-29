import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/widgets/ViewinApp.dart';

class IndividualNews extends StatelessWidget {
  var article;

  IndividualNews({this.article});

//todo remove geolocation permission
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(splashColor:Colors.deepPurple,onPressed: (){
        if(article["url"]!=null)
          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){return ViewinApp(link: article['url'],heading: article["title"],);}));
        else
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Missing URL"),));
        }, label: Text("View Complete")),
      appBar: AppBar(
        title: article["source"]["name"] != "null"
            ? Text(article["source"]["name"])
            : Text("News"),
      ),
      body:Container(
      height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
                child: article["urlToImage"] != null
                    ? Image.network(
                        article["urlToImage"],
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        "lib/assets/notfound.png",
                        fit: BoxFit.fill,
                      ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 100),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(article["publishedAt"]),
                        Text(article["author"]!=null?"By ${article["author"]}":"By Anonymous")
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(article["title"],style: TextStyle(fontSize: 22),),
                    SizedBox(height: 15,),
                    Text("Description: ${article["description"]}",style: TextStyle(fontSize: 18),),
                    SizedBox(height: 15,),
                    Text("Content: ${article["content"]}",style: TextStyle(fontSize: 18),),
                  ],
                ),
              )

          ],),
        ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple,
        child: ListTile(
          title: Text("Viewing Short Snippet"),
        ),
      ),
      );
  }
}