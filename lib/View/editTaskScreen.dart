import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../Model/Task.dart';
import '../api/firebase_api.dart';
import 'Components/buttonImageComp.dart';

class editTaskScreen extends StatefulWidget {
  final Task task;
  const editTaskScreen({super.key, required this.task});

  @override
  State<editTaskScreen> createState() => _editTaskScreenState();
}

final taskTitleController = TextEditingController();
final taskDescriptionController = TextEditingController();
final dateController = TextEditingController();
final startTimeController = TextEditingController();
final endTimeController = TextEditingController();
final taskReminderController = TextEditingController();
final taskRewardsController = TextEditingController();

class _editTaskScreenState extends State<editTaskScreen> {
  final picker = ImagePicker();
  File? _video;
  bool vid = false;
  late VideoPlayerController _controller;
  int selectRewards = 5;
  videoChooser() async {
    // ignore: deprecated_member_use
    final video = await picker.getVideo(source: ImageSource.gallery);
    // _video = File(widget.task.video);
    _video = File(video!.path);
    _controller = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {});
        // _controller.play();
      });
  }

  DateTime? dateNow = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String endTime = "09:30 PM";
  int selectReminder = 0;
  List<int> reminderList = [
    5,
    10,
    15,
    20,
    25,
    30,
  ];

  @override
  Widget build(BuildContext context) {
    showCalendar() async {
      DateTime? pickDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime(2200));
      if (DateFormat.yMd().format(pickDate!) ==
          DateFormat.yMd().format(DateTime.now())) {
        pickDate = DateTime.now().add(const Duration(days: 1));
        setState(() {
          dateNow = pickDate;
        });
      } else if (pickDate != null) {
        setState(() {
          dateNow = pickDate;
        });
      } else if (pickDate == null) {
        pickDate = dateNow;
      }
    }

    showTime() {
      return showTimePicker(
          initialEntryMode: TimePickerEntryMode.input,
          context: context,
          initialTime: TimeOfDay(
              hour: int.parse(startTime.split(":")[0]),
              minute: int.parse(startTime.split(":")[1].split(" ")[0])));
    }

    getTime({required bool isStartTime}) async {
      //WORK ON THIS

      var pickedTime = await showTime();
      String formattedTime = pickedTime!.format(context);
      if (pickedTime == null) {
        print("Time not selected");
      } else if (isStartTime == true) {
        setState(() {
          startTime = formattedTime;
        });
      } else if (isStartTime == false) {
        setState(() {
          endTime = formattedTime;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(),
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Update Task",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 66, 135, 123),
                fontFamily: "Cabin-Regular",
              ),
            ),
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
              "",
              style: TextStyle(color: Colors.black),
            ),
          )),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Task Title",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cabin-Regular",
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 52,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      onChanged: (value) {
                        //save value of original tasks info in global
                        //variables
                      },
                      autofocus: false,
                      cursorColor: Color.fromARGB(255, 66, 135, 123),
                      controller: taskTitleController,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Cabin-Regular",
                          fontSize: 16),
                      decoration: InputDecoration(
                          hintText: widget.task.name,
                          contentPadding: EdgeInsets.only(left: 10),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Task Description",
                  style: TextStyle(
                      fontFamily: "Cabin-Regular",
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 52,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      onChanged: (value) {
                        //save value of original tasks info in global
                        //variables
                      },
                      autofocus: false,
                      cursorColor: Color.fromARGB(255, 66, 135, 123),
                      controller: taskDescriptionController,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Cabin-Regular",
                          fontSize: 16),
                      decoration: InputDecoration(
                          hintText: widget.task.description,
                          contentPadding: EdgeInsets.only(left: 10),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Date",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cabin-Regular",
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 52,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          //save value of original tasks info in global
                          //variables
                        },
                        readOnly: true,
                        autofocus: false,
                        cursorColor: Color.fromARGB(255, 66, 135, 123),
                        controller: dateController,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Cabin-Regular",
                            fontSize: 16),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: DateFormat.yMd()
                                .format(dateNow!), //date of tasks info date
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          color: Color.fromARGB(255, 66, 135, 123),
                        ),
                        onPressed: () {
                          showCalendar();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Start Time",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cabin-Regular",
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          height: 52,
                          width: 160,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    //save value of original tasks info in global
                                    //variables
                                  },
                                  readOnly: true,
                                  autofocus: false,
                                  cursorColor:
                                      Color.fromARGB(255, 66, 135, 123),
                                  controller: startTimeController,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Cabin-Regular",
                                      fontSize: 16),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      hintText: startTime, //task's start time
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.access_time_rounded,
                                    color: Color.fromARGB(255, 66, 135, 123),
                                  ),
                                  onPressed: () {
                                    getTime(isStartTime: true);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                  SizedBox(width: 30),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "End Time",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cabin-Regular",
                                fontSize: 17,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          height: 52,
                          width: 160,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onChanged: (value) {
                                    //save value of original tasks info in global
                                    //variables
                                  },
                                  readOnly: true,
                                  autofocus: false,
                                  cursorColor:
                                      Color.fromARGB(255, 66, 135, 123),
                                  controller: endTimeController,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Cabin-Regular",
                                      fontSize: 16),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      hintText: endTime, //task's end time
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.access_time_rounded,
                                    color: Color.fromARGB(255, 66, 135, 123),
                                  ),
                                  onPressed: () {
                                    getTime(isStartTime: false);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Remind Task",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cabin-Regular",
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 52,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      onChanged: (value) {
                        //save value of original tasks info in global
                        //variables
                      },
                      readOnly: true,
                      autofocus: false,
                      cursorColor: Color.fromARGB(255, 66, 135, 123),
                      controller: taskReminderController,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Cabin-Regular",
                          fontSize: 16),
                      decoration: InputDecoration(
                          hintText:
                              "$selectReminder minutes early.", //tasks reminder
                          contentPadding: EdgeInsets.only(left: 10),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    )),
                    DropdownButton(
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Color.fromARGB(255, 66, 135, 123)),
                      iconSize: 32,
                      elevation: 4,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectReminder = int.parse(newValue!);
                        });
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Cabin-Regular"),
                      underline: Container(
                        height: 0,
                      ),
                      items: reminderList
                          .map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()));
                      }).toList(),
                    ),
                  ],
                ),
              ),

             Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Reward points",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Cabin-Regular",
                          fontSize: 17,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    height: 52,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          readOnly: true,
                          autofocus: false,
                          cursorColor: Color.fromARGB(255, 66, 135, 123),
                          controller: taskRewardsController,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Cabin-Regular",
                              fontSize: 16),
                          decoration: InputDecoration(
                              hintText: selectRewards.toString(),
                              contentPadding: EdgeInsets.only(left: 10),
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        )),
                        DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Color.fromARGB(255, 66, 135, 123)),
                          iconSize: 32,
                          elevation: 4,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectRewards = int.parse(newValue!);
                            });
                          },
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Cabin-Regular"),
                          underline: Container(
                            height: 0,
                          ),
                          items: reminderList
                              .map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value.toString()));
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

              Container(
                  margin:
                      EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(stops: [
                      0.02,
                      0.10
                    ], colors: [
                      Color.fromARGB(255, 251, 249, 249),
                      Color.fromARGB(255, 251, 249, 249)
                    ]),
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 126, 126, 126).withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Re-upload video of task",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Cabin-Regular",
                              fontSize: 18),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                videoChooser();
                                print(_video);
                              },
                              child: Container(
                                  width: 200,
                                  height: 100,
                                  child: _video != null
                                      ? AspectRatio(
                                          aspectRatio: 3 / 2,
                                          child: VideoPlayer(_controller),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(left: 40),
                                          width: 200,
                                          height: 100,
                                          child: Image.asset(
                                            "lib/assets/uploadVid.webp",
                                            width: 75,
                                            height: 75,
                                          ),
                                        ))),
                        ],
                      ),
                    ],
                  )),
              GestureDetector(
                  onTap: () {
                    if (true) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "Task Updated!",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                content: Image.asset(
                                  'lib/assets/check.png',
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 60,
                                ),
                                actions: [
                                  TextButton(
                                      child: Text("Okay"),
                                      onPressed: () => Navigator.pop(context))
                                  // Navigator.pop(context)),
                                ],
                              ));
                    }
                  },

                  child: Container(
                    child: buttonImage(
                        text: "Update Task",
                        function: () {
                          try {
                            FirebaseApi.updateTask(
                                widget.task.task_id,
                                taskTitleController.text,
                                taskDescriptionController.text,
                                DateFormat.yMd().format(dateNow!),
                                startTime,
                                endTime,
                                selectReminder,
                                selectRewards,
                                _video.toString());
                            if (true) {
                              taskTitleController.clear();
                              taskDescriptionController.clear();
                              dateController.clear();
                              startTimeController.clear();
                              endTimeController.clear();
                              taskReminderController.clear();

                              Navigator.of(context).pop();
                            }
                          } catch (error) {
                            final snackBarC = SnackBar(
                                content: Text(
                                    "An internal issue has occured! Please try again later."));
                          }
                        }, //update task to db
                        color: Color.fromARGB(255, 66, 135, 123)),
                    alignment: Alignment.topCenter,
                  )
                  // buttonImage(text: "Add Task", function: addTaskToDB(), color: Color.fromARGB(255, 66, 135, 123)),

                  // Container(
                  //   margin:
                  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  //   width: double.infinity,
                  //   height: 30,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Color.fromARGB(255, 66, 135, 123)),
                  //   child: Text(
                  //     "Add Task",
                  //     style: TextStyle(
                  //         color: Color.fromARGB(255, 255, 255, 255),
                  //         fontFamily: "Cabin-Regular",
                  //         fontSize: 16),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
