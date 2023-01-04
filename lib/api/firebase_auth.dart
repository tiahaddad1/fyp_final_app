import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utils.dart';
import '../View/signUpCaregiver.dart';
import '../main.dart';

class AuthService {
  Stream<User?> get authStateChanges => FirebaseAuth.instance.idTokenChanges();

  static Future login(
      String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return "Logged In!";
    } on FirebaseAuthException catch (e) {
      print("Error with logging in!");
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  static Future signUp(
      String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      print("Signed Up!");
    } on FirebaseAuthException catch (e) {
      print("Error with signing up!");
      Utils().showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
