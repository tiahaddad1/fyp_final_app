import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/skillLearnerComponent.dart';

class learnerSkills extends StatefulWidget {
  const learnerSkills({super.key});

  @override
  State<learnerSkills> createState() => _learnerSkillsState();
}

class _learnerSkillsState extends State<learnerSkills> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        Container(
          height: 150,
          padding: EdgeInsets.all(50),
          child: Stack(alignment: Alignment.topRight, children: <Widget>[
            Text("Skills I want to gain!",
                style: TextStyle(fontFamily: "Fredoka-Medium", fontSize: 30,fontWeight: FontWeight.w600)),
            Positioned(
              bottom: 1,
              right: -19,
              child: Image.asset(
                "lib/assets/sparkleTitle.png",
                width: 45,
                height: 40,
              ),
            ),
          ]),
        ),
        SingleChildScrollView(
          child:Container(
            padding: EdgeInsets.only(left:10,right: 10),
            height: 450,
            child: ListView(
                 children: [
                  Padding(padding: EdgeInsets.only(bottom:15),child:skillComponent()),
                  Padding(padding: EdgeInsets.only(bottom:15),child:skillComponent()),
                ]),

        ))
      ]),
    );

  }
}
