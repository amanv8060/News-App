import 'package:flutter/material.dart';
import 'package:news_app/Screens/homeScreen.dart';
import 'package:news_app/Screens/newsScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;
  List<Widget> pages;
  Widget currentPage;

  HomeScreen homeScreen;
  NewsScreen newsScreen;

  @override
  void initState() {
    super.initState();
    homeScreen = HomeScreen();
    newsScreen = NewsScreen();
    pages = [homeScreen, newsScreen];
    currentPage = homeScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        backgroundColor: Colors.black,
//        Color(0xFF007944),
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
//                color: Colors.black,
              ),
              title: Text(
                "Home",
//                style: TextStyle(color: Colors.black),
              ),
              activeIcon: Icon(Icons.home, color: Color(0xFFdc2f02))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
//                color: Colors.black,
              ),
              title: Text(
                "Search",
//                style: TextStyle(color: Colors.black),
              ),
              activeIcon: Icon(Icons.search, color: Color(0xFFdc2f02))),
        ],
        elevation: 10.0,
      ),
      body: currentPage,
    );
  }
}
