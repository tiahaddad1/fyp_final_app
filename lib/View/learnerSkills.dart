import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/skillLearnerComponent.dart';

import '../Model/Learner.dart';
import '../Model/Skill.dart';
import '../api/firebase_api.dart';
import 'learnerProfile.dart';

class learnerSkills extends StatefulWidget {
  const learnerSkills({super.key});

  @override
  State<learnerSkills> createState() => _learnerSkillsState();
}

class _learnerSkillsState extends State<learnerSkills> {
  List<Skill> skills = [];
  String s = "";
  // late Learner learner;
  @override
  void setState(_) {
    skills;
    s;
    // learner;
  }

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
                style: TextStyle(
                    fontFamily: "Fredoka-Medium",
                    fontSize: 30,
                    fontWeight: FontWeight.w600)),
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
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 450,
                child: FutureBuilder<Learner>(
                  future: FirebaseApi.getCurrentLearner(currentUser),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Learner learner = snapshot.data!;
                      s = learner.first_name.toString();
                      setState(() {
                        learner = snapshot.data!;
                        s = learner.first_name.toString();
                        print(s);
                      });

                      print("Learner: " + s);
                      return FutureBuilder<List<Skill>>(
                        future:
                            FirebaseApi.getAllSkills(snapshot.data!.user_id),
                        builder: (context, snapshot) {
                          // List<Skill> skills =[];
                          // if (snapshot.hasData) {
                          // if (snapshot.connectionState ==
                          //     ConnectionState.done) {
                          if (snapshot.hasData) {
                            print("Learner2: " + s);
                            // print("okayyyy: ");
                            // print(snapshot.data!);
                            skills = snapshot.data!;
                            print("here here");
                            print(skills.length);
                            return ListView.builder(
                                itemCount: skills.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: ((context, index) {
                                  final doc = skills[index];
                                  print(doc.name);
                                  return Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: skillComponent(
                                          skill: doc,learner: s,));
                                }));
                          }
                          // else if(snapshot.connectionState==ConnectionState.waiting){
                          else if (snapshot.hasError) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Container(
                                margin: EdgeInsets.all(20),
                                child: Center(
                                  child: Text(
                                    "No skills assigned...",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ));
                          }
                        },
                      );
                    } else {
                      return Container(
                          child: Center(
                        child: Image.asset(
                          "lib/assets/noData.png",
                          width: 50,
                          height: 55,
                        ),
                      ));
                    }
                  },
                )

                ))
      ]),
    );
  }
}
