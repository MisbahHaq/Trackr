import 'package:flutter/material.dart';
import 'package:trackr/Services/Widget_Support.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool current = true, past = false;
  int _currentStep = 1;

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
                        _buildOrderButton(
                          "Current\nOrders",
                          "images/currentorder.png",
                          current,
                          () {
                            setState(() {
                              current = true;
                              past = false;
                            });
                          },
                        ),
                        _buildOrderButton(
                          "Past\nOrders",
                          "images/delivery-man.png",
                          past,
                          () {
                            setState(() {
                              current = false;
                              past = true;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(0xff6053f8),
                                size: 30.0,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "Karachi",
                                style: AppWidget.NormalLineTextFieldStyle(20.0),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "images/parcel.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(5, (index) {
                                    return _buildTimelineStep(index);
                                  }),
                                ),
                              ),
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

  Widget _buildOrderButton(
    String title,
    String imagePath,
    bool isSelected,
    Function onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Material(
        elevation: isSelected ? 5.0 : 0.0,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: 130,
                height: 130,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    isSelected
                        ? AppWidget.HeadLineTextFieldStyle(25.0)
                        : AppWidget.NormalLineTextFieldStyle(24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineStep(int index) {
    return Row(
      children: [
        Icon(
          index <= _currentStep ? Icons.check_circle : Icons.circle_outlined,
          color: index <= _currentStep ? Color(0xff6053f8) : Colors.grey,
          size: 30.0,
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            _getStatusText(index),
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  String _getStatusText(int index) {
    switch (index) {
      case 0:
        return "Driver is on the way to pickup point";
      case 1:
        return "Driver has arrived at pickup point";
      case 2:
        return "Parcel Collected";
      case 3:
        return "Driver is on the way to destination";
      case 4:
        return "Parcel Delivered";
      default:
        return "";
    }
  }
}
