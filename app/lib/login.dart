import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_irrigation/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Directionality(
        textDirection: TextDirection.ltr,
        child: Text(text),
      ),
    ),
  );
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class _LoginState extends State<Login> {
  //text controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        showSnackBar(context, 'No Internet Connection');
        //devtools.log('No Internet Connection');
      } else if (e.code == "wrong-password") {
        return showSnackBar(context, 'Please enter correct password');
        //devtools.log('Please Enter correct password');
        //print('Please Enter correct password');
      } else if (e.code == 'user-not-found') {
        showSnackBar(context, 'Email not found');
        // print('Email not found');
      } else if (e.code == 'too-many-requests') {
        return showSnackBar(context, 'Too many attempts please try later');
        //print('Too many attempts please try later');
      } else if (e.code == 'invalid-credential') {
        return showSnackBar(context, 'Please enter correct password');
        //print('Email and password field are required');
      } else if (e.code == 'unknown') {
        return showSnackBar(context, 'Email Not Registered');
        //print(e.code);
      } else if (e.code == 'invalid-email') {
        return showSnackBar(context, 'Please enter correct email address');
        //print(e.code);
      } else {
        showSnackBar(context, 'User Not Registered');
        return print(e.code);
      }
    }

    // Navigator.pop(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScaleFactor = ScaleSize.textScaleFactor(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xff9FC784),
              Color(0xff599522),
            ],
            stops: [0, 90],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          child: Column(
            children: [
              SizedBox(
                height: 0.21 * screenHeight,
              ),
              Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.48,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(140, 217, 217, 217),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0.03 * screenHeight,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.1,
                      ),
                      Text(
                        language==0?"FARMEASY":"फार्म ईज़ी",
                        style: TextStyle(
                          fontFamily: "Impact",
                          fontSize: textScaleFactor * 12,
                          // fontWeight:FontWeight.w900,
                          color: Color(0xffF5F5F5),
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(
                        height: 0.025 * screenHeight,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: screenWidth * 0.8,
                          child: TextField(
                            maxLength: 100,
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: language==0?"Email":"ईमेल",
                              labelStyle: TextStyle(
                                color: Color.fromARGB(127, 75, 97, 79),
                                fontSize: 19.0 * textScaleFactor,
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                              counterText: '',
                              suffixIcon: Icon(
                                Icons.mail_outline_outlined,
                                color: Color.fromARGB(127, 75, 97, 79),
                                size: 25.0 * textScaleFactor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(127, 75, 97, 79),
                                    width: 2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(127, 75, 97, 79),
                                    width: 2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: Colors.transparent,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 25.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.02 * screenHeight,
                      ),
                      Container(
                        width: screenWidth * 0.8,
                        child: TextField(
                          maxLength: 100,
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: language==0?"Password":"पासवर्ड",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(127, 75, 97, 79),
                              fontSize: 19.0 * textScaleFactor,
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                            ),
                            counterText: '',
                            suffixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: Color.fromARGB(127, 75, 97, 79),
                              size: 25.0 * textScaleFactor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(127, 75, 97, 79),
                                  width: 2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(127, 75, 97, 79),
                                  width: 2),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 25.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.03 * screenHeight,
                      ),
                      Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            color: Color(0xff5C7744),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                              onPressed: signIn,
                              style: ElevatedButton.styleFrom(
                                // backgroundColor: Color.fromARGB(255, 48, 62, 35),
                                backgroundColor:
                                    Color.fromARGB(255, 75, 97, 79),
                                foregroundColor:
                                    Color.fromARGB(255, 75, 97, 79),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: Text(
                                language==0?"Sign In":"प्रवेश करें",
                                style: TextStyle(
                                  fontSize: textScaleFactor * 20,
                                  color: Color(0xffE3EBDE),
                                ),
                              ))),
                    ],
                  )),
              SizedBox(height: screenHeight * 0.04),
              Image(
                image: AssetImage(
                  "assets/images/loginfarmer2.png",
                ),
                width: screenWidth,
                height: 208,
              ),
            ],
          ),
        ),
      ),
    );
  }

  okay() {
    print("okays");
  }
}
