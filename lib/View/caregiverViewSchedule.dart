import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Provider/User-provider.dart';
import 'package:fyp_application/Provider/learner.dart';
import 'package:fyp_application/View/addTaskScreen.dart';
import 'package:intl/intl.dart';

import 'Components/scheduleTaskComp.dart';

class caregiverSchedule extends StatefulWidget {
  final learner_id;
  const caregiverSchedule({super.key, this.learner_id});

  @override
  State<caregiverSchedule> createState() => _caregiverScheduleState();
}

class _caregiverScheduleState extends State<caregiverSchedule> {
  DatePickerController dp = DatePickerController();
  final String date = DateFormat.yMMMMd().format(DateTime.now());
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leadingWidth: 100,
            leading: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: Color.fromARGB(255, 240, 240, 240),
              ),
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
              label: const Text(
                "",
                style: TextStyle(color: Colors.transparent),
              ),
            )),
        body: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            date,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Lato-Regular",
                                color: Color.fromARGB(255, 135, 134, 134)),
                          )),
                      Text("Today",
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: "Lato-Regular",
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
              GestureDetector(
                onTap: () {
                  print("NAT: "+widget.learner_id);
                   LearnerProvider.saveToLocalStorage(widget.learner_id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              addTaskScreen(learner_id: widget.learner_id)));
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: 90,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 66, 135, 123),
                  ),
                  child: Text(
                    "+ Add Task",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontFamily: "Chivo-Regular",
                        fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: DatePicker(DateTime.now(),
                onDateChange: (selectedDate) => _selectedDate = selectedDate,
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                controller: dp,
                selectionColor: Color.fromARGB(255, 66, 135, 123),
                selectedTextColor: Colors.white,
                dateTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey)),
          ),
          SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                scheduleTaskComp(),
                scheduleTaskComp(),
                scheduleTaskComp(),
                scheduleTaskComp()
              ]))
        ]));
  }

  viewAllTasks() {
    //look into video: https://www.youtube.com/watch?v=pQSTgf-6hDk&t=0s&ab_channel=dbestech
    //for all details of viewing tasks
  }
}
