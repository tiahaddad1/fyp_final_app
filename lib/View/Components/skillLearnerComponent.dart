import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class skillComponent extends StatefulWidget {
  const skillComponent({super.key});

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
            child: RichText(text:TextSpan(text:"view certificate",
                style: TextStyle(
                  color: Color.fromARGB(255, 62, 81, 140),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                          ..onTap = () => {//pop up show
                          }
                )),
                
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
