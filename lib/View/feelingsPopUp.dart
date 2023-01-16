import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Components/closeButton.dart';

class feelingsPopUp extends StatefulWidget {
  const feelingsPopUp({super.key});

  @override
  State<feelingsPopUp> createState() => _feelingsPopUpState();
}

class _feelingsPopUpState extends State<feelingsPopUp> {
  bool clicked = false;
  GestureDetector faceBox(String image, String feeling) {
    return GestureDetector(
        onTap: (() {
          setState(() {
            clicked = true;
          });
        }),
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, right: 7),
          decoration: BoxDecoration(
              border: Border.all(
                width: clicked == true ? 1 : 0,
                color: clicked == true
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          width: 80,
          height: 85,
          child: Column(
            children: [
              Padding(
                child: Image.asset(image, width: 50, height: 50),
                padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 3),
              ),
              Padding(
                child: Text(
                  feeling,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                padding: EdgeInsets.only(top: 3, left: 5, right: 5, bottom: 3),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [closeButton()],
      backgroundColor: Color.fromARGB(255, 255, 235, 164),
      title: Padding(
        child: Text(
          "How are you feeling now?",
          style: TextStyle(
              fontFamily: "Fredoka-Medium", fontSize: 27, color: Colors.black),
        ),
        padding: EdgeInsets.all(5),
      ),
      content: Container(
        height: 315,
        width: double.infinity,
        // margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: Container(
            // margin: EdgeInsets.only(bottom: 60),
            child: Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Text(
                  "I feel ...",
                  style: TextStyle(
                      color: Color.fromARGB(255, 62, 81, 140),
                      fontFamily: "Fredoka-Medium",
                      fontSize: 25),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          faceBox("lib/assets/excited.png", "Excited"),
                          faceBox("lib/assets/happy.png", "Happy"),
                          faceBox("lib/assets/confused.png", "Confused"),
                        ])),
                Row(
                  children: [
                    faceBox("lib/assets/sad.png", "Sad"),
                    faceBox("lib/assets/angry.png", "Angry"),
                    faceBox("lib/assets/scared.png", "Scared")
                  ],
                ),
              ],
            ),
          ),
          Padding(
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 62, 81, 140)),
                ),
                onPressed: (() {}),
                child: Container(
                  alignment: Alignment.center,
                  // color: Color.fromARGB(255, 62,81,140),
                  // transformAlignment:Alignment.center ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 62, 81, 140)),
                  height: 50,
                  width: 70,
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Fredoka-Medium",
                        fontSize: 20),
                  ),
                )),
            padding: EdgeInsets.all(3),
          ),
        ])),
      ),

    );
  }
}
