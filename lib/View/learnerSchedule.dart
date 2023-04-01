import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/Learner.dart';
import 'package:fyp_application/View/Components/taskComponent.dart';
import 'package:fyp_application/View/learnerProfile.dart';
import 'package:fyp_application/View/signUpCaregiver.dart';
import 'package:fyp_application/api/firebase_api.dart';

import '../Model/Task.dart';

class learnerSchedule extends StatefulWidget {
  const learnerSchedule({super.key});

  @override
  State<learnerSchedule> createState() => _learnerScheduleState();
}

class _learnerScheduleState extends State<learnerSchedule> {
  List<Task> tasks = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tasks;
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(),
            ),
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            automaticallyImplyLeading: false,
            leadingWidth: 100,
            title: Align(
              child: Text(
                "My Schedule",
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 62, 81, 140),
                  fontFamily: "DMSans-Bold",
                ),
              ),
              alignment: Alignment.topLeft,
            ),
            leading: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Color.fromARGB(255, 255, 255, 255),
              ),
              icon: Icon(Icons.arrow_back_ios_new,
                  color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () => Navigator.of(context).pop(),
              label: const Text(
                "Go Back",
                style: TextStyle(color: Colors.black),
              ),
            )),
        body: FutureBuilder<Learner>(
          future: FirebaseApi.getCurrentLearner(currentUser),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder<List<Task>>(
                  future: FirebaseApi.getAllTasks2(
                      snapshot.data!.user_id, DateTime.now()),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      print(snapshot.data![0].name);
                      tasks = snapshot.data!;
                      // setState(() {
                      //   tasks = snapshot.data!;
                      // });
                      print("hello");
                      return ListView.builder(
                          itemCount: tasks.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            final doc = tasks[index];
                            print(doc.name);
                            return taskComponent(
                              task: doc,
                            );
                          }));
                    } else {
                      return Center(
                          child: Container(
                        child: Text(
                          "You have no tasks assigned yet!",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ));
                    }
                  });
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
        ));

    // Column(children: [taskComponent(), taskComponent()]));
  }
}
