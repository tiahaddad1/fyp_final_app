import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/doneButtonCaregiver.dart';
import 'package:fyp_application/api/firebase_api.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/Reward.dart';

class addNewRewardCaregiver extends StatefulWidget {
  final String learner_id;
  const addNewRewardCaregiver({super.key, required this.learner_id});

  @override
  State<addNewRewardCaregiver> createState() => _addNewRewardCaregiverState();
}

final rewardNameController = TextEditingController();
final pointsController = TextEditingController();

class _addNewRewardCaregiverState extends State<addNewRewardCaregiver> {
  File? image;
  late String pic = "";
  late String urlDownload = "";
  Future capture() async {
    try {
      // ignore: deprecated_member_use
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp); //was imageTemp
      final path = "rewardImages/${rewardNameController.text}";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadFile = await ref.putFile(File(image.path));
      urlDownload = (await uploadFile.ref.getDownloadURL());
      pic = urlDownload;
      setState((() {
        pic = urlDownload;
      }));
      print(urlDownload);
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true), // passing false
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.red[900]),
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 241, 238, 238),
        content: Container(
            height: 265,
            width: double.infinity,
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: Text(
                      "New Reward",
                      style: TextStyle(
                          fontFamily: "Cabin-Regular",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color.fromARGB(255, 3, 20, 66)),
                    ),
                    padding: EdgeInsets.only(left: 5, bottom: 10),
                  ),
                  Padding(
                    child: TextField(
                      controller: rewardNameController,
                      cursorColor: Color.fromARGB(255, 100, 100, 100),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 217, 217, 217),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 217, 217, 217))),
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: 5),
                  )
                ],
              ),
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          child: Text(
                            "Points",
                            style: TextStyle(
                                fontFamily: "Cabin-Regular",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color.fromARGB(255, 3, 20, 66)),
                          ),
                          padding: EdgeInsets.only(left: 5, bottom: 10),
                        ),
                        TextField(
                          controller: pointsController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: Color.fromARGB(255, 100, 100, 100),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 217, 217, 217),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 217, 217, 217))),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          child: Text(
                            "Add Image",
                            style: TextStyle(
                                fontFamily: "Cabin-Regular",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color.fromARGB(255, 3, 20, 66)),
                          ),
                          padding: EdgeInsets.only(left: 5, bottom: 10),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await capture();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 217, 217, 217)),
                              width: 90,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "lib/assets/addImage.png",
                                width: 40,
                                height: 40,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
                padding: EdgeInsets.only(bottom: 20, top: 20),
              ),
              doneButtonCaregiver(
                function: () async {
                  if (rewardNameController.text.isNotEmpty &&
                      urlDownload != "") {
                    Reward newReward = Reward(
                        reward_id: "",
                        name: rewardNameController.text,
                        points: int.parse(pointsController.text),
                        image: pic);

                    await FirebaseApi.addReward(newReward, widget.learner_id);
                    if (true) {
                      rewardNameController.clear();
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "Reward Created!",
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
                                      onPressed: () => Navigator.pop(context))
                                ],
                              ));
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Missing input fields"),
                          content: Text(
                              "Please ensure that all input fields are provided!"),
                          actions: [
                            TextButton(
                              child: Text("Okay"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  }
                },
              ), //code to save to database, take the values from texteditcontroller
            ])));
  }
}
