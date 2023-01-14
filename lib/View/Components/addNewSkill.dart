import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/Skill.dart';
import 'package:fyp_application/api/firebase_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'doneButtonCaregiver.dart';

class newSkillComp extends StatefulWidget {
  final String learner_id;
  const newSkillComp({super.key, required this.learner_id});

  @override
  State<newSkillComp> createState() => _newSkillCompState();
}

final skillName = TextEditingController();

class _newSkillCompState extends State<newSkillComp> {
  File? image;

  bool tapped = false;
  Image imagePath =
      Image(image: AssetImage("lib/assets/photo.png"), width: 70, height: 80);

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  late String pic = "";
  late String urlDownload = "";
  Future capture() async {
    try {
      // ignore: deprecated_member_use
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp); //was imageTemp
      final path = "skillImages/${skillName.text}";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadFile = await ref.putFile(File(image.path));
      urlDownload = (await uploadFile.ref.getDownloadURL());
      setState(() {
        pic = urlDownload;
      });
      // final MediaSource s = ModalRoute.of(context).media;
      // if (media == null) {
      //   return;
      // } else {
      //   fileMedia = media;
      // }
      return urlDownload;
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
          height: 210,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: Text(
                      "Skill:",
                      style: TextStyle(
                          fontFamily: "Cabin-Regular",
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Color.fromARGB(255, 3, 20, 66)),
                    ),
                    padding: EdgeInsets.only(left: 5, right: 15),
                  ),
                  Padding(
                    child: Container(
                        width: 170,
                        height: 30,
                        child: TextField(
                          controller: skillName,
                          cursorColor: Color.fromARGB(255, 100, 100, 100),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 8.0,
                              bottom: 5.0,
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 217, 217, 217),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 217, 217, 217))),
                          ),
                        )),
                    padding: EdgeInsets.only(bottom: 20, right: 10),
                  )
                ],
              ),
              Padding(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      child: Text(
                        "Upload image:",
                        style: TextStyle(
                            fontFamily: "Cabin-Regular",
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Color.fromARGB(255, 3, 20, 66)),
                      ),
                      padding: EdgeInsets.only(left: 5, bottom: 10, right: 15),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await capture();
                        print("URLDOWNLOAD: " + pic);
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
                padding: EdgeInsets.only(bottom: 20, right: 10),
              ),
              doneButtonCaregiver(
                function: () async {
                  if (skillName.text.isNotEmpty && urlDownload != "") {
                    Skill newSkill = Skill(
                        skill_id: "",
                        name: skillName.text,
                        is_completed: false,
                        date_completed: null,
                        // image: urlDownload);
                        image: pic);
                    await FirebaseApi.addSkill(newSkill, widget.learner_id);
                    if (true) {
                      skillName.clear();
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "Skill Created!",
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
                              "Please ensure that all input fields are provided for!"),
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
              ),
            ],
          )
          // ]),
          //     Padding(
          //       child:
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 child: Text(
          //                   "Upload image:",
          //                   style: TextStyle(
          //                       fontFamily: "Fredoka-Medium",
          //                       fontWeight: FontWeight.w700,
          //                       fontSize: 18,
          //                       color: Color.fromARGB(255, 3, 20, 66)),
          //                 ),
          //                 padding: EdgeInsets.only(left: 5, bottom: 10),
          //               ),
          //               GestureDetector(
          //                 onTap: () {
          //                   //upload image!
          //                 },
          //                 child: Container(
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(20),
          //                         color: Color.fromARGB(255, 217, 217, 217)),
          //                     width: 90,
          //                     padding: EdgeInsets.only(top: 5, bottom: 5),
          //                     alignment: Alignment.center,
          //                     child: Image.asset(
          //                       "lib/assets/addImage.png",
          //                       width: 40,
          //                       height: 40,
          //                     )),
          //               )
          //             ],
          //           ),
          //       padding: EdgeInsets.only(bottom: 20),
          //     ),
          //     SizedBox(
          //         width: 95,
          //         height: 40,
          //         child: ElevatedButton(
          //           onPressed: () {
          //             //add details to db
          //           Navigator.of(context).pop;
          //           },
          //           child: Padding(
          //             child: Text("Done",
          //                 style: TextStyle(
          //                     color: Colors.white,
          //                     fontFamily: "Fredoka-SemiBold",
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 15)),
          //             padding: EdgeInsets.only(
          //                 left: 10, right: 10, top: 5, bottom: 5),
          //           ),
          //           style: ButtonStyle(
          //               shape:
          //                   MaterialStateProperty.all<RoundedRectangleBorder>(
          //                       RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(20.0))),
          //               backgroundColor: MaterialStatePropertyAll<Color>(
          //                   Color.fromARGB(255, 66,135,123))),
          //         ))
          //   ],
          // )
          ),
    );
  }
}
