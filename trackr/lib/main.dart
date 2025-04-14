import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trackr/Pages/HomePage.dart';
import 'package:trackr/Pages/OnBoardingPage.dart';
import 'package:trackr/Pages/Post.dart';
import 'package:trackr/Services/BottomNavbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Bottom());
  }
}
