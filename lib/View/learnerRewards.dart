import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/rewardViewComponent.dart';

import 'Components/addNewRewardComponent.dart';

class learnerRewards extends StatefulWidget {
  const learnerRewards({super.key});

  @override
  State<learnerRewards> createState() => _learnerRewardsState();
}

class _learnerRewardsState extends State<learnerRewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 249, 249, 250),
        appBar: AppBar(
          leading: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(5),
              primary: Color.fromARGB(255, 255, 235, 164),
            ),
            icon: Icon(Icons.arrow_back_ios_new,
                color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () => Navigator.of(context).pop(),
            label: const Text(
              "",
            ),
          ),
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          backgroundColor: Color.fromARGB(255, 255, 235, 164),
          toolbarHeight: 170,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                padding: EdgeInsets.only(right: 15),
                height: 60,
                width: double.infinity,
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "lib/assets/rewardStars.png",
                      width: 70,
                      height: 57,
                    ),
                    Image.asset(
                      "lib/assets/rewardStars.png",
                      width: 70,
                      height: 57,
                    )
                  ],
                )),
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "My Rewards",
                style: TextStyle(
                    color: Color.fromARGB(255, 25, 46, 100),
                    fontSize: 33,
                    fontFamily: "FredokaOne-Regular"),
              ),
            ),
            Container(
                height: 60,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "lib/assets/rewardStars.png",
                      width: 70,
                      height: 57,
                    ),
                    Image.asset(
                      "lib/assets/rewardStars.png",
                      width: 70,
                      height: 57,
                    )
                  ],
                )),
          ]),
        ),
        body: Column(children: [
          Container(
              margin: EdgeInsets.only(top: 20, left: 15, right: 15),
              padding: EdgeInsets.only(bottom: 7, top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 25, 46, 100)),
              child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 17, top: 15, bottom: 15),
                        child: RichText(
                            text: TextSpan(
                                text: "I earned ",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontFamily: "Fredoka-Medium"),
                                children: <TextSpan>[
                              TextSpan(
                                  text: "25 ",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 10, 207, 131))),
                              TextSpan(
                                  text: "stars!",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ]))),
                    Image.asset(
                      "lib/assets/starTotal.png",
                      width: 40,
                      height: 40,
                    ),
                  ])),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            GestureDetector(
                onTap: () {
                  print("helppp");
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, right: 20),
                  child: Image.asset(
                    "lib/assets/helpIcon.png",
                    width: 25,
                    height: 25,
                  ),
                ))
          ]),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 25, bottom: 20),
            child: Text(
              "Rewards:",
              style: TextStyle(
                  fontFamily: "Fredoka-Medium",
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontSize: 23),
            ),
          ),
          
          Expanded( 
              child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              rewardViewComponent(
                text: "Play football with Sam.",
                image: "lib/assets/footballClipart.png",
                reward: "5",
                addNew: false,
              ),
              rewardViewComponent(
                text: "Play football with Sam.",
                image: "lib/assets/footballClipart.png",
                reward: "5",
                addNew: false,
              ),
              GestureDetector(
                child: rewardViewComponent(
                  text: "Play football with Sam.",
                  image: "lib/assets/footballClipart.png",
                  reward: "5",
                  addNew: true,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => newRewardComponent());
                },
              ),
            ],
          ))
        ]));
  }
}
