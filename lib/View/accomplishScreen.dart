import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/learnerHome.dart';

import 'Components/buttonComponent.dart';
import 'learnerAllScreens.dart';
import 'learnerLogin.dart';
import 'learnerReminders.dart';

class accomplishScreen extends StatefulWidget {
  const accomplishScreen({super.key});

  @override
  State<accomplishScreen> createState() => _accomplishScreenState();
}

class _accomplishScreenState extends State<accomplishScreen> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        margin: EdgeInsets.all(25),
        // height: 500,
        // width: 400,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 214, 245, 215),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          // Padding(padding: EdgeInsets.all(20),child: Text(task.title,style: TextStyle(fontFamily: "Fredoka-Medium",color: Color.fromARGB(255, 3,20,66),fontSize: 20),),)
          Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Task Completed",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: "ComingSoon-Regular",
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 30),
                    ),
                    Text(
                      "Well Done!",
                      style: TextStyle(
                          fontFamily: "ComingSoon-Regular",
                          color: Color.fromARGB(255, 3, 20, 66),
                          fontSize: 30),
                    ),
                  ])),
          Container(
            width: 400,
            height: 200,
            child: Image.asset("lib/assets/rewardStars.png"),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 15, left: 15, right: 5),
            child: RichText(
                text: TextSpan(
                    text: "You are rewarded with ",
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 62, 81, 140)),
                    children: <TextSpan>[
                  TextSpan(
                      text: "5 stars ",
                      style:
                          TextStyle(color: Color.fromARGB(255, 183, 144, 7))),
                  TextSpan(
                      text: "for completing the task.",
                      style:
                          TextStyle(color: Color.fromARGB(255, 62, 81, 140))),
                ])),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: buttonComponent(
                colour: Color.fromARGB(255, 120, 138, 240),
                text: "Thank you, please continue",
                function: navigateToHome(context),
              ))
        ]),
      ),
      alignment: Alignment.center,
    );
  }
}

navigateToHome(BuildContext context) {
  // return Navigator.push(
  //     context, MaterialPageRoute(builder: (context) => learnerHome()));
}
