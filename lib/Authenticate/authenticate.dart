import 'package:chat_application/Authenticate/loginScreen.dart';
import 'package:chat_application/HomeScreen/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      return HomePage();
    } else {
      return LoginScreen();
    }
  }
}
