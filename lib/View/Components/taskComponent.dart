import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../Model/Task.dart';

class taskComponent extends StatefulWidget {
  final Task task;
  const taskComponent({
    super.key,
    required this.task, //make required once backend done
  });

  @override
  State<taskComponent> createState() => _taskComponentState();
}

// @override
// void initState() {
//   taskStatus = "";
//   super.initState();
// }

class _taskComponentState extends State<taskComponent> {
  final currentTime = new DateTime.now();
  String? taskStatus;
  Color? textColor;
  Color? titleColor;
  late VideoPlayerController _controller=VideoPlayerController.file(File(widget.task.video));
  final picker = ImagePicker();
  late File _video;
  bool vid = false;

  List<Color> colorPalette() {
    List<Color> colors = [];
    //DELETE LATER WHEN LOGIC IMPLEMENTED
    colors.add(Color.fromARGB(255, 168, 167, 166));
    colors.add(Color.fromARGB(255, 168, 167, 166));

    // int minutes=int.parse(task.startTime.split(":")[1]);
    // int hours=int.parse(task.startTime.split(":")[0]);
    // if(task.startTime>currentTime){
    //   colors.add(Color.fromARGB(255, 149, 149, 149));
    //   colors.add(Color.fromARGB(255, 100, 100, 99));
    // taskStatus="Done";
    // textColor=Color.fromARGB(255, 234,255,235);
    // titleColor=Color.fromARGB(255, 11,126,15);

    // }
    //   else if(task.startTime<currentTime && task.endTime<currentTime){
    //   colors.add(Color.fromARGB(255, 237,180,96));
    //   colors.add(Color.fromARGB(255, 237,180,96));
    // taskStatus="Next";
    // textColor=Color.fromARGB(255, 255,244,222);
    // titleColor=Color.fromARGB(255, 140,93,5);
    // }
    // else if(hours>=currentTime.hour && minutes-30<currentTime.minute){
    // colors.add(Color.fromARGB(255, 168,167,166));
    // colors.add(Color.fromARGB(255, 168,167,166));
    // taskStatus="Later";
    // textColor=Color.fromARGB(255, 235,235,235);
    // titleColor=Color.fromARGB(255, 92,91,91);
    // }
    return colors;
  }

  videoPlayer() async {
    // ignore: deprecated_member_use

    //GET THE VIDEO FROM DB
    final video = await picker.getVideo(source: ImageSource.gallery);
    _video = File(widget.task.video);
    _controller = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        //     // _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: new BoxDecoration(
          gradient:
              new LinearGradient(stops: [0.02, 0.10], colors: colorPalette()),
          borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 126, 126, 126).withOpacity(0.5),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    taskStatus ?? "Later",
                    style: TextStyle(
                        color: titleColor ?? Color.fromARGB(255, 92, 91, 91),
                        fontFamily: "FredokaOne-Regular",
                        fontSize: 28),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    // task.startTime,
                    widget.task.start_time,
                    style: TextStyle(
                        color: titleColor ?? Color.fromARGB(255, 92, 91, 91),
                        fontFamily: "FredokaOne-Regular",
                        fontSize: 28),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      videoPlayer();
                      vid = true;
                    },
                    child: Container(
                        width: 200,
                        height: 100,
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          // child: VideoPlayer(_controller),
                          child: VideoPlayer(VideoPlayerController.file(File(widget.task.video))),
                        ))),
                Container(
                  width: 150,
                  height: 100,
                  padding: EdgeInsets.only(left: 10),
                  child: Text(widget.task.description,
                      // Text(task.description,
                      style: TextStyle(
                        fontFamily: "FredokaOne-Regular",
                        color: textColor ?? Color.fromARGB(255, 235, 235, 235),
                        fontSize: 20,
                      )),
                ),
              ],
            ),
            if (vid == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 80),
                      child: InkWell(
                        onTap: () {
                          _controller.play();
                        },
                        child: Image.asset(
                          'lib/assets/play-button.png',
                          width: 25,
                          height: 25,
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: InkWell(
                        onTap: () {
                          _controller.pause();
                        },
                        child: Image.asset(
                          'lib/assets/pause-button.png',
                          width: 25,
                          height: 25,
                        ),
                      ))
                ],
              ),
          ],
        ));
  }
}
