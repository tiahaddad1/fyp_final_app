import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/closeButton.dart';

import '../feelingsPopUp.dart';

class skillComponent extends StatefulWidget {
  const skillComponent({super.key, skill});

  @override
  State<skillComponent> createState() => _skillComponentState();
}

final colors = [
  Color.fromARGB(255, 251, 216, 243),
  Color.fromARGB(255, 216, 251, 219),
  Color.fromARGB(255, 216, 240, 251),
  Color.fromARGB(255, 225, 214, 235)
];
Random random = new Random();
int randomNo = random.nextInt(3);

class _skillComponentState extends State<skillComponent> {
  bool isPlaying = false;
  final controllerConf = ConfettiController();

  @override
  void initstate() {
    super.initState();
    controllerConf.addListener(() {
      setState(() {
        isPlaying = controllerConf.state == ConfettiControllerState.playing;
      });
    });
    // controllerConf.play();
  }

  Color borderColor() {
    // late Color color;
    Color color = Color.fromARGB(255, 142, 142, 142);
    // if(skill.completed=="true"){
    //   color=Color.fromARGB(255, 80,169,154);
    // }
    // else if(skill.completed=="false"){
    //   color=Color.fromARGB(255, 142,142,142);
    // }
    return color;
  }

  Container viewCertificate() {
    return Container(
        child: Row(
      children: [
        Image.asset(
          "lib/assets/certificateIcon.png",
          height: 30,
          width: 30,
        ),
        Padding(
            child: RichText(
                text: TextSpan(
                    text: "view certificate",
                    style: TextStyle(
                      color: Color.fromARGB(255, 62, 81, 140),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                            if (isPlaying)
                              {controllerConf.stop()}
                            else
                              {controllerConf.play()},
                            showDialog(
                                context: context,
                                builder: ((context) => ConfettiWidget(
                                    confettiController: controllerConf,
                                    shouldLoop: false,
                                    blastDirectionality:
                                        BlastDirectionality.explosive,
                                    child: 
                                    //to pop up feelings:
                                    // feelingsPopUp(),
                                    AlertDialog(
                                        alignment: Alignment.center,
                                        buttonPadding: EdgeInsets.only(
                                            bottom: 27, right: 25),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 240, 213, 117),
                                              width: 10,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        actions: [
                                    closeButton()
                                        ],
                                        // title: Text("Congratulations "+user.firstName+"!"),
                                        title: Row(children: [
                                          Expanded(
                                            child: Padding(
                                              child: Text(
                                                "Congratulations Liam!",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "FredokaOne-Regular",
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 64, 89, 107)),
                                              ),
                                              padding: EdgeInsets.only(
                                                  right: 7, left: 5),
                                            ),
                                          ),
                                          Image.asset(
                                            "lib/assets/thumbsUp.png",
                                            width: 30,
                                            height: 30,
                                          )
                                        ]),
                                        content: Expanded(
                                            child: Container(
                                          width: double.infinity,
                                          height: 120,
                                          child: Column(children: [
                                            Expanded(
                                              child: Padding(
                                                child: Text(
                                                  "You are rewarded with a certificate for completing a skill!",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Fredoka-Medium",
                                                      fontSize: 15),
                                                ),
                                                padding: EdgeInsets.only(
                                                    bottom: 10, left: 5),
                                              ),
                                            ),
                                            // Padding(child:Text("Skill: "+widget.skill.name,style: TextStyle(fontFamily: "Fredoka-Medium",fontSize: 20,decoration: TextDecoration.underline),),padding: EdgeInsets.only(bottom:10,right: 5),)
                                            Expanded(
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 10,
                                                      bottom: 5),
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Expanded(
                                                            child: Padding(
                                                          child: Text(
                                                            "Skill: Communication Skills",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Fredoka-Medium",
                                                                fontSize: 15,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                          ),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                        )),
                                                        Image.asset(
                                                          "lib/assets/rewardBadge.png",
                                                          width: 45,
                                                          height: 45,
                                                        )
                                                      ])),
                                            ),
                                            // Padding(padding: EdgeInsets.only(left: 5,bottom: 5),child: Text("Date: "+skill.rewardedDate,style: TextStyle(fontFamily: "Fredoka-Medium",fontSize: 15),),)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 5, bottom: 5),
                                              child: Text(
                                                "Date: 25/12/2022",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Fredoka-Medium",
                                                    fontSize: 15),
                                              ),
                                            )
                                          ]),
                                        )))
                                        
                                        )))
                          })),
            padding: EdgeInsets.only(left: 10))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      decoration: BoxDecoration(
          color: colors[randomNo],
          borderRadius: BorderRadius.circular(13),
          // color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
            color: borderColor(),
            width: 5,
          )),
      child: Column(
        children: [
          Row(children: [
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 13),
                child: Image.asset(
                  "lib/assets/imageDummy.png",
                  width: 80,
                  height: 80,
                )),
            Padding(
                padding: EdgeInsets.only(top: 13),
                child: Text(
                  "Communication Skills",
                  style: TextStyle(fontFamily: "Fredoka-Medium", fontSize: 25),
                ))
          ]),

          // if (skill.completed == "true")
          //   {
          Row(children: [
            SizedBox(width: 200),
            Container(
              child: viewCertificate(),
            )
          ])
          // }
        ],
      ),
    );
  }
}
