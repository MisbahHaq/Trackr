import 'package:flutter/material.dart';
import 'package:trackr/Services/Widget_Support.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool current = true, past = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6053f8),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "All Orders",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        current
                            ? Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "images/currentorder.png",
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Current\nOrders",
                                      textAlign: TextAlign.center,
                                      style: AppWidget.HeadLineTextFieldStyle(
                                        25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                current = true;
                                past = false;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "images/currentorder.png",
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Current\nOrders",
                                      textAlign: TextAlign.center,
                                      style: AppWidget.NormalLineTextFieldStyle(
                                        24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        past
                            ? Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "images/delivery-man.png",
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Past\nOrders",
                                      textAlign: TextAlign.center,
                                      style: AppWidget.HeadLineTextFieldStyle(
                                        25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : GestureDetector(
                              onTap: () {
                                current = false;
                                past = true;
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "images/delivery-man.png",
                                      width: 130,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Past\nOrders",
                                      textAlign: TextAlign.center,
                                      style: AppWidget.NormalLineTextFieldStyle(
                                        24.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ],
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
