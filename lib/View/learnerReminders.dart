import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/reminderContainer.dart';

class learnerReminders extends StatefulWidget {
  const learnerReminders({super.key});

  @override
  State<learnerReminders> createState() => _learnerRemindersState();
}

class _learnerRemindersState extends State<learnerReminders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
              padding:
                  EdgeInsets.only(top: 30, bottom: 25, left: 18, right: 10),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Text(
                        "Daily Reminders:",
                        style: TextStyle(
                            fontFamily: "Fredoka-Medium", fontSize: 27,fontWeight: FontWeight.w600),
                      )),
                  Stack(alignment: Alignment.topRight, children: <Widget>[
                    Image.asset(
                      "lib/assets/reminderBell.png",
                      width: 75,
                      height: 75,
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 234, 126, 208),
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("5",
                            // child: Text(reminders.size().toString(),
                                style: TextStyle(
                                    fontFamily: "FredokaOne-Regular",
                                    fontSize: 27)),
                          ),
                        ))
                  ])
                ],
              )),
          Padding(padding: EdgeInsets.only(bottom: 10, left: 18, right: 18),child:
          Column(
            children: [
              Image.asset("lib/assets/wire.png",width: 330),
              SingleChildScrollView(
              child:Container(
                padding: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
                  color: Color.fromARGB(255, 240,240,240),
                ),
                width:330,
                height:450,
                child: 
                ListView(
                 children: [
                    reminderContainer(),
                    reminderContainer(),
                ]),

                // ListView(
                //  children: [
                //   reminders.forEach((reminder)=>{
                //     reminderContainer(reminder: reminder)
                //   })
                // ]),

              ))
            ],
          ))
        ],
      ),
    );
  }
}
