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
                style: AppWidget.WhiteTextFieldStyle(25.0),
              ),
            ),
            SizedBox(height: 30.0),
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
                    SizedBox(height: 20.0),
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
                    SizedBox(height: 20.0),
                    Text(
                      "Pick Up",
                      style: AppWidget.NormalLineTextFieldStyle(18.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Pickup Location",
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Drop Off",
                      style: AppWidget.NormalLineTextFieldStyle(18.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xffececf8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter fropoff Location",
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.9,
                        decoration: BoxDecoration(
                          color: Color(0xff6053f8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Submit Location",
                            style: AppWidget.WhiteTextFieldStyle(19.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "PickUp Details",
                            style: AppWidget.NormalLineTextFieldStyle(24.0),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: Color(0xff6053f8),
                              ),
                              TextField(),
                            ],
                          ),
                        ],
                      ),
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
