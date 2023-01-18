import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/Reward.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/firebase_api.dart';
import 'closeButton.dart';

class newRewardComponent extends StatefulWidget {
  final String learner;
  const newRewardComponent({super.key, required this.learner});

  @override
  State<newRewardComponent> createState() => _newRewardComponentState();
}

class _newRewardComponentState extends State<newRewardComponent> {
  final rewardController = TextEditingController();
  final rewardPoints = TextEditingController();

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
      final path = "rewardImages/${rewardController.text}";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadFile = await ref.putFile(File(image.path));
      urlDownload = (await uploadFile.ref.getDownloadURL());
      pic = urlDownload;
      setState((() {
        pic = urlDownload;
      }));
      print(pic);
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
        actions: [closeButton()],
        backgroundColor: Color.fromARGB(255, 241, 238, 238),
        content: Container(
          height: 270,
          width: double.infinity,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: Text(
                      "New Reward",
                      style: TextStyle(
                          fontFamily: "Fredoka-Medium",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color.fromARGB(255, 3, 20, 66)),
                    ),
                    padding: EdgeInsets.only(left: 5, bottom: 10),
                  ),
                  Padding(
                    child: TextField(
                      controller: rewardController,
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
                    padding: EdgeInsets.only(bottom: 20),
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
                            "Reward Points",
                            style: TextStyle(
                                fontFamily: "Fredoka-Medium",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Color.fromARGB(255, 3, 20, 66)),
                          ),
                          padding: EdgeInsets.only(left: 5, bottom: 10),
                        ),
                        TextField(
                          controller: rewardPoints,
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
                                fontFamily: "Fredoka-Medium",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Color.fromARGB(255, 3, 20, 66)),
                          ),
                          padding: EdgeInsets.only(left: 5, bottom: 10),
                        ),
                        GestureDetector(
                          onTap: () async{
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
                padding: EdgeInsets.only(bottom: 20),
              ),
              SizedBox(
                  width: 95,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      print(widget.learner);
                      if (rewardController.text.isNotEmpty && urlDownload != "") {
                        // Navigator.of(context).pop;
                        Reward newReward = new Reward(
                            image: pic,
                            reward_id: "",
                            points: int.parse(rewardPoints.text),
                            name: rewardController.text);
                        await FirebaseApi.addReward(newReward, widget.learner);

                        if (true) {
                          rewardController.clear();
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                      "Nice job, you created a new reward!",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    content: Image.asset(
                                      'lib/assets/check.png',
                                      alignment: Alignment.center,
                                      height: 45,
                                      width: 45,
                                    ),
                                    actions: [
                                      TextButton(
                                          child: Text("Okay"),
                                          onPressed: () =>
                                              Navigator.pop(context))
                                    ],
                                  ));
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Missing information"),
                                content: Text(
                                    "Please put all the information! Thank you :)"),
                                actions: [
                                  TextButton(
                                    child: Text("Okay"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: Padding(
                      child: Text("Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Fredoka-SemiBold",
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 10, 207, 131))),
                  ))
            ],
          ),
        ));
  }
}
