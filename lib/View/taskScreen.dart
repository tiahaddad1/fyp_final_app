import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Components/closeButton.dart';

class taskScreen extends StatefulWidget {
  const taskScreen({super.key});

  @override
  State<taskScreen> createState() => _taskScreenState();
}

Object seconds = (15.30 - 12.20).toString().split('.')[1] == null
    ? 0
    : (15.30 - 12.20).toString().split('.')[1];

Object minutes = (15.30 - 12.20).toString().split('.')[1] == null
    ? 0
    : (15.30 - 12.20).toString().split('.')[1];

Object hours = (15.30 - 12.20).toString().split('.')[0] == null
    ? 0
    : (15.30 - 12.20).toString().split('.')[0];

class _taskScreenState extends State<taskScreen> {
  CountDownController timeController = CountDownController();
  bool isPlaying = false;

  late VideoPlayerController _controller;
  late File _video;
  bool vid = false;
  final picker = ImagePicker();
  Timer? timer;

  videoPlayer() async {
    // ignore: deprecated_member_use

    //GET THE VIDEO FROM DB
    final video = await picker.getVideo(source: ImageSource.gallery);
    _video = File(video!.path);
    _controller = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        _controller.play();
      });
  }

  GestureDetector subTaskComp(String image, int rewards) {
    return GestureDetector(
        onTap: () {},
        child: Stack(alignment: Alignment.topRight, children: <Widget>[
          Container(
            child: Image.asset(image),
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 238, 238, 238),
                  blurRadius: 6.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 21,
              right: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    )),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      "+" +
                          rewards.toString(), //task.subtasks.reward.toString()
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 47, 99, 6))),
                ),
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        margin: EdgeInsets.all(25),
        // height: 500,
        // width: 400,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 221, 239, 250),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          // Padding(padding: EdgeInsets.all(20),child: Text(task.title,style: TextStyle(fontFamily: "Fredoka-Medium",color: Color.fromARGB(255, 3,20,66),fontSize: 20),),)
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Brush Teeth",
              style: TextStyle(
                  fontFamily: "FredokaOne-Regular",
                  color: Color.fromARGB(255, 3, 20, 66),
                  fontSize: 30),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 15, left: 5, right: 5),
              child: Container(
                width: 300,
                height: 200,
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  // child: VideoPlayer(_controller),
                ),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
          // Padding(padding: EdgeInsets.only(bottom:10, right: 5,left: 5),child:Text(task.description,style: TextStyle(fontFamily: "Fredoka-Medium",color: Color.fromARGB(255, 0, 0, 0),fontSize: 15),)),
          Padding(
              padding: EdgeInsets.only(bottom: 10, right: 5, left: 5),
              child: Text(
                "Please brush your teeth gently.",
                style: TextStyle(
                    fontFamily: "Fredoka-SemiBold",
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20),
              )),
          Container(
            // color: Colors.white,
            width: 300,
            height: 210,
            child: Align(
              child: CircularCountDownTimer(
                textFormat: CountdownTextFormat.HH_MM_SS,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                duration: durationFunc(),
                timeFormatterFunction: (defaultFormatterFunction, duration) {
                  if ((duration.inSeconds == 0) &&
                      (duration.inMinutes == 0) &&
                      (duration.inHours == 0)) {
                    return "END";
                  } else {
                    return Function.apply(defaultFormatterFunction, [duration]);
                  }
                },
                // duration:10,
                fillColor: Colors.transparent,
                onChange: (value) {
                  // setState(() {
                  set(value);
                  // });
                },
                // timeFormatterFunction: (defaultFormatterFunction, duration) {
                //   if (duration.inHours == 0) {
                //     duration = durationM;
                //   } else if (duration.inMinutes==0){
                //     duration=durationS;
                //   }
                //   else{
                //     return Function.apply(defaultFormatterFunction, [duration]);
                //   }
                // },
                ringColor: durationColor(),
                controller: timeController,
                strokeWidth: 7.0,
                strokeCap: StrokeCap.round,
                isTimerTextShown: true,
                isReverse: true,
                onComplete: () {
                  Alert(
                          context: context,
                          title: 'Done!',
                          style: AlertStyle(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              isCloseButton: true,
                              isButtonVisible: false,
                              titleStyle: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: "Fredoka-Medium",
                                fontSize: 30,
                              )),
                          type: AlertType.success)
                      .show();
                  //check if subtasks exist, then show subtask pop-up, if it does not exist then navigate to awarded page!
                },
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),

              // child: timerCountdown(),
              alignment: Alignment.center,
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     showDialog(
          //         context: context, builder: ((context) => viewSubtask()));
          //   },
          //   child: Padding(
          //     child: Text("Start!",
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontFamily: "Fredoka-Medium",
          //             fontSize: 15)),
          //     padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          //   ),
          //   style: ButtonStyle(
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //           RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10.0))),
          //       backgroundColor: MaterialStatePropertyAll<Color>(
          //           Color.fromARGB(255, 10, 207, 131))),
          // )
        ]),
      ),
      alignment: Alignment.center,
    );
  }

  AlertDialog viewSubtask() {
    return AlertDialog(
        backgroundColor: Color.fromARGB(255, 241, 238, 238),
        alignment: Alignment.center,
        buttonPadding: EdgeInsets.only(bottom: 27, right: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [closeButton()],
        title: RichText(
            text: TextSpan(
                text: "While I am waiting ",
                style: TextStyle(
                    fontFamily: "Fredoka-Medium",
                    fontSize: 25,
                    color: Colors.black),
                children: <TextSpan>[
              TextSpan(
                  text: "I can ",
                  style: TextStyle(color: Color.fromARGB(255, 104, 178, 107))),
              TextSpan(
                  text: "also...",
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
            ])),
        content: Container(
            width: double.infinity,
            height: 300,
            child: Expanded(
              child: Column(children: [
                Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      subTaskComp("lib/assets/imageDummy.png", 5),
                      Padding(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: Text(
                          "or",
                          style: TextStyle(
                              fontFamily: "DM-Sans-Medium",
                              color: Color.fromARGB(255, 31, 31, 30),
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      subTaskComp("lib/assets/imageDummy.png", 10),
                    ]),
                Row(
                  children: [
                    Padding(
                      child: Text(
                          "Fix my clothes", //task.subTaskOne.description
                          style: TextStyle(
                              color: Color.fromARGB(255, 63, 62, 59),
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Padding(
                      child: Text("Unfold my bed", //task.subTaskTwo.description
                          style: TextStyle(
                              color: Color.fromARGB(255, 63, 62, 59),
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                      padding: EdgeInsets.only(left: 30, right: 10),
                    )
                  ],
                ),
                Padding(
                  child: RichText(
                      text: TextSpan(
                          text: "for ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                        TextSpan(
                            text: "10 ", //task.subtasks.duration.toString()
                            style: TextStyle(
                                color: Color.fromARGB(255, 27, 46, 222))),
                        TextSpan(
                            text: "minutes",
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                      ])),
                  padding: EdgeInsets.only(top: 35, bottom: 50),
                ),

                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        onPressed:
                        Navigator.of(context).pop;
                        //change to selected subtask
                      },
                      child: Padding(
                        child: Text("Start!",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Fredoka-Medium",
                                fontSize: 20)),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 10, 207, 131))),
                    ))
                // ElevatedButton(onPressed: {}, child: child)
              ]),
            )));
  }

  Duration durationH = Duration(hours: int.parse(hours.toString()));
  Duration durationM = Duration(minutes: int.parse(minutes.toString()));
  Duration durationS = Duration(seconds: int.parse(seconds.toString()));
  String strDigits(int n) => n.toString().padLeft(2, '0');
  int dur = 0;

  int durationFunc() {
    setState(() {
      String startTime = "12.30";
      String endTime = "13.30";
      String totalTime =
          (double.parse(endTime) - double.parse(startTime)).toString();

      print(totalTime);

      int hours = int.parse(
          totalTime.split(".").length == 2 ? totalTime.split(".")[0] : '0');
      int minutes = int.parse(
          totalTime.split(".").length == 2 ? totalTime.split(".")[1] : '0');
      dur = convertToSeconds(hours, minutes, 0);
    });
    // print(dur);
    return dur;
  }

  int convertToSeconds(int hours, int minutes, int seconds) {
    int totalSec = (hours * 3600) + (minutes * 60) + seconds;
    return totalSec;
  }
  // @override
  // void setState(VoidCallback fn) {
  //   durationColor(value);
  //   super.setState(fn);
  // }

  late String v = (durationFunc().toString());

  void set(String value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        v = value;
      });
    });
  }

  Color durationColor() {
    print(v);
    if (int.parse(v) <= 30) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
