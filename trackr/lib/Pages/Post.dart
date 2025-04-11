import 'package:flutter/material.dart';
import 'package:trackr/Services/Widget_Support.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6053f8),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Add Package",
                style: AppWidget.WhiteTextFieldStyle(),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "images/delivery-truck.png",
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Add Location",
                      style: AppWidget.HeadLineTextFieldStyle(22.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
