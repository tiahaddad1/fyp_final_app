import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'caregiverViewSchedule.dart';

class editSubtaskScreen extends StatefulWidget {
  const editSubtaskScreen({super.key});

  @override
  State<editSubtaskScreen> createState() => _editSubtaskScreenState();
}

final subtask1TitleController = TextEditingController();
final subtaskStartTimeController = TextEditingController();
final subtask1RewardController = TextEditingController();
final subtaskDurationController = TextEditingController();

final subtask2TitleController = TextEditingController();
final subtask2RewardController = TextEditingController();

bool newSubTask = false;
String endTime = "09:30 PM";
DateTime? dateNow = DateTime.now();

class _editSubtaskScreenState extends State<editSubtaskScreen> {
  File? image;
  File? image2;
  bool tapped = false;
  Image imagePath =
      Image(image: AssetImage("lib/assets/photo.png"), width: 70, height: 80);
  bool tapped2 = false;
  Image imagePath2 =
      Image(image: AssetImage("lib/assets/photo.png"), width: 70, height: 80);

  Future capture() async {
    try {
      // ignore: deprecated_member_use
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp); //was imageTemp

      // final MediaSource s = ModalRoute.of(context).media;
      // if (media == null) {
      //   return;
      // } else {
      //   fileMedia = media;
      // }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future capture2() async {
    try {
      // ignore: deprecated_member_use
      final image2 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image2 == null) return;

      final imageTemp2 = File(image2.path);
      setState(() => this.image2 = imageTemp2); //was imageTemp

      // final MediaSource s = ModalRoute.of(context).media;
      // if (media == null) {
      //   return;
      // } else {
      //   fileMedia = media;
      // }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  // String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String endTime = "09:30 PM";

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

  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 239, 239),
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(),
            ),
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            automaticallyImplyLeading: false,
            leadingWidth: 100,
            title: Align(
              child: Text(
                "Update subtasks' details",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 45, 119, 223),
                  fontFamily: "Cabin-Regular",
                ),
              ),
              alignment: Alignment.center,
            ),
            leading: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 255, 255), elevation: 0.0),
              icon: Icon(Icons.arrow_back_ios_new,
                  color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () => Navigator.of(context).pop(),
              label: const Text(
                "",
                style: TextStyle(color: Colors.black),
              ),
            )),
        body: SingleChildScrollView(
          child: Column(children: [
            subtaskCont(
                "One",
                subtask1TitleController,
                subtaskStartTimeController,
                subtaskDurationController,
                subtask1RewardController,
                tapped,
                capture,
                image,
                imagePath),
            subtaskCont(
                "Two",
                subtask2TitleController,
                subtaskStartTimeController,
                subtaskDurationController,
                subtask2RewardController,
                tapped2,
                capture2,
                image2,
                imagePath2),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    addSubtasksToDB();
                    return AlertDialog(
                      title: Text(
                        "Subtask Updated!",
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
                            onPressed: () => Navigator.pop(context)),
                      ],
                    );
                  },
                );
                if (true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => caregiverSchedule()));
                }
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 45, 119, 223)),
                child: Text(
                  "Update Subtasks",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: "Cabin-Regular",
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
        ));
  }

  Widget subtaskCont(
      String subtaskNo,
      TextEditingController subtaskTitleController,
      TextEditingController subtaskStartTimeController,
      TextEditingController subtaskDurationController,
      TextEditingController subtaskRewardController,
      bool tapped,
      Future capture(),
      File? image,
      Image imagePath) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
        padding: EdgeInsets.all(10),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(stops: [
            0.02,
            0.10
          ], colors: [
            Color.fromARGB(255, 251, 249, 249),
            Color.fromARGB(255, 251, 249, 249)
          ]),
          borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 126, 126, 126).withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 465,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text("Subtask " + subtaskNo + " Title:",
                          style: TextStyle(
                              fontFamily: "Cabin-Regular",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Start time:",
                          style: TextStyle(
                              fontFamily: "Cabin-Regular",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("Duration:",
                            style: TextStyle(
                                fontFamily: "Cabin-Regular",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black))),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                          "Reward:",
                          style: TextStyle(
                              fontFamily: "Cabin-Regular",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )),
                  ])),
              SizedBox(width: 20),
              SizedBox(
                width: 180,
                child: Column(children: [
                  TextFormField(
                      autofocus: false,
                      cursorColor: Color.fromARGB(255, 45, 119, 223),
                      controller: subtaskTitleController,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Cabin-Regular",
                          fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "title here", ////shows argumet's title
                        contentPadding: EdgeInsets.only(left: 20),
                      )),
                  SizedBox(
                      width: double.infinity,
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            autofocus: false,
                            cursorColor: Color.fromARGB(255, 45, 119, 223),
                            controller: subtaskStartTimeController,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Cabin-Regular",
                                fontSize: 14),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText:
                                    startTime, //shows argumet's start time
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Color.fromARGB(255, 45, 119, 223),
                            ),
                            onPressed: () {
                              getTime(isStartTime: true);
                            },
                          ),
                        )
                      ])),
                  SizedBox(
                    width: double.infinity,
                    child: Expanded(
                      child: TextFormField(
                        readOnly: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autofocus: false,
                        cursorColor: Color.fromARGB(255, 45, 119, 223),
                        controller: subtaskDurationController,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Cabin-Regular",
                            fontSize: 16),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText:
                              "10 minutes", //shows argumet's duration time
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            autofocus: false,
                            cursorColor: Color.fromARGB(255, 45, 119, 223),
                            controller: subtaskRewardController,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Cabin-Regular",
                                fontSize: 16),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              hintText:
                                  "5 stars!", //shows argumet's stars rewards
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Row(children: [
                            Icon(Icons.star, color: Colors.amber),
                            Icon(Icons.star, color: Colors.amber),
                          ]),
                        )
                      ])),
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(stops: [
                  0.02,
                  0.10
                ], colors: [
                  Color.fromARGB(255, 251, 249, 249),
                  Color.fromARGB(255, 251, 249, 249)
                ]),
                borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 45, 119, 223).withOpacity(0.1),
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
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Re-upload image:",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Cabin-Regular',
                          fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(children: [
                            InkWell(
                                onTap: () {
                                  if (tapped == false) {
                                    capture();
                                    tapped = true;
                                  }
                                },
                                child: image != null
                                    ? Image.file(image, width: 280, height: 110)
                                    : imagePath),
                          ]))
                    ],
                  ),
                ],
              )),
        ]));
  }

  Widget timeDetails(String text) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "lib/assets/Cabin-Regular",
                fontSize: 10),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: 42,
          width: double.infinity / 3,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    child: TextFormField(
                      readOnly: true,
                      autofocus: false,
                      cursorColor: Color.fromARGB(255, 66, 135, 123),
                      // controller: startTimeController,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Cabin-Regular",
                          fontSize: 16),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: startTime, //shows argumet's start time
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                    width: 30),
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
      ],
    );
  }

  addSubtasksToDB() {
    //add subtask details to DB
  }
}
