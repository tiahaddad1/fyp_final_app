import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/buttonImageComp.dart';

import 'Components/caregiverRewardComp.dart';

class caregiverRewards extends StatefulWidget {
  const caregiverRewards({super.key});

  @override
  State<caregiverRewards> createState() => _caregiverRewardsState();
}

class _caregiverRewardsState extends State<caregiverRewards> {
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
                    "Liam" + "'s rewards:",
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
                            // containerList.map(((e) => e)).toList() -> a map to iterate through array
                            //when pressed add it to array and this array has all the comp from DB too
                            caregiverRewardComp(
                              text: "A trip to adventure land!",
                              image: "lib/assets/footballClipart.png",
                              reward: '15',
                            ),
                            caregiverRewardComp(
                              text: "A trip to adventure land!",
                              image: "lib/assets/footballClipart.png",
                              reward: '15',
                            ),
                            caregiverRewardComp(
                              text: "A trip to adventure land!",
                              image: "lib/assets/footballClipart.png",
                              reward: '15',
                            ),
                            caregiverRewardComp(
                              text: "A trip to adventure land!",
                              image: "lib/assets/footballClipart.png",
                              reward: '15',
                            ),
                            caregiverRewardComp(
                              text: "A trip to adventure land!",
                              image: "lib/assets/footballClipart.png",
                              reward: '15',
                            ),
                            // caregiverReminderComp(reminder: "Pray daily prayers"),
                          ])),
                ))),
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: buttonImage(
                        image: "lib/assets/starTotal.png",
                        text: "Add Reward",
                        function: {
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
                              Container(), //for the table rewards, with scrolls and everything
                              Container(
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Total points earned: " + "20",
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          )))))
        ],
      ),
    );
  }
}
