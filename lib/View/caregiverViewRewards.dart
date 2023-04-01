import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/Reward.dart';
import 'package:fyp_application/View/Components/addNewRewardCaregiver.dart';
import 'package:fyp_application/View/Components/buttonImageComp.dart';
import 'package:fyp_application/api/firebase_api.dart';

import '../Model/Learner.dart';
import 'Components/caregiverRewardComp.dart';
import 'Components/rewardStarComp.dart';

class caregiverRewards extends StatefulWidget {
  final String learner_id;
  final Learner learner;
  const caregiverRewards({super.key, required this.learner_id, required this.learner});

  @override
  State<caregiverRewards> createState() => _caregiverRewardsState();
}

class _caregiverRewardsState extends State<caregiverRewards> {
  late List<int> rewards;
  late int totalPoints = 0;
  @override
  void setState(_) {
    // TODO: implement setState
    rewards;
    totalPoints;
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 35, right: 10),
                  child: Text(
                    widget.learner.first_name.substring(0,1).toUpperCase()+widget.learner.first_name.substring(1) + "'s rewards:",
                    style: TextStyle(
                        fontFamily: "Cabin-Regular",
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: SafeArea(
                        child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      alignment: Alignment.center,
                      // height: 200,
                      // width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder<List<Reward>>(
                              future:
                                  FirebaseApi.getAllRewards(widget.learner_id),
                              builder: (context, snapshot) {
                                // if (snapshot.hasData) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    print("okayyyy: ");
                                    print(snapshot.data!);
                                    List<Reward> rewards = snapshot.data!;
                                    // print(skills);
                                    return ListView.builder(
                                        itemCount: rewards.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: ((context, index) {
                                          final doc = rewards[index];
                                          print(doc.name);
                                          return caregiverRewardComp(
                                            rewardObj: doc,
                                            text: doc.name,
                                            image: doc.image,
                                            reward: doc.points.toString(),
                                          );
                                        }));
                                  } else {
                                    return Container(
                                        margin: EdgeInsets.all(20),
                                        child: Center(
                                          child: Text(
                                            "No rewards assigned...",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                        ));
                                  }
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                      margin: EdgeInsets.all(15),
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                } else {
                                  return Container(
                                      margin: EdgeInsets.all(20),
                                      child: Center(
                                        child: Text(
                                          "No rewards assigned...",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                      ));
                                }
                              },
                            )
                          ])),
                ))),
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: buttonImage(
                        image: "lib/assets/starTotal.png",
                        text: "Add Reward",
                        function: () {
                          showDialog(
                              context: context,
                              builder: (context) => addNewRewardCaregiver(
                                  learner_id: widget.learner_id));
                          //should be able to view a pop up for adding a new reward
                        },
                        color: Color.fromARGB(255, 66, 135, 123)),
                    alignment: Alignment.center),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 224, 227, 238),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: MediaQuery.of(context).size.height / 2.6,
              width: double.infinity,
              child: Expanded(
                  child: SafeArea(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Rewards board",
                                    style: TextStyle(
                                        fontFamily: "Fredoka-Medium",
                                        fontSize: 20,
                                        color: Colors.black),
                                  )),
                              Container(
                                height: MediaQuery.of(context).size.height / 5,
                                child: FutureBuilder<List<int>>(
                                    future: FirebaseApi.getRewardsPoints(
                                        widget.learner_id),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        rewards = snapshot.data!;
                                        totalPoints = rewards.fold(
                                            0,
                                            (previous, current) =>
                                                previous + current);
                                        setState(() {
                                          totalPoints;
                                        });
                                        print(totalPoints);
                                        print(rewards);
                                        return Column(children: [Expanded(
                                          //fix the design layout
                                          child: SafeArea(
                                              child: GridView.builder(
                                            itemCount: snapshot.data!.length,
                                            padding: EdgeInsets.only(
                                                top: 20, left: 10, right: 10),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              final doc = snapshot.data![index];
                                              return Center(
                                                  child: Wrap(children: [
                                                rewardStarComp(reward: doc),
                                              ]));
                                            },
                                            gridDelegate:
                                                new SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 6,
                                                    childAspectRatio: 1,
                                                    crossAxisSpacing: 0,
                                                    mainAxisSpacing: 1),
                                          )),
                                        ),
                                        Container(
                                margin: EdgeInsets.all(15),
                                alignment: Alignment.center,
                                child: Text(
                                  "Total points earned: " +
                                      totalPoints.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              )]);
                                      } else {
                                        return Container(
                                            margin: EdgeInsets.all(20),
                                            child: Center(
                                              child: Text(
                                                "No rewarded points achieved yet...",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              ),
                                            ));
                                      }
                                    }),
                              ),
                              // Container(
                              //   margin: EdgeInsets.all(15),
                              //   alignment: Alignment.center,
                              //   child: Text(
                              //     "Total points earned: " +
                              //         totalPoints.toString(),
                              //     style: TextStyle(
                              //         color: Colors.black,
                              //         decoration: TextDecoration.underline,
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.w600),
                              //   ),
                              // )
                            ],
                          )))))
        ],
      ),
    );
  }
}
