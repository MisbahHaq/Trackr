import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trackr/OnBoarding/SignupPage.dart';
import 'package:trackr/Services/BottomNavbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  userLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bottom()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'user-not-found') {
        message = "No User found for that Email";
      } else if (e.code == 'wrong-password') {
        message = "Wrong Password Provided by User";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefeeed),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("images/signin.png"),
              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 23.0),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 23.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60.0),
              Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (passwordController.text != "" &&
                            emailController.text != "") {
                          setState(() {
                            email = emailController.text.trim();
                            password = passwordController.text.trim();
                          });
                          userLogin();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Please fill the Complete Details",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Color(0xffea6d35),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Center(
                            child:
                                _isLoading
                                    ? CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3.0,
                                    )
                                    : Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 36.0,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      " Sign Up",
                      style: TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
