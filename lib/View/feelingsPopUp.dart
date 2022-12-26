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
                  height: 60,
                  width: 100,
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Fredoka-Medium",
                        fontSize: 30),
                  ),
                )),
            padding: EdgeInsets.all(5),
          ),
        ])),
      ),

      //     Row(
      //   children: [
      //     Image.asset(
      //       "lib/assets/certificateIcon.png",
      //       height: 30,
      //       width: 30,
      //     ),
      //     Padding(
      //         child: RichText(
      //             text: TextSpan(
      //                 text: "view certificate",
      //                 style: TextStyle(
      //                   color: Color.fromARGB(255, 62, 81, 140),
      //                   fontWeight: FontWeight.w500,
      //                   decoration: TextDecoration.underline,
      //                 ),
      //                 recognizer: TapGestureRecognizer()
      //                   ..onTap = () => {
      //                         if (isPlaying)
      //                           {controllerConf.stop()}
      //                         else
      //                           {controllerConf.play()},
      //                         showDialog(
      //                             context: context,
      //                             builder: ((context) => ConfettiWidget(
      //                                 confettiController: controllerConf,
      //                                 shouldLoop: false,
      //                                 blastDirectionality:
      //                                     BlastDirectionality.explosive,
      //                                 child: AlertDialog(
      //                                     alignment: Alignment.center,
      //                                     buttonPadding: EdgeInsets.only(
      //                                         bottom: 27, right: 25),
      //                                     shape: RoundedRectangleBorder(
      //                                         side: BorderSide(
      //                                           color: Color.fromARGB(
      //                                               255, 240, 213, 117),
      //                                           width: 10,
      //                                         ),
      //                                         borderRadius:
      //                                             BorderRadius.circular(10)),
      //                                     actions: [
      //                                 closeButton()
      //                                     ],
      //                                     // title: Text("Congratulations "+user.firstName+"!"),
      //                                     title: Row(children: [
      //                                       Expanded(
      //                                         child: Padding(
      //                                           child: Text(
      //                                             "Congratulations Liam!",
      //                                             style: TextStyle(
      //                                                 fontFamily:
      //                                                     "FredokaOne-Regular",
      //                                                 fontSize: 20,
      //                                                 color: Color.fromARGB(
      //                                                     255, 64, 89, 107)),
      //                                           ),
      //                                           padding: EdgeInsets.only(
      //                                               right: 7, left: 5),
      //                                         ),
      //                                       ),
      //                                       Image.asset(
      //                                         "lib/assets/thumbsUp.png",
      //                                         width: 30,
      //                                         height: 30,
      //                                       )
      //                                     ]),
      //                                     content: Expanded(
      //                                         child: Container(
      //                                       width: double.infinity,
      //                                       height: 120,
      //                                       child: Column(children: [
      //                                         Expanded(
      //                                           child: Padding(
      //                                             child: Text(
      //                                               "You are rewarded with a certificate for completing a skill!",
      //                                               style: TextStyle(
      //                                                   fontFamily:
      //                                                       "Fredoka-Medium",
      //                                                   fontSize: 15),
      //                                             ),
      //                                             padding: EdgeInsets.only(
      //                                                 bottom: 10, left: 5),
      //                                           ),
      //                                         ),
      //                                         // Padding(child:Text("Skill: "+widget.skill.name,style: TextStyle(fontFamily: "Fredoka-Medium",fontSize: 20,decoration: TextDecoration.underline),),padding: EdgeInsets.only(bottom:10,right: 5),)
      //                                         Expanded(
      //                                           child: Padding(
      //                                               padding: EdgeInsets.only(
      //                                                   left: 5,
      //                                                   right: 10,
      //                                                   bottom: 5),
      //                                               child: Row(
      //                                                   crossAxisAlignment:
      //                                                       CrossAxisAlignment
      //                                                           .stretch,
      //                                                   children: [
      //                                                     Expanded(
      //                                                         child: Padding(
      //                                                       child: Text(
      //                                                         "Skill: Communication Skills",
      //                                                         style: TextStyle(
      //                                                             fontFamily:
      //                                                                 "Fredoka-Medium",
      //                                                             fontSize: 15,
      //                                                             decoration:
      //                                                                 TextDecoration
      //                                                                     .underline),
      //                                                       ),
      //                                                       padding:
      //                                                           EdgeInsets.only(
      //                                                               right: 10),
      //                                                     )),
      //                                                     Image.asset(
      //                                                       "lib/assets/rewardBadge.png",
      //                                                       width: 45,
      //                                                       height: 45,
      //                                                     )
      //                                                   ])),
      //                                         ),
      //                                         // Padding(padding: EdgeInsets.only(left: 5,bottom: 5),child: Text("Date: "+skill.rewardedDate,style: TextStyle(fontFamily: "Fredoka-Medium",fontSize: 15),),)
      //                                         Padding(
      //                                           padding: EdgeInsets.only(
      //                                               right: 5, bottom: 5),
      //                                           child: Text(
      //                                             "Date: 25/12/2022",
      //                                             style: TextStyle(
      //                                                 fontFamily:
      //                                                     "Fredoka-Medium",
      //                                                 fontSize: 15),
      //                                           ),
      //                                         )
      //                                       ]),
      //                                     ))))))
      //                       })),
      //         padding: EdgeInsets.only(left: 10))
      //   ],
      // )
    );
  }
}
