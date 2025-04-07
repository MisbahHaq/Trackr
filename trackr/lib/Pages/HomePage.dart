import 'package:flutter/material.dart';
import 'package:trackr/Services/Widget_Support.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Color(0xff6053f8),
                          size: 30,
                        ),
                        Text(
                          "Current Location",
                          style: AppWidget.SimpleTextFieldStyle(),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      "City Avenue, New York",
                      style: AppWidget.HeadLineTextFieldStyle(20.0),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height / 2.2,
              decoration: BoxDecoration(
                color: Color(0xff6053f8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  Text(
                    "Track your Shipment",
                    style: AppWidget.WhiteTextFieldStyle(),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Please enter your tracking number",
                    style: AppWidget.DifferentWhiteTextFieldStyle(),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Tracking Number",
                        hintStyle: AppWidget.SimpleTextFieldStyle(),
                        prefixIcon: Icon(
                          Icons.track_changes_rounded,
                          color: Colors.red,
                        ),
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                  Spacer(),
                  Image.asset("images/home.png", height: 200),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
