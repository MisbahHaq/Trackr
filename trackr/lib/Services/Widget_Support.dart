import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle HeadLineTextFieldStyle(double textsize) {
    return TextStyle(
      color: Colors.black,
      fontSize: textsize,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle NormalLineTextFieldStyle(double textsize) {
    return TextStyle(
      color: Colors.black,
      fontSize: textsize,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle SimpleTextFieldStyle() {
    return TextStyle(
      color: Colors.black38,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle SlowSimpleTextFieldStyle() {
    return TextStyle(
      color: Colors.black38,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle WhiteTextFieldStyle(double textsize) {
    return TextStyle(
      color: Colors.white,
      fontSize: textsize,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle DifferentWhiteTextFieldStyle() {
    return TextStyle(
      color: Colors.white54,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );
  }
}
