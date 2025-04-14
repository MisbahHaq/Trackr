import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:trackr/Pages/HomePage.dart';
import 'package:trackr/Pages/OrderPage.dart';
import 'package:trackr/Pages/PostPage.dart';
import 'package:trackr/Pages/ProfilePage.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  late List<Widget> pages;

  late HomePage homePage;
  late OrderPage order;
  late ProfilePage profilePage;
  late PostPage postPage;

  int currentTabIndex = 0;

  @override
  void initState() {
    homePage = HomePage();
    order = OrderPage();
    postPage = PostPage();
    profilePage = ProfilePage();

    pages = [homePage, postPage, order, profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: Colors.transparent,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home, color: Colors.white, size: 34.0),
          Icon(Icons.post_add, color: Colors.white, size: 34.0),
          Icon(Icons.shopping_bag, color: Colors.white, size: 34.0),
          Icon(Icons.person, color: Colors.white, size: 34.0),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
