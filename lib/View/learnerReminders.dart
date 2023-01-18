import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/reminderContainer.dart';

import '../Model/Learner.dart';
import '../Model/Reminder.dart';
import '../api/firebase_api.dart';
import 'learnerProfile.dart';

class learnerReminders extends StatefulWidget {
  const learnerReminders({super.key});

  @override
  State<learnerReminders> createState() => _learnerRemindersState();
}

class _learnerRemindersState extends State<learnerReminders> {
  late int total = 0;

  late List<Reminder> reminders;
  @override
  void setState(VoidCallback fn) {
    reminders;
    total;
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
              padding:
                  EdgeInsets.only(top: 30, bottom: 25, left: 18, right: 10),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Text(
                        "Daily Reminders:",
                        style: TextStyle(
                            fontFamily: "Fredoka-Medium",
                            fontSize: 27,
                            fontWeight: FontWeight.w600),
                      )),
                  Stack(alignment: Alignment.topRight, children: <Widget>[
                    Image.asset(
                      "lib/assets/reminderBell.png",
                      width: 75,
                      height: 75,
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 234, 126, 208),
                              shape: BoxShape.circle,
                            ),
                            child: FutureBuilder<Learner>(
                                future:
                                    FirebaseApi.getCurrentLearner(currentUser),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return FutureBuilder<List<Reminder>>(
                                      future: FirebaseApi.getAllReminders(
                                          snapshot.data!.user_id),
                                      builder: (context, snapshot) {
                                        // if (snapshot.hasData) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            return Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  snapshot.data!.length
                                                      .toString(),
                                                  // child: Text(reminders.size().toString(),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "FredokaOne-Regular",
                                                      fontSize: 27)),
                                            );
                                          } else {
                                            return Container(
                                                );
                                          }
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                              margin: EdgeInsets.all(15),
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()));
                                        } else {
                                          return Container(
                                              );
                                        }
                                      },
                                    );
                                  }else {
                                return Container(
                                    child: Center(
                                  child: Text("?",style: TextStyle(
                                    color: Colors.black,
                                                      fontFamily:
                                                          "FredokaOne-Regular",
                                                      fontSize: 25)),
                                ));
                              }
                                })))
                  ])
                ],
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 10, left: 18, right: 18),
              child: Column(
                children: [
                  Image.asset("lib/assets/wire.png", width: 330),
                  SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                            color: Color.fromARGB(255, 240, 240, 240),
                          ),
                          width: 330,
                          height: 450,
                          child: FutureBuilder<Learner>(
                            future: FirebaseApi.getCurrentLearner(currentUser),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return FutureBuilder<List<Reminder>>(
                                  future: FirebaseApi.getAllReminders(
                                      snapshot.data!.user_id),
                                  builder: (context, snapshot) {
                                    // if (snapshot.hasData) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        print("okayyyy: ");
                                        print(snapshot.data!);
                                        reminders = snapshot.data!;
                                        total = snapshot.data!.length;
                                        // setState(() {
                                        //   total = snapshot.data!.length;
                                        // });
                                        // print(skills);
                                        return ListView.builder(
                                            itemCount: reminders.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: ((context, index) {
                                              final doc = reminders[index];
                                              print(doc.name);
                                              return reminderContainer(
                                                reminder: doc,
                                              );
                                            }));
                                      } else {
                                        return Container(
                                            margin: EdgeInsets.all(20),
                                            child: Center(
                                              child: Text(
                                                "No reminders assigned for you today!",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              ),
                                            ));
                                      }
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                          margin: EdgeInsets.all(15),
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()));
                                    } else {
                                      return Container(
                                          margin: EdgeInsets.all(20),
                                          child: Center(
                                            child: Text(
                                              "No reminders assigned...",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                          ));
                                    }
                                  },
                                );
                              } else {
                                return Container(
                                    child: Center(
                                  child: Image.asset(
                                    "lib/assets/noData.png",
                                    width: 50,
                                    height: 55,
                                  ),
                                ));
                              }
                            },
                          )))
                ],
              ))
        ],
      ),
    );
  }
}
