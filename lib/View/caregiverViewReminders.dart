import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/buttonComponent.dart';
import 'package:fyp_application/View/Components/buttonImageComp.dart';
import 'package:fyp_application/View/Components/caregiverReminderComp.dart';

class caregiverReminders extends StatefulWidget {
  const caregiverReminders({super.key});

  @override
  State<caregiverReminders> createState() => _caregiverRemindersState();
}

class _caregiverRemindersState extends State<caregiverReminders> {
  bool clicked = false;
  List<Widget> containerList = [];
  returnComp() {
      containerList.add(caregiverReminderComp(reminder: "Add new Reminder"));
  }
Widget _getListWidgets(List<Widget> yourList){
  containerList.add(caregiverReminderComp(reminder: "Add new Reminder"));
   return Row(children: yourList.map((i) => i).toList());
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Text(
                  "Liam" + "'s daily reminders:",
                  style: TextStyle(
                      fontFamily: "Cabin-Regular",
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                child: Image.asset(
                  "lib/assets/pinDetailIcon.png",
                  width: 35,
                  height: 35,
                ),
                padding: EdgeInsets.only(left: 5, right: 5),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    // containerList.map(((e) => e)).toList() -> a map to iterate through array
                    //when pressed add it to array and this array has all the comp from DB too
                    caregiverReminderComp(reminder: "Pray daily prayers"),
                    // caregiverReminderComp(reminder: "Pray daily prayers"),

         ] )),
          ),
          Container(
              child: buttonImage(
                  image: "lib/assets/bellImage.png",
                  text: "Add Reminder",
                  function: {
                    returnComp(),
                    print(containerList),
                    setState(
                      () {
                        clicked = true;
                      },
                    )
                  },
                  color: Color.fromARGB(255, 66, 135, 123)),
              alignment: Alignment.center),
        ],
      ),
    );
  }
}
