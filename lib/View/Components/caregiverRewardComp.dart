import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/api/firebase_api.dart';

import '../../Model/Reward.dart';

class caregiverRewardComp extends StatefulWidget {
  final Reward rewardObj;
  final String text;
  final String image;
  final String reward;

  const caregiverRewardComp({
    super.key,
    required this.rewardObj,
    required this.text,
    required this.image,
    required this.reward,
  });

  @override
  State<caregiverRewardComp> createState() => _caregiverRewardCompState();
}

final rewardNameController = TextEditingController();
final pointsController = TextEditingController();

class _caregiverRewardCompState extends State<caregiverRewardComp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5, bottom: 20, top: 10),
      width: 320,
      height: 70,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ], borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 70,
            padding: EdgeInsets.all(5),
            child: Image.asset(widget.image),
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            )),
          ),
          Container(
            alignment: Alignment.center,
            width: 200,
            height: 70,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            )),
            // padding: EdgeInsets.only(left:5,right:2,top7),
            child: TextField(
              controller: rewardNameController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.text,
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontFamily: "Fredoka-Medium"),
              ),
              style: TextStyle(
                  fontFamily: "Fredoka-Medium",
                  color: Colors.black,
                  fontSize: 16),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Color.fromARGB(255, 224, 227, 238),
              ),
              width: 60,
              height: 70,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      controller: pointsController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "+" + widget.reward,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 80, 169, 154),
                            fontSize: 20,
                            fontFamily: "Fredoka-Medium"),
                      ),
                      style: TextStyle(
                          fontFamily: "Fredoka-Medium",
                          color: Color.fromARGB(255, 80, 169, 154),
                          fontSize: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 10, right: 7, bottom: 10),
                          child: Image.asset(
                            "lib/assets/editCont.png",
                            width: 15,
                            height: 15,
                          ),
                        ),
                        onTap: () async {
                          await FirebaseApi.updateReward(
                              widget.rewardObj.reward_id,
                              rewardNameController.text,
                              int.parse(pointsController.text));
                          //update and save to DB
                        },
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 5),
                          child: Image.asset(
                            "lib/assets/delete.png",
                            width: 15,
                            height: 15,
                          ),
                        ),
                        onTap: () async {
                          await FirebaseApi.deleteReward(widget.rewardObj);
                          //delete from DB
                        },
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
