import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/Reminder.dart';
import 'package:fyp_application/View/Components/buttonComponent.dart';
import 'package:fyp_application/View/Components/buttonImageComp.dart';
import 'package:fyp_application/View/Components/caregiverReminderComp.dart';
import 'package:fyp_application/api/firebase_api.dart';

class caregiverReminders extends StatefulWidget {
  final String learner_id;
  const caregiverReminders({super.key, required this.learner_id});

  @override
  State<caregiverReminders> createState() => _caregiverRemindersState();
}

class _caregiverRemindersState extends State<caregiverReminders> {
  // bool clicked = false;
  // List<Widget> containerList = [];
  // returnComp() {
  //   containerList.add(caregiverReminderComp(reminder: "Add new Reminder"));
  // }

  // Widget _getListWidgets(List<Widget> yourList) {
  //   containerList.add(caregiverReminderComp(reminder: "Add new Reminder"));
  //   return Row(children: yourList.map((i) => i).toList());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        toolbarHeight: 50,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(5),
            primary: Color.fromARGB(255, 240, 240, 240),
          ),
          icon: Icon(Icons.arrow_back_ios_new,
              color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () => Navigator.of(context).pop(),
          label: const Text(
            "",
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Text(
                  "Liam" + "'s daily reminders:",
                  style: TextStyle(
                      fontFamily: "Cabin-Regular",
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                child: Image.asset(
                  "lib/assets/pinDetailIcon.png",
                  width: 35,
                  height: 35,
                ),
                padding: EdgeInsets.only(left: 5, right: 5),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  FutureBuilder<List<Reminder>>(
                    future: FirebaseApi.getAllReminders(widget.learner_id),
                    builder: (context, snapshot) {
                      // if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          print("okayyyy: ");
                          print(snapshot.data!);
                          List<Reminder> reminders = snapshot.data!;
                          // print(skills);
                          return ListView.builder(
                              itemCount: reminders.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: ((context, index) {
                                final doc = reminders[index];
                                print(doc.name);
                                return caregiverReminderComp(
                                  reminder: doc,
                                );
                              }));
                        } else {
                          return Container(
                              margin: EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                  "No reminders assigned...",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ));
                        }
                        // print("okayyyy: ");
                        // print(snapshot.data!);
                        // List<Reminder> reminders = snapshot.data!;
                        // // print(skills);
                        // return ListView.builder(
                        //     itemCount: reminders.length,
                        //     shrinkWrap: true,
                        //     scrollDirection: Axis.vertical,
                        //     itemBuilder: ((context, index) {
                        //       final doc = reminders[index];
                        //       print(doc.name);
                        //       return caregiverReminderComp(
                        //         reminder: doc,
                        //        );
                        //     }));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                            margin: EdgeInsets.all(15),
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return Container(
                            margin: EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                "No reminders assigned...",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ));
                      }
                    },
                  )

                  // containerList.map(((e) => e)).toList() -> a map to iterate through array
                  //when pressed add it to array and this array has all the comp from DB too
                  // caregiverReminderComp(),
                  // caregiverReminderComp(reminder: "Pray daily prayers"),
                ])),
          ),
          Container(
              child: buttonImage(
                  image: "lib/assets/bellImage.png",
                  text: "Add Reminder",
                  function: () async {
                    // returnComp();
                    // print(containerList);
                    // setState(
                    //   () {
                    //     clicked = true;
                    //   },
                    // );
                    try {
                      Reminder reminder = Reminder(reminder_id: "", name: "");
                      await FirebaseApi.addReminder(
                          reminder, widget.learner_id);
                      if (true) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                    "Reminder added!",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  content: Image.asset(
                                    'lib/assets/check.png',
                                    alignment: Alignment.center,
                                    height: 55,
                                    width: 55,
                                  ),
                                  actions: [
                                    TextButton(
                                        child: Text("Okay"),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await FirebaseApi.getAllReminders(
                                              widget.learner_id);
                                        })
                                  ],
                                ));
                      }
                    } catch (error) {
                      print(error);
                      final snackBarC = SnackBar(
                          content: Text(
                              "Couldn't create reminder. Please try again later."),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBarC);
                    }
                  },
                  color: Color.fromARGB(255, 66, 135, 123)),
              alignment: Alignment.center),
        ],
      ),
    );
  }
}
