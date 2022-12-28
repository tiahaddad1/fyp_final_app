import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/learnerSchedule.dart';
import 'package:intl/intl.dart';

class learnerHome extends StatefulWidget {
  const learnerHome({super.key});

  @override
  State<learnerHome> createState() => _learnerHomeState();
}

final time = DateTime.now().hour;

Color colorByTime() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return Color.fromARGB(255, 192, 214, 255);
  }
  if (hour < 17) {
    return Color.fromARGB(255, 115, 164, 255);
  }
  return Color.fromARGB(255, 5, 13, 28);
}

Color textColor() {
  if (time < 12) {
    return Color.fromARGB(255, 1, 4, 71);
  }
  if (time < 17) {
    // return Color.fromARGB(255, 1, 4, 71);
    return Color.fromARGB(255, 8, 15, 28);
  }
  return Color.fromARGB(255, 255, 255, 255);
}

bool tapped = false;

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}

final String day = DateFormat("EEEEE").format(DateTime.now());
final String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
final String nOrD = DateFormat("a").format(DateTime.now());

class _learnerHomeState extends State<learnerHome> {
  late FileImage image;

  @override
  build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  stops: [0.02, 0.02],
                  colors: [Color.fromARGB(255, 64, 84, 155), colorByTime()]),
              borderRadius: new BorderRadius.all(const Radius.circular(6.0))),
          height: 150,
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(top: 25, right: 15, left: 15),
                child: RichText(
                    text: TextSpan(
                  style: TextStyle(
                    color: textColor(),
                  ), //apply style to all
                  children: [
                    TextSpan(
                        text: greeting(),
                        style:
                            TextStyle(fontFamily: "DMSans-Bold", fontSize: 21)),
                    TextSpan(
                        text: ", USER",
                        style: TextStyle(
                            fontFamily: "DMSans-Medium",
                            fontWeight: FontWeight.bold,
                            fontSize: 21)),
                  ],
                )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 15,right:5),
                child: Text(
                  "Today: " + day + " , " + date,
                  style: TextStyle(color: textColor(), fontSize: 13),
                ),
              ),
            ]),
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(50), // Image radius
                child: Image.asset("lib/assets/user1.png", fit: BoxFit.cover),
              ),
            ),
            // Container(
            //     height: 90,
            //     width: 100,
            //     // padding: EdgeInsets.only(top: 20),
            //     child: Image.asset("lib/assets/user1.png",fit: BoxFit.fill),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(40))))
          ]),
        ),
        Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(stops: [
                  0.02,
                  0.02
                ], colors: [
                  Color.fromARGB(255, 64, 84, 155),
                  Color.fromARGB(201, 242, 241, 241)
                ]),
                borderRadius: new BorderRadius.all(const Radius.circular(6.0))),
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("My Schedule",
                        style: TextStyle(
                            fontFamily: "DMSans-Bold",
                            fontSize: 27,
                            color: Color.fromARGB(255, 64, 84, 155)))),
                Column(children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: Image.asset(
                      "lib/assets/taskImage.png",
                      width: 70,
                      height: 70,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "View All",
                        style: TextStyle(
                          color: Color.fromARGB(255, 20, 36, 255),
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => learnerSchedule()))),
                  ),
                ]),
              ],
            )),
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(stops: [
                      0.02,
                      0.02
                    ], colors: [
                      Color.fromARGB(255, 64, 84, 155),
                      Color.fromARGB(201, 242, 241, 241)
                    ]),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(6.0))),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Row(children: [
                                IconButton(
                                  // alignment: Alignment.topRight,
                                  iconSize: 13,
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  onPressed: () {},
                                ),
                                Text(
                                  "Previous Task",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                  ),
                                ),
                              ])),

                          Row(children: [
                            Text(
                              "Next Task",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                              ),
                            ),
                            IconButton(
                              // alignment: Alignment.topRight,
                              iconSize: 13,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              onPressed: () {},
                            ),
                          ]),
                          //),
                        ]),
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 30),
                      alignment: Alignment.topLeft,
                      child: Text("Task Title",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DMSans-Medium",
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 20, bottom: 10),
                            child: Text("Now",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 39, 125, 43),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Chivo-Regular",
                                )),
                            padding: EdgeInsets.all(10)),
                        Container(
                          margin:
                              EdgeInsets.only(right: 20, top: 20, bottom: 20),
                          padding: EdgeInsets.all(10),
                          child: Text("Time",
                              style: TextStyle(
                                color: Color.fromARGB(255, 39, 125, 43),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Chivo-Regular",
                              )),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 200,
                            width: 350,
                            padding: EdgeInsets.all(15),
                            child: Image.asset(
                              "lib/assets/footballTaskImage.jpeg",
                              width: 350,
                              height: 350,
                            ))),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 100,
                          width: 350,
                          padding: EdgeInsets.all(15),
                          color: Color.fromARGB(199, 231, 228, 228),
                          child: Text("some data here..",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontFamily: "Chivo-Regular",
                              ))),
                    )
                  ],
                ))),
      ],
    );
  }
}
