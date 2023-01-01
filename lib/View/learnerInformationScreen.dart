import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/deleteButton.dart';
import 'package:fyp_application/View/Components/learnerDetailComponent.dart';
import 'package:fyp_application/View/addTaskScreen.dart';
import 'package:fyp_application/View/caregiverViewFeelings.dart';
import 'package:fyp_application/View/caregiverViewReminders.dart';
import 'package:fyp_application/View/caregiverViewRewards.dart';
import 'package:fyp_application/View/caregiverViewSchedule.dart';
import 'package:fyp_application/View/caregiverViewSkills.dart';

class learnerInfoScreen extends StatefulWidget {
  const learnerInfoScreen({super.key});

  @override
  State<learnerInfoScreen> createState() => _learnerInfoScreenState();
}

class _learnerInfoScreenState extends State<learnerInfoScreen> {

 deleteLearnerFromDB(){
    //populate code with deleting user from db
  }

  bool editImage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 251, 251, 251),
          toolbarHeight: 240,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(20),

          //   ),
          // ),
          title: Expanded(
              child: Column(children: [
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 0, bottom: 20),
                              alignment: Alignment.topLeft,
                              height: 30,
                              child: IconButton(
                                alignment: Alignment.topLeft,
                                iconSize: 23,
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "Liam Harrison",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cabin-Regular"),
                                textAlign: TextAlign.left,
                              ),
                              padding: EdgeInsets.only(bottom: 20, left: 10),
                            ),
                            Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Padding(
                                    child: Text(
                                      "age: " +
                                          "12" +
                                          " years old", //subtract the year they were born with today's date
                                      style: TextStyle(
                                        fontFamily: "Cabin-Regular",
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(10),
                                  ),
                                  Padding(
                                    child: Text(
                                      "date of birth: " +
                                          "24/01/2010", //display their dob
                                      style: TextStyle(
                                        fontFamily: "Cabin-Regular",
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 16, 16, 16),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(10),
                                  ),
                                ])),
                          ],
                        ),
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Stack(alignment: Alignment.topRight, children: <Widget>[
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(15), // Image border
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(55), // Image radius
                            child: Image.asset("lib/assets/user1.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 7,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  editImage = true;
                                });
                                if (editImage == true) {
                                  // upload image and save to DB!
                                }
                                print("clicked!");
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  child: Image.asset(
                                    "lib/assets/pencil.png",
                                    width: 18,
                                    height: 18,
                                  ),
                                  padding: EdgeInsets.only(top: 5, left: 5),
                                ),
                              )),
                        ),
                      ])
                    ])),
          ]))),
      backgroundColor: Color.fromARGB(255, 66, 135, 123),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 251, 251, 251),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            margin: EdgeInsets.only(right: 30, left: 30, bottom: 20),
            height: MediaQuery.of(context).size.height -
                400, //media context of screen
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 10,top: 20),
                  padding: EdgeInsets.only(left: 13),
                  child: Text("Liam's"+" information:",style: TextStyle(color: Color.fromARGB(255, 63,62,59),decoration: TextDecoration.underline,fontSize: 17,fontFamily: "lib/assets/Cabin-Regular",fontWeight: FontWeight.w600),),
                ),
                Expanded(child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  learnerDetailComp(image: "lib/assets/scheduleDetailIcon.png", name: "Schedule", page: addTaskScreen()),
                  // learnerDetailComp(image: "lib/assets/scheduleDetailIcon.png", name: "Schedule", page: caregiverSchedule()),
                  learnerDetailComp(image: "lib/assets/feelingsDetailIcon.png", name: "Feelings", page: caregiverFeelings()),
                  learnerDetailComp(image: "lib/assets/pinDetailIcon.png", name: "Reminders", page: caregiverReminders()),
                  learnerDetailComp(image: "lib/assets/skillDetailIcon.png", name: "Skills", page: caregiverSkills()),
                  learnerDetailComp(image: "lib/assets/rewardDetailIcon.png", name: "Rewards", page: caregiverRewards()),
                ],))
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: deleteButton(text: "Delete Learner",function: deleteLearnerFromDB(),),)
        ],
      ),
    );
  }
}
