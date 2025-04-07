import 'package:flutter/material.dart';
import 'package:trackr/Services/Widget_Support.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Image.asset('images/onboard.png'),
            SizedBox(height: 50.0),
            Text(
              "Track your parcel\nfrom anywhere",
              textAlign: TextAlign.center,
              style: AppWidget.HeadLineTextFieldStyle(30.0),
            ),
            SizedBox(height: 30.0),
            Text(
              "Check the progress of your deliveries",
              style: AppWidget.SimpleTextFieldStyle(),
            ),
            SizedBox(height: 30.0),
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xfff8ae39),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Track Now",
                    style: AppWidget.WhiteTextFieldStyle(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
