import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/userRoleComponent.dart';
import 'package:fyp_application/View/learnerAllScreens.dart';
import 'package:fyp_application/View/learnerLogin.dart';
import 'package:fyp_application/View/learnerSignup.dart';
import 'package:fyp_application/View/taskScreen.dart';

import 'caregiverWelcome.dart';

class userRoleScreen extends StatefulWidget {
  const userRoleScreen({super.key});

  @override
  State<userRoleScreen> createState() => _userRoleScreenState();
}

class _userRoleScreenState extends State<userRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                automaticallyImplyLeading: false,
                leadingWidth: 100),
            body: Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'lib/assets/logo.png',
                      width: 60,
                      height: 60,
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 50),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "I am a:",
                      style: TextStyle(
                          fontFamily: "Lato-Regular",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 34, 61)),
                    ),
                  ),
                ),
                userRoleComponent(
                    role: "Caregiver \nor Therapist",
                    image: "caregiverRole",
                    borderColour: Color.fromARGB(255, 66, 135, 123),
                    page: caregiverWelcome(),
                    width: 185,
                    height: 200),
                userRoleComponent(
                    role: "Learner",
                    image: "learnerRole",
                    borderColour: Color.fromARGB(255, 190, 166, 221),
                    page: learnerAllScreens())
                // page: learnerLogin())
              ],
            )));
  }
}
