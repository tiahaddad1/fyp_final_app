import 'package:flutter/material.dart';
import 'package:fyp_application/api/firebase_api.dart';

import '../../Model/Reminder.dart';

class caregiverReminderComp extends StatefulWidget {
  final Reminder? reminder;
  const caregiverReminderComp({super.key, this.reminder});

  @override
  State<caregiverReminderComp> createState() => _caregiverReminderCompState();
}



class _caregiverReminderCompState extends State<caregiverReminderComp> {
  TextEditingController reminderNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color.fromARGB(255, 190, 190, 190),
            blurRadius: 1,
            spreadRadius: 1)
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
            padding: EdgeInsets.only(left: 20, top: 5, right: 5),
            child: Container(
              child: TextField(
                  controller: reminderNameController,
                  textAlign: TextAlign.left,
                  readOnly: false,
                  showCursor: true,
                  cursorColor: Color.fromARGB(255, 66, 135, 123),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.reminder!.name == ""||widget.reminder!.name == null
                        ? "Edit to add a reminder"
                        : widget.reminder!.name,
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: "Cabin-Regular"),
                  )),
              width: 250,
              height: 70,
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 7, bottom: 10),
                child: Image.asset(
                  "lib/assets/editCont.png",
                  width: 15,
                  height: 15,
                ),
              ),
              onTap: () async {
                await FirebaseApi.updateReminder(
                    widget.reminder!.reminder_id, reminderNameController.text);
                //save to DB
              },
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 7, bottom: 5),
                child: Image.asset(
                  "lib/assets/delete.png",
                  width: 15,
                  height: 15,
                ),
              ),
              onTap: () {
                FirebaseApi.deleteReminder(widget.reminder!);
              },
            )
          ],
        )
      ]),
    );
  }
}
