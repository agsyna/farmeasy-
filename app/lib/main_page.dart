import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_irrigation/homepage.dart';
import 'package:smart_irrigation/login.dart';

class mainPage extends StatelessWidget {
  const mainPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>
      (
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            try{
               if (snapshot.hasData) {
              return const Homepage();
               }
            }
              catch(e){
                showSnackBar(context, "Error : $e");
                return const Login();
              }
              return const Login();
              
              
            
          }),
    );
  }
}
