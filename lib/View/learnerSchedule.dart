import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/taskComponent.dart';

class learnerSchedule extends StatefulWidget {
  const learnerSchedule({super.key});

  @override
  State<learnerSchedule> createState() => _learnerScheduleState();
}

class _learnerScheduleState extends State<learnerSchedule> {
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
                "Today's Schedule",
                style: TextStyle(
                  fontSize: 27,
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
              icon: Icon(Icons.arrow_back_ios_new, color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () => Navigator.of(context).pop(),
              label: const Text(
                "Go Back",
                style: TextStyle(color: Colors.black),
              ),
            )),
        body: Column(children: [taskComponent(), taskComponent()]));

    // Column(children:[
    // tasks.forEach((task)=>{
    //   taskComponent(task: task)
    // }))]);
  }
}
