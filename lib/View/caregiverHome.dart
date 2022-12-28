import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/logOutButton.dart';

import 'Components/learnerInfoCard.dart';
import 'learnerSignup.dart';

class caregiverHome extends StatefulWidget {
  const caregiverHome({super.key});

  @override
  State<caregiverHome> createState() => _caregiverHomeState();
}

class _caregiverHomeState extends State<caregiverHome> {
  GestureDetector addNewLearnerComp() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => learnerSignup()));
        //navigates to add new learner screen
      },
      child: Container(
          alignment: Alignment.center,
          height: 70,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(10), ),
            border: Border(
              right: BorderSide(
                  width: 2.0, color: Color.fromARGB(255, 80, 169, 154)),
              bottom: BorderSide(
                  width: 2.0, color: Color.fromARGB(255, 80, 169, 154)),
              left: BorderSide(
                  width: 4.0, color: Color.fromARGB(255, 80, 169, 154)),
            ),
            color: Colors.white,
          ),
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset(
                  "lib/assets/addNewLearner.png",
                  width: 35,
                  height: 35,
                ),
              ),
              Padding(
                child: Text(
                  "Add new learner",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Fredoka-Medium",
                      decoration: TextDecoration.underline,
                      fontSize: 17),
                ),
                padding: EdgeInsets.all(10),
              )
            ],
          )),
    );
  }

  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 251, 251, 251),
        toolbarHeight: 300,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(20),

        //   ),
        // ),
        shape: Border(
            bottom:
                BorderSide(color: Color.fromARGB(255, 66, 135, 123), width: 2)),
        title: Expanded(
            child: Column(
          children: [
            Padding(
              child: Expanded(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  padding: EdgeInsets.only(right: 10),
                  height: 50,
                  // width: double.infinity,
                  child: logOutButton(),
                )
              ])),
              padding: EdgeInsets.only(bottom: 15),
            ),
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
                              child: Text(
                                "Welcome back",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    fontSize: 15,
                                    fontFamily: "Cabin-Regular"),
                                textAlign: TextAlign.left,
                              ),
                              padding: EdgeInsets.only(bottom: 20),
                            ),
                            Container(
                                child: Text(
                              "Dr. Natalia Haddad",
                              style: TextStyle(
                                  fontFamily: "Cabin-Regular",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 66, 135, 123),
                                  fontWeight: FontWeight.w600),
                            ))
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
                                  edit = true;
                                });
                                if (edit == true) {
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
            Stack(alignment: Alignment.topRight, children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 240, 240, 240),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 98, 98, 98).withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 65,
                child: TextField(
                    readOnly: edit == true ? false : true,
                    onChanged: (value) {
                      //save to DB
                    },
                    showCursor: true,
                    cursorColor: Color.fromARGB(255, 66, 135, 123),
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          "A  certified ABA therapist for children on spectrum.",
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                    )),
              ),
              Positioned(
                  bottom: 14,
                  right: 13,
                  child: Container(
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(20)),
                      color: Color.fromARGB(170, 217, 217, 217),
                      shape: BoxShape.rectangle,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          edit = true;
                        });
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
                          padding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
                        ),
                      ),
                    ),
                  )),
            ]),
          ],
        )),
      ),
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 20, bottom: 20, top: 20),
            height: 60,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                  onTap: () {
                    //view info guide here in a pop up
                  },
                  child: Image.asset(
                    "lib/assets/infoIcon.png",
                    height: 30,
                    width: 30,
                  ))
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 25),
            alignment: Alignment.topLeft,
            child: Text(
              "My learners",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Cabin-Regular"),
            ),
          ),
          Expanded(
              child: SafeArea(
                  child: ListView(
            padding: EdgeInsets.only(top: 20),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Center(
                  child: Wrap(
                children: [
                  learnerInfoCard(),
                  learnerInfoCard(),
                  learnerInfoCard(),
                ],
              )),
              addNewLearnerComp()
              //add learner here
            ],
          )))
        ],
      ),
    );
  }
}
