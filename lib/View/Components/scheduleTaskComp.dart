import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class scheduleTaskComp extends StatefulWidget {
  // final String taskTitle;
  // final String timeFrom;
  // final String timeTo;
  // final int duration;
  // final String description;
  // final videoContent;
  const scheduleTaskComp({super.key});

// const scheduleTaskComp({super.key,required this.taskTitle,required this.timeFrom,required this.timeTo,required this.duration,required this.description,required this.videoContent,});

  @override
  State<scheduleTaskComp> createState() => _scheduleTaskCompState();
}

class _scheduleTaskCompState extends State<scheduleTaskComp> {
  List<Color> colors = [
    Color.fromARGB(255, 234, 155, 188),
    Color.fromARGB(255, 185, 194, 220),
    Color.fromARGB(255, 247, 236, 131),
    Colors.green[200]!
  ];
  Random random = new Random();

  //a function that returns the subtasks and sets the array with setState
// List<Subtask> subtasks() {
//   an array that has all subtasks from DB
//   List<Subtask> subtasks = [];
// }
  late VideoPlayerController _controller;
  @override
  Widget build(BuildContext context) {
    int randomNumber = random.nextInt(3);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors[randomNumber],
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(15),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "INSERT TASK TITLE",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Cabin-Regular",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  right: 5, left: 10, bottom: 10),
                              child: Icon(
                                Icons.timer_outlined,
                                size: 12,
                              )),
                          Text(
                            "10:00" + "-" + "10:20",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: "Cabin-Regular"),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 5, left: 10),
                              child: Icon(
                                Icons.timer_outlined,
                                size: 12,
                              )),
                          Text(
                            "5",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: "Cabin-Regular"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "blah blah blah",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Cabin-Regular",
                        fontSize: 10),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("View subtasks",
                        style: TextStyle(
                            color: Color.fromARGB(255, 62, 81, 140),
                            fontFamily: "Cabin-Regular",
                            decoration: TextDecoration.underline,
                            fontSize: 12))
                    // subtasks().length>0?
                    // GestureDetector(child:Text("View subtasks",style: TextStyle(
                    //     color: Color.fromARGB(255, 62, 81, 140),
                    //     fontFamily: "Cabin-Regular",
                    // decoration: TextDecoration.underline,
                    //     fontSize: 12),),onTap: () {
                    //   //go to subtasks view page
                    // },):Text("No subtasks",),

                    ),
              ],
            ),
          ),
          Container(
            width: 150,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  height: 80,
                  child:

                      // AspectRatio(
                      // aspectRatio: 3 / 2,
                      // child: VideoPlayer(_controller),
                      // ),
                      Image.asset(
                    "lib/assets/footballTaskImage.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, right: 7),
                            child: Image.asset(
                              "lib/assets/editCont.png",
                              width: 15,
                              height: 15,
                            ),
                          ),
                          onTap: () {
                            //save to DB
                          },
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, right: 7),
                            child: Image.asset(
                              "lib/assets/delete.png",
                              width: 15,
                              height: 15,
                            ),
                          ),
                          onTap: () {
                            //delete from DB
                          },
                        )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
