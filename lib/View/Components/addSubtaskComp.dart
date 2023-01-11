import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/SubtaskOne.dart';
import 'package:fyp_application/Model/SubtaskTwo.dart';
import 'package:fyp_application/View/addTaskScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:fyp_application/Model/Subtask.dart';
import 'package:path_provider/path_provider.dart';
import 'buttonImageComp.dart';
import 'package:path/path.dart';

class addSubtask extends StatefulWidget {
  const addSubtask({super.key});

  @override
  State<addSubtask> createState() => _addSubtaskState();
}

final subtask1TitleController = TextEditingController();
final subtaskStartTimeController = TextEditingController();
final subtask1RewardController = TextEditingController();
final subtaskDurationController = TextEditingController();

final subtask2TitleController = TextEditingController();
// final subtask2StartTimeController = TextEditingController();
final subtask2RewardController = TextEditingController();
// final subtask2EndTimeController = TextEditingController();

bool newSubTask = false;
String endTime = "09:30 PM";
DateTime? dateNow = DateTime.now();

class _addSubtaskState extends State<addSubtask> {
  File? image;
  File? image2;
  bool tapped = false;
  Image imagePath =
      Image(image: AssetImage("lib/assets/photo.png"), width: 70, height: 80);
  bool tapped2 = false;
  Image imagePath2 =
      Image(image: AssetImage("lib/assets/photo.png"), width: 70, height: 80);

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  late String urlDownload = "";
  Future capture() async {
    try {
      // ignore: deprecated_member_use
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp); //was imageTemp
      final path = "subtaskImages/${subtask1TitleController.text}";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadFile = await ref.putFile(File(image.path));
      urlDownload = (await uploadFile.ref.getDownloadURL());

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
      final path = "subtaskImages/${subtask2TitleController.text}";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadFile = await ref.putFile(File(image2.path));
      urlDownload = (await uploadFile.ref.getDownloadURL());

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
        context: this.context,
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
        context: this.context,
        initialTime: TimeOfDay(
            hour: int.parse(startTime.split(":")[0]),
            minute: int.parse(startTime.split(":")[1].split(" ")[0])));
  }

  getTime({required bool isStartTime}) async {
    //WORK ON THIS

    var pickedTime = await showTime();
    String formattedTime = pickedTime!.format(this.context);
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
                "Subtasks details",
                style: TextStyle(
                  fontSize: 25,
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
            Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(stops: [
                    0.02,
                    0.10
                  ], colors: [
                    Color.fromARGB(255, 255, 233, 174),
                    Color.fromARGB(255, 255, 233, 174)
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
                height: 65,
                child: Row(
                  children: [
                    Padding(
                        child: Image.asset("lib/assets/information.png",
                            width: 40, height: 40),
                        padding: EdgeInsets.all(10)),
                    Text(
                        "Please ensure the time of the new subtask\nis scheduled after the task's end time.",
                        style: TextStyle(fontSize: 13)),
                  ],
                )),
            subtaskCont(
                "One",
                subtask1TitleController,
                startTime,
                subtaskDurationController,
                subtask1RewardController,
                tapped,
                capture,
                image,
                imagePath),
            subtaskCont(
                "Two",
                subtask2TitleController,
                startTime,
                subtaskDurationController,
                subtask2RewardController,
                tapped2,
                capture2,
                image2,
                imagePath2),
            GestureDetector(
              onTap: () {
                if (subtask1TitleController.text.isEmpty ||
                    startTime == "" ||
                    subtaskDurationController.text.isEmpty ||
                    subtask1RewardController.text.isEmpty ||
                    image == null ||
                    subtask2TitleController.text.isEmpty ||
                    subtask2RewardController.text.isEmpty ||
                    image2 == null) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              "Some fields are empty!",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            content: Image.asset(
                              'lib/assets/issue.png',
                              width: 60,
                              alignment: Alignment.center,
                              height: 60,
                            ),
                            actions: [
                              TextButton(
                                  child: Text("Okay"),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                } else {
                  Subtask_Two newSubtaskTwo = Subtask_Two(
                      subtask_id: "",
                      name: subtask2TitleController.text,
                      time: startTime,
                      duration: int.parse(subtaskDurationController.text),
                      image: image2!.path,
                      rewards: int.parse(subtask2RewardController.text));
                  Subtask_One newSubtaskOne = Subtask_One(
                      subtask_id: "",
                      name: subtask1TitleController.text,
                      time: startTime,
                      duration: int.parse(subtaskDurationController.text),
                      image: image!.path,
                      rewards: int.parse(subtask1RewardController.text));
                  newSubTask = true;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => addTaskScreen(
                                subtasks: [newSubtaskOne, newSubtaskTwo],
                              )));
                  //  if (true) {
                  //   subtask1TitleController.clear();
                  //   subtask2TitleController.clear();
                  //   subtaskStartTimeController.clear();
                  //   subtask1RewardController.clear();
                  //   subtask2RewardController.clear();
                  //   subtaskDurationController.clear();

                  //   Navigator.pop(context);
                  // }
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
                  "Create Subtasks",
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
      String subtaskStartTimeController,
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
                            // controller: subtaskStartTimeController,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Cabin-Regular",
                                fontSize: 14),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
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
                          hintText: "10 minutes",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Row(children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            cursorColor: Color.fromARGB(255, 45, 119, 223),
                            controller: subtaskRewardController,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Cabin-Regular",
                                fontSize: 16),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              hintText: "5 stars!",
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
                      "Upload image:",
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
                          hintText: startTime,
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
