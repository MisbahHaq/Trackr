import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:trackr/OnBoarding/LoginPage.dart';
import 'package:trackr/OnBoarding/SignupPage.dart';
import 'package:trackr/Pages/HomePage.dart';
import 'package:trackr/OnBoarding/OnBoardingPage.dart';
import 'package:trackr/Pages/PostPage.dart';
import 'package:trackr/Services/BottomNavbar.dart';
import 'package:trackr/Services/Constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = '$publishedkey';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignupPage());
  }
}
