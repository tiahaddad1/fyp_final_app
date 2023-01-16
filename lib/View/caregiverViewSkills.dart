import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/Skill.dart';
import 'package:fyp_application/View/Components/addNewSkill.dart';
import 'package:fyp_application/View/Components/buttonImageComp.dart';
import 'package:fyp_application/View/Components/caregiverSkillComp.dart';
import 'package:fyp_application/api/firebase_api.dart';

class caregiverSkills extends StatefulWidget {
  final String learner_id;
  const caregiverSkills({super.key, required this.learner_id});

  @override
  State<caregiverSkills> createState() => _caregiverSkillsState();
}

class _caregiverSkillsState extends State<caregiverSkills> {
  List<Skill> skills = [];
  @override
  void setState(_) {
    skills;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 240, 240, 240),
          toolbarHeight: 50,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(5),
              primary: Color.fromARGB(255, 240, 240, 240),
            ),
            icon: Icon(Icons.arrow_back_ios_new,
                color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () => Navigator.of(context).pop(),
            label: const Text(
              "",
            ),
          ),
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, right: 10),
                child: Text(
                  "Liam" + "'s skills:",
                  style: TextStyle(
                      fontFamily: "Cabin-Regular",
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                child: Image.asset(
                  "lib/assets/skillDetailIcon.png",
                  width: 50,
                  height: 50,
                ),
                padding: EdgeInsets.only(left: 5, right: 25),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          SafeArea(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        FutureBuilder<List<Skill>>(
                          future: FirebaseApi.getAllSkills(widget.learner_id),
                          builder: (context, snapshot) {
                            // List<Skill> skills =[];
                            // if (snapshot.hasData) {
                            // if (snapshot.connectionState ==
                            //     ConnectionState.done) {
                            if (snapshot.hasData) {
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
                                    return caregiverSkillComp(
                                        skill: doc,
                                        skill_id: doc.skill_id,
                                        image: doc.image,
                                        name: doc.name);
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
                        )
                        //iterate through from DB
                        // caregiverSkillComp(
                        //     image: "lib/assets/footballClipart.png",
                        //     name: "Communication Skills")
                      ])))),
          Container(
              child: buttonImage(
                  image: "lib/assets/skill.png",
                  text: "Add Skill",
                  function: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            newSkillComp(learner_id: widget.learner_id));
                  },
                  color: Color.fromARGB(255, 66, 135, 123)),
              alignment: Alignment.center),
        ]));
  }
}
