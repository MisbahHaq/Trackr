import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:trackr/OnBoarding/LoginPage.dart';
import 'package:trackr/Services/BottomNavbar.dart';
import 'package:trackr/Services/Database.dart';
import 'package:trackr/Services/Shared_Prefs.dart';
import 'package:trackr/Services/Widget_Support.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  String? name, email, password;

  bool _isLoading = false;

  registration() async {
    setState(() {
      _isLoading = true;
    });

    if (passwordcontroller.text != "" &&
        emailcontroller.text != "" &&
        namecontroller.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        String id = randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveUserId(id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
        await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);

        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": emailcontroller.text,
          "Id": id,
        };
        await DatabaseMethods().addUserDetail(userInfoMap, id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registered Successfully!",
              style: AppWidget.WhiteTextFieldStyle(20.0),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Bottom()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMsg = "An error occurred";
        if (e.code == "weak-password") {
          errorMsg = "Password Provided is too weak";
        } else if (e.code == 'email-already-in-use') {
          errorMsg = "Account Already Exists";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              errorMsg,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefeeed),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset("images/login.png"),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 23.0),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 23.0),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                obscureText: true,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 23.0),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (passwordcontroller.text != "" &&
                          emailcontroller.text != "" &&
                          namecontroller.text != "") {
                        setState(() {
                          email = emailcontroller.text.trim();
                          password = passwordcontroller.text.trim();
                        });
                        registration();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "Please Fill Complete Details",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
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
                          color: Color(0xff3a608d),
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
                  "Already have an account?",
                  style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    " Sign in",
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
    );
  }
}
