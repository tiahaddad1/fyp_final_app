import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/learnerInformationScreen.dart';
import 'package:fyp_application/View/learnerSignup.dart';

import '../../Model/Learner.dart';

class learnerInfoCard extends StatefulWidget {
  // final Learner data;
  final String first_name;
  final String last_name;
  // const learnerInfoCard({super.key, required this.data});
  const learnerInfoCard({super.key, required this.first_name,required this.last_name});
  // const learnerInfoCard({super.key});

  @override
  State<learnerInfoCard> createState() => _learnerInfoCardState();
}

class _learnerInfoCardState extends State<learnerInfoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => learnerInfoScreen()));
      },
      child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 249, 250),
              // border: Border(bottom:BorderSide(color: Colors.grey,width: 2),right:BorderSide(color: Colors.grey,width: 2) ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 179, 179, 179),
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75))
              ]),
          height: MediaQuery.of(context).size.height / 4.5,
          width: MediaQuery.of(context).size.width / 3,
          child: Column(children: [
            Padding(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(55), // Image radius
                  child: Image.asset("lib/assets/user1.png", fit: BoxFit.cover),
                ),
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10),
            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              alignment: Alignment.topLeft,
              child: Text(
                // "Liam Harrison",
                // widget.data.first_name.substring(0,1).toUpperCase()+widget.data.first_name.substring(1)+" "+widget.data.last_name.substring(0,1).toUpperCase()+widget.data.last_name.substring(1),
                widget.first_name.substring(0,1).toUpperCase()+widget.first_name.substring(1)+" "+widget.last_name.substring(0,1).toUpperCase()+widget.last_name.substring(1),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Cabin-Regular"),
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Image.asset(
                      "lib/assets/star.png",
                      width: 8,
                      height: 8,
                    )),
                Padding(
                  child: Text("25",
                      style: TextStyle(
                          color: Color.fromARGB(255, 66, 135, 123),
                          fontSize: 10,
                          fontFamily: "Fredoka-SemiBold")),
                  padding: EdgeInsets.only(left: 5),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 8,
                        fontFamily: "Fredoka-SemiBold"),
                    children: [
                      TextSpan(
                        text:
                            '5 ', //changes to calculating current time with the time of each task of the learner
                        style: TextStyle(
                          color: Color.fromARGB(255, 13, 48, 140),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                          text: 'of ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 100, 100, 100),
                          )),
                      TextSpan(
                          text:
                              '12 ', //changes to taking the size of the arraylist
                          style: TextStyle(
                            color: Color.fromARGB(255, 13, 48, 140),
                          )),
                      TextSpan(
                          text: 'tasks completed today ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 100, 100, 100),
                          )),
                    ]),
              ),
            )
          ])),
    );
  }
}
