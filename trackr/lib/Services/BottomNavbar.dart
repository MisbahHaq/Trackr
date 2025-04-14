import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:trackr/Pages/HomePage.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  late List<Widget> pages;

  late Home HomePage;
  late Order order;
  late Profile profilePage;
  late PostPage postPage;

  int currentTabIndex = 0;

  @override
  void initState() {
    HomePage = HomePage();
    order = OrderPage();
    postPage = PostPage();
    profilePage = ProfilePage();

    pages = [HomePage, postPage, order, profilePage];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.white,
        buttonBackgroundColor: Colors.orangeAccent,
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: screens[_page],
    );
  }
}
