import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/deleteButton.dart';
import 'package:fyp_application/View/Components/learnerDetailComponent.dart';
import 'package:fyp_application/View/addTaskScreen.dart';
import 'package:fyp_application/View/caregiverViewFeelings.dart';
import 'package:fyp_application/View/caregiverViewReminders.dart';
import 'package:fyp_application/View/caregiverViewRewards.dart';
import 'package:fyp_application/View/caregiverViewSchedule.dart';
import 'package:fyp_application/View/caregiverViewSkills.dart';
import 'package:fyp_application/api/firebase_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Model/Learner.dart';
import 'caregiverHome.dart';

class learnerInfoScreen extends StatefulWidget {
  final Learner learner;
  const learnerInfoScreen({super.key, required this.learner});

  @override
  State<learnerInfoScreen> createState() => _learnerInfoScreenState();
}

class _learnerInfoScreenState extends State<learnerInfoScreen> {
  calculateAge() {
    DateTime dob = DateFormat('MM/dd/yyyy').parse(widget.learner.birth_date);
    DateTime now = new DateTime.now();
    return ((now.difference(dob).inDays) / 365).floor();
  }

  deleteLearnerFromDB() {
    //put in controller all CRUD operations
    //populate code with deleting user from db
  }
  File? image;
  late String? ppUpload = "";
  late String img;
  bool tapped = false;
  late Image imagePath = Image(
      image: NetworkImage(widget.learner.profile_pic), width: 70, height: 80);
  late String urlDownload;
  Future capture() async {
    try {
      // ignore: deprecated_member_use
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp); //was imageTemp
      final path = "profilephoto/${widget.learner.email}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref
          .delete()
          .then((value) => print("deleted!"))
          .catchError((error) => {print(error)});
      final uploadFile = await ref.putFile(File(image.path));
      urlDownload = (await uploadFile.ref.getDownloadURL());
      await FirebaseApi.updateImageLearner(urlDownload, widget.learner.email);
      print("OKAYYYY: " + urlDownload);
      setState((() => ppUpload = urlDownload));
      return urlDownload;
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

  bool editImage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 251, 251, 251),
          toolbarHeight: 240,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(20),

          //   ),
          // ),
          title: Expanded(
              child: Column(children: [
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
                              margin: EdgeInsets.only(left: 0, bottom: 20),
                              alignment: Alignment.topLeft,
                              height: 30,
                              child: IconButton(
                                alignment: Alignment.topLeft,
                                iconSize: 23,
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.learner.first_name
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    widget.learner.first_name.substring(1) +
                                    " " +
                                    widget.learner.last_name
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    widget.learner.last_name.substring(1),
                                // "Liam Harrison",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Cabin-Regular"),
                                textAlign: TextAlign.left,
                              ),
                              padding: EdgeInsets.only(bottom: 20, left: 10),
                            ),
                            Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Padding(
                                    child: Text(
                                      "age: " +
                                          calculateAge().toString() +
                                          " years old", //subtract the year they were born with today's date
                                      style: TextStyle(
                                        fontFamily: "Cabin-Regular",
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(10),
                                  ),
                                  Padding(
                                    child: Text(
                                      "date of birth: " +
                                          widget.learner
                                              .birth_date, //display their dob
                                      style: TextStyle(
                                        fontFamily: "Cabin-Regular",
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 16, 16, 16),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(10),
                                  ),
                                ])),
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
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Column(children: [
                                    InkWell(
                                        onTap: () {
                                          if (tapped == false) {
                                            capture();
                                            tapped = true;
                                          }
                                        },
                                        child: FutureBuilder(
                                          future:
                                              FirebaseApi.returnImageLearner(
                                                  widget.learner.email),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Image(
                                                  image: NetworkImage(
                                                      snapshot.data!),
                                                  width: 200,
                                                  height: 90);
                                            } else {
                                              return Image.asset(
                                                  "lib/assets/user1.png",
                                                  fit: BoxFit.cover);
                                            }
                                          },
                                        ))
                                  ]))),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 7,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  editImage = true;
                                });
                                if (editImage == true) {
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
          ]))),
      backgroundColor: Color.fromARGB(255, 66, 135, 123),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 251, 251, 251),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            margin: EdgeInsets.only(right: 30, left: 30, bottom: 20),
            height: MediaQuery.of(context).size.height -
                400, //media context of screen
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 10, top: 20),
                  padding: EdgeInsets.only(left: 13),
                  child: Text(
                    widget.learner.first_name.substring(0, 1).toUpperCase() +
                        widget.learner.first_name.substring(1) +
                        "'s information:",
                    style: TextStyle(
                        color: Color.fromARGB(255, 63, 62, 59),
                        decoration: TextDecoration.underline,
                        fontSize: 17,
                        fontFamily: "lib/assets/Cabin-Regular",
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // learnerDetailComp(image: "lib/assets/scheduleDetailIcon.png", name: "Schedule", page: addTaskScreen()),
                    learnerDetailComp(
                        image: "lib/assets/scheduleDetailIcon.png",
                        name: "Schedule",
                        page: caregiverSchedule(learner_id:widget.learner.user_id)),
                    learnerDetailComp(
                        image: "lib/assets/feelingsDetailIcon.png",
                        name: "Feelings",
                        page: caregiverFeelings()),
                    learnerDetailComp(
                        image: "lib/assets/pinDetailIcon.png",
                        name: "Reminders",
                        page: caregiverReminders()),
                    learnerDetailComp(
                        image: "lib/assets/skillDetailIcon.png",
                        name: "Skills",
                        page: caregiverSkills()),
                    learnerDetailComp(
                        image: "lib/assets/rewardDetailIcon.png",
                        name: "Rewards",
                        page: caregiverRewards()),
                  ],
                ))
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: deleteButton(
              text: "Delete Learner",
              user: widget.learner,
              role: "l",
            ),
          )
        ],
      ),
    );
  }
}
