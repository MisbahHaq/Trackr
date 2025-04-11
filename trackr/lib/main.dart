import 'package:flutter/material.dart';
import 'package:trackr/Pages/HomePage.dart';
import 'package:trackr/Pages/OnBoardingPage.dart';
import 'package:trackr/Pages/Post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: PostPage());
  }
}
