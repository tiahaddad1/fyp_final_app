import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/SubtaskOne.dart';
import 'package:fyp_application/Model/SubtaskTwo.dart';
import 'package:fyp_application/Provider/learner.dart';
import 'package:fyp_application/View/Components/addSubtaskComp.dart';
import 'package:fyp_application/View/Components/buttonImageComp.dart';
import 'package:fyp_application/View/caregiverViewSchedule.dart';
import 'package:fyp_application/api/firebase_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../Model/Learner.dart';
import '../Model/Subtask.dart';
import '../Model/Task.dart' as t;

class addTaskScreen extends StatefulWidget {
  final learner_id;
  final subtasks; //List<Subtask>
  const addTaskScreen({super.key, this.subtasks, this.learner_id});

  @override
  State<addTaskScreen> createState() => _addTaskScreenState();
}

final taskTitleController = TextEditingController();
final taskDescriptionController = TextEditingController();
final dateController = TextEditingController();
final startTimeController = TextEditingController();
final endTimeController = TextEditingController();
final taskReminderController = TextEditingController();
final taskRewardsController = TextEditingController();

class _addTaskScreenState extends State<addTaskScreen> {
  // @override
  // void initstate() {
  //   taskTitleController.clear();
  //   taskDescriptionController.clear();
  //   dateController.clear();
  //   startTimeController.clear();
  //   endTimeController.clear();
  //   taskReminderController.clear();
  //   taskRewardsController.clear();
  //   // ignore: avoid_print
  //   print('clear used');
  // }

  // @override
  // saveToLocalStorage() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   await prefs.setString('current_learner', widget.learner_id);
  // }

  // Future<String?> readFromLocalStorage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final learner = prefs.getString('current_learner');
  //   return learner;
  // }

  final picker = ImagePicker();
  bool vid = false;
  late VideoPlayerController _controller;
  String? urlDownload;
  String? _video;
  // late File _video = File("");
  videoChooser() async {
    // ignore: deprecated_member_use
    final video = await picker.getVideo(source: ImageSource.gallery);
    // _video = File(video!.path);
    _video = video!.path;
    _controller = VideoPlayerController.file(File(_video!))
      ..initialize().then((_) async {
        final path = "taskVideos/${taskTitleController.text}";
        final ref = FirebaseStorage.instance.ref().child(path);
        final uploadFile = await ref.putFile(File(_video!));
        urlDownload = (await uploadFile.ref.getDownloadURL());
        _video = urlDownload;
        print("OMGG");
        print(urlDownload);
        setState(() {
          // _video = File(video.path);
          _video = urlDownload;
        });
        // _controller.play();
      });
  }

  DateTime? dateNow = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String endTime = "09:30 PM";
  int selectReminder = 5;
  int selectRewards = 5;
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
    setState(() {
      _video;
    });
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
                "New Task",
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
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 10),
                        child: Icon(
                          Icons.add_box_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 17,
                        )),
                    RichText(
                        text: TextSpan(
                            text: "Add subtasks",
                            style: TextStyle(
                                color: Color.fromARGB(255, 62, 81, 140),
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                                fontFamily: "Cabin-Regular"),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => addSubtask()))
                                  })),
                  ]),
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
                          autofocus: false,
                          cursorColor: Color.fromARGB(255, 66, 135, 123),
                          controller: taskTitleController,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Cabin-Regular",
                              fontSize: 16),
                          decoration: InputDecoration(
                              hintText: "Enter task title",
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
                          autofocus: false,
                          cursorColor: Color.fromARGB(255, 66, 135, 123),
                          controller: taskDescriptionController,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Cabin-Regular",
                              fontSize: 16),
                          decoration: InputDecoration(
                              hintText: "Enter task description",
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
                                hintText: DateFormat.yMd().format(dateNow!),
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
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
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
                                          contentPadding:
                                              EdgeInsets.only(left: 10),
                                          hintText: startTime,
                                          focusedBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.access_time_rounded,
                                        color:
                                            Color.fromARGB(255, 66, 135, 123),
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
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
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
                                          contentPadding:
                                              EdgeInsets.only(left: 10),
                                          hintText: endTime,
                                          focusedBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.access_time_rounded,
                                        color:
                                            Color.fromARGB(255, 66, 135, 123),
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
                          readOnly: true,
                          autofocus: false,
                          cursorColor: Color.fromARGB(255, 66, 135, 123),
                          controller: taskReminderController,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Cabin-Regular",
                              fontSize: 16),
                          decoration: InputDecoration(
                              hintText: "$selectReminder minutes early.",
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
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 20, top: 20),
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
                            color: Color.fromARGB(255, 126, 126, 126)
                                .withOpacity(0.1),
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
                              "Upload video of task",
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
                                  onTap: () async {
                                    await Future.wait(videoChooser());
                                    print("pleaseeeeee");
                                    print(_video);
                                    // setState(
                                    //   () {
                                    //     _video = _video;
                                    //   },
                                    // );
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
                                              padding:
                                                  EdgeInsets.only(left: 40),
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
                  // GestureDetector(onTap: () {
                  // if (taskTitleController.text.isEmpty ||
                  //     taskDescriptionController.text.isEmpty ||
                  //     dateController.text.isEmpty ||
                  //     startTimeController.text.isEmpty  ||
                  //     endTimeController.text.isEmpty ||
                  //     _video == null) {
                  //   showDialog(
                  //       context: context,
                  //       builder: (context) => AlertDialog(
                  //             title: Text(
                  //               "Please ensure all fields are inserted!",
                  //               style: TextStyle(
                  //                   color: Color.fromARGB(255, 0, 0, 0),
                  //                   fontWeight: FontWeight.w600,fontSize: 20),
                  //             ),
                  //             content: Image.asset(
                  //               'lib/assets/issue.png',
                  //               alignment: Alignment.center,
                  //               height: 60,
                  //               width: 60,
                  //             ),
                  //             actions: [
                  //               TextButton(
                  //                   child: Text("Okay"),
                  //                   onPressed: () => Navigator.pop(context)),
                  //             ],
                  //           ));
                  // } else {
                  //   if (true) {
                  //     if (newSubTask == false) {
                  //       showDialog(
                  //           context: context,
                  //           builder: (context) => AlertDialog(
                  //                 title: Text(
                  //                   "No Subtask?",
                  //                   style: TextStyle(
                  //                       color: Color.fromARGB(255, 0, 0, 0),
                  //                       fontWeight: FontWeight.w600,fontSize: 20),
                  //                 ),
                  //                 content: Image.asset(
                  //                   'lib/assets/check-list.png',
                  //                   alignment: Alignment.center,
                  //                   height: 60,
                  //                   width: 60,
                  //                 ),
                  //                 actions: [
                  //                   Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                       children: [
                  //                         TextButton(
                  //                           child: Text("Nope!"),
                  //                           onPressed: () => showDialog(
                  //                               context: context,
                  //                               builder: (context) =>
                  //                                   AlertDialog(
                  //                                     title: Text(
                  //                                       "Task Created!",
                  //                                       style: TextStyle(
                  //                                           color: Color
                  //                                               .fromARGB(255,
                  //                                                   0, 0, 0),
                  //                                           fontWeight:
                  //                                               FontWeight
                  //                                                   .w600,fontSize: 20),
                  //                                     ),
                  //                                     content: Image.asset(
                  //                                       'lib/assets/check.png',
                  //                                       alignment:
                  //                                           Alignment.center,
                  //                                       height: 60,
                  //                                       width: 60,
                  //                                     ),
                  //                                     actions: [
                  //                                       TextButton(
                  //                                           child:
                  //                                               Text("Okay"),
                  //                                           onPressed: () =>
                  //                                               Navigator.of(
                  //                                                       context)
                  //                                                   .pop()),
                  //                                     ],
                  //                                   )),
                  //                         ),
                  //                         TextButton(
                  //                             child: Text("Oops, I forgot!"),
                  //                             onPressed: () => Navigator.push(
                  //                                 context,
                  //                                 MaterialPageRoute(
                  //                                     builder: (context) =>
                  //                                         addSubtask())))
                  //                       ])
                  //                 ],
                  //               ));
                  //     } else {
                  //       showDialog(
                  //           context: context,
                  //           builder: (context) => AlertDialog(
                  //                 title: Text(
                  //                   "Task Created!",
                  //                   style: TextStyle(
                  //                       color: Color.fromARGB(255, 0, 0, 0),
                  //                       fontWeight: FontWeight.w600,fontSize: 20),
                  //                 ),
                  //                 content: Image.asset(
                  //                   'lib/assets/check.png',
                  //                   alignment: Alignment.center,
                  //                   height: 60,
                  //                   width: 60,
                  //                 ),
                  //                 actions: [
                  //                   TextButton(
                  //                       child: Text("Okay"),
                  //                       onPressed: () =>
                  //                           Navigator.pop(context))
                  //                   // Navigator.pop(context)),
                  //                 ],
                  //               ));
                  //     }
                  // }
                  // }
                  // },
                  // child:
                  Container(
                      child: FutureBuilder(
                          future: LearnerProvider.readFromLocalStorage(),
                          builder: (context, snapshot) {
                            return buttonImage(
                                text: "Add Task",
                                // function: ()=>GestureDetector(onTap:() { addTaskDetails(taskTitleController,taskDescriptionController,dateController,startTimeController,endTimeController,taskReminderController,context,_video);}),
                                function: () {
                                  print("LOOK HERE: " + _video!.toString());
                                  print(taskTitleController.text);
                                  print(taskDescriptionController.text);
                                  print(DateFormat.yMd().format(dateNow!));
                                  print(startTime);
                                  print(endTime);
                                  print(selectReminder.toString());
                                  print(selectRewards.toString());
                                  print(newSubTask == true
                                      ? widget.subtasks
                                      : []);
                                  print(_video);
                                  print(snapshot.data);

                                  addTaskDetails(
                                      taskTitleController,
                                      taskDescriptionController,
                                      DateFormat.yMd().format(dateNow!),
                                      startTime,
                                      endTime,
                                      selectReminder.toString(),
                                      selectRewards.toString(),
                                      newSubTask == true ? widget.subtasks : [],
                                      context,
                                      snapshot.data == null
                                          ? "no learner"
                                          : snapshot.data!,
                                      _video!);
                                  print("problem1");
                                },
                                color: Color.fromARGB(255, 66, 135, 123));

                            // buttonImage(
                            //     text: "Add Task",
                            //     // function: ()=>GestureDetector(onTap:() { addTaskDetails(taskTitleController,taskDescriptionController,dateController,startTimeController,endTimeController,taskReminderController,context,_video);}),
                            //     function: () {
                            //       print("LOOK HERE: " + _video!.toString());
                            //       print(taskTitleController.text);
                            //       print(taskDescriptionController.text);
                            //       print(DateFormat.yMd().format(dateNow!));
                            //       print(startTime);
                            //       print(endTime);
                            //       print(selectReminder.toString());
                            //       print(selectRewards.toString());
                            //       print(newSubTask == true ? widget.subtasks : []);
                            //       print(_video);
                            //       print(widget.learner_id);

                            //       addTaskDetails(
                            //           taskTitleController,
                            //           taskDescriptionController,
                            //           DateFormat.yMd().format(dateNow!),
                            //           startTime,
                            //           endTime,
                            //           selectReminder.toString(),
                            //           selectRewards.toString(),
                            //           newSubTask == true ? widget.subtasks : [],
                            //           context,
                            //           widget.learner_id==null?readFromLocalStorage():widget.learner_id,
                            //           _video!);
                            //       print("problem1");
                            //     },
                            //     color: Color.fromARGB(255, 66, 135, 123)),
                          }),
                      alignment: Alignment.topCenter)
                ]))));
    // buttonImage(text: "Add Task", function: addTaskToDB(), color: Color.fromARGB(255, 66, 135, 123)),
    // ),
  }
}

addTaskDetails(
  TextEditingController taskTitleController,
  TextEditingController taskDescriptionController,
  String dateController,
  String startTimeController,
  String endTimeController,
  String taskReminderController,
  String taskRewardsController,
  List<Subtask>? subtaskss,
  BuildContext context,
  String learner_id,
  String? _video,
) {
  print("TIA LOOK HERE");
  print(_video);
  // print("Video: " + _video!.path);
  //add task details to database and create new task
  if (taskTitleController.text.isEmpty ||
      taskDescriptionController.text.isEmpty ||
      dateController.isEmpty ||
      startTimeController.isEmpty ||
      endTimeController.isEmpty ||
      taskReminderController.isEmpty ||
      taskRewardsController.isEmpty ||
      // _video.toString() == ""||
      _video == null) {
    print(taskTitleController.text);
    print(taskDescriptionController.text);
    print(dateController);
    print(startTimeController);
    print(endTimeController);
    print(taskReminderController);
    print(taskRewardsController);
    print(_video);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Please ensure that all fields are inserted!",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              content: Image.asset(
                'lib/assets/issue.png',
                alignment: Alignment.center,
                height: 60,
                width: 60,
              ),
              actions: [
                TextButton(
                    child: Text("Okay"),
                    onPressed: () => Navigator.pop(context)),
              ],
            ));
  } else {
    if (true) {
      if (subtaskss!.length == 0) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "No Subtasks?",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  content: Image.asset(
                    'lib/assets/noSubtasks.png',
                    alignment: Alignment.center,
                    height: 60,
                    width: 60,
                  ),
                  actions: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                                t.Task newTask = t.Task(
                                    task_id: "",
                                    name: taskTitleController.text,
                                    description: taskDescriptionController.text,
                                    date: dateController,
                                    start_time: startTimeController,
                                    rewards: int.parse(taskRewardsController),
                                    end_time: endTimeController,
                                    reminder: int.parse(taskReminderController),
                                    video: _video,
                                    subtasks: [
                                      "",
                                      ""
                                    ]); //creates the subtask object as well
                                try {
                                  // Navigator.pop(context);
                                  print("here-1");
                                  FirebaseApi.addTaskAndSubtasks(
                                      newTask, subtaskss, learner_id);
                                  if (true) {
                                    taskTitleController.clear();
                                    taskDescriptionController.clear();
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text(
                                                "Task Created!",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
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
                                                    onPressed: () =>
                                                        Navigator.pop(context))
                                                // Navigator.pop(context)),
                                              ],
                                            ));
                                  }
                                } catch (Exception) {
                                  Navigator.pop(context);
                                  print("here-2");
                                  final snackBarC = SnackBar(
                                      content: Text(
                                          "An internal issue has occured! Please try again later."),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {},
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBarC);
                                }

                                //db stuff here call method for task and subtask
                              }),
                          TextButton(
                              child: Text("Add subtasks"),
                              onPressed: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                addSubtask())),
                                    // Navigator.pop(context)
                                  })
                        ])
                  ],
                ));
      } else {
        Navigator.pop(context);
        print("im hereeeee");
        t.Task newTask = t.Task(
            task_id: "",
            name: taskTitleController.text,
            description: taskDescriptionController.text,
            date: dateController,
            start_time: startTimeController,
            rewards: int.parse(taskRewardsController),
            end_time: endTimeController,
            reminder: int.parse(taskReminderController),
            video: _video,
            // video:urlDownload,
            subtasks: ["", ""]); //creates the subtask object as well
        try {
          print(subtaskss.isEmpty);
          FirebaseApi.addTaskAndSubtasks(newTask, subtaskss, learner_id);
          if (true) {
            taskTitleController.clear();
            taskDescriptionController.clear();
            // if (true) {
            subtask1TitleController.clear();
            subtask2TitleController.clear();
            subtaskStartTimeController.clear();
            subtask1RewardController.clear();
            subtask2RewardController.clear();
            subtaskDurationController.clear();
            // }
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(
                        "Task Created!",
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
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              MaterialPageRoute(
                                  builder: (context) => caregiverSchedule());
                            })
                      ],
                    ));
          }
        } catch (Exception) {
          print("mayveeeee");
          final snackBarC = SnackBar(
              content: Text(
                  "An internal issue has occured! Please try again later."),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {},
              ));
          ScaffoldMessenger.of(context).showSnackBar(snackBarC);
        }

        //db stuff here call method for task and subtask

      }
    }
  }
}
