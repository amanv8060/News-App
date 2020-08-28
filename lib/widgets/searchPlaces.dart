import 'package:flutter/material.dart';
import 'package:news_app/constant.dart';
import 'package:news_app/widgets/searchNews.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
//        borderRadius: BorderRadius.circular(30),
        elevation: 6,
        child: ListTile(
          title: Text("Search any Country"),
          trailing: Icon(Icons.search),
          onTap: () => showSearch(context: context, delegate: SearchProducts()),
        ));
  }
}

class SearchProducts extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  List<List> _countries = countries;
  List<List> _recents = [
    ["India", "IN"]
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(
            Icons.clear,
          ),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
//    return SearchNewsList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? _recents
        : _countries
            .where((p) => p[0].toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchNewsList(Address: suggestionsList[index])));
        },
        leading: Icon(Icons.location_on),
        title: Text(suggestionsList[index][0]),
        subtitle: Text("Country Code : ${suggestionsList[index][1]}"),
      ),
      itemCount: suggestionsList.length,
    );
  }
}
