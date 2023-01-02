import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class caregiverSkillComp extends StatefulWidget {
  final String image;
  final String name;

  const caregiverSkillComp(
      {super.key, required this.image, required this.name});

  @override
  State<caregiverSkillComp> createState() => _caregiverSkillCompState();
}

class _caregiverSkillCompState extends State<caregiverSkillComp> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color.fromARGB(255, 190, 190, 190),
            blurRadius: 1,
            spreadRadius: 1)
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: CheckboxListTile(
          // title: Text(widget.reminder.name),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.only(left: 5, right: 2, top: 3, bottom: 7),
                child: Image.asset(
                  widget.image,
                  width: 35,
                  height: 35,
                )),
            Padding(
                padding: EdgeInsets.only(left: 20, top: 5, right: 5),
                child: Container(
                  child: TextField(
                      textAlign: TextAlign.left,
                      readOnly: false,
                      onChanged: (value) {
                        //save to DB
                      },
                      showCursor: true,
                      cursorColor: Color.fromARGB(255, 66, 135, 123),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.name,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: "Cabin-Regular"),
                      )),
                  width: 150,
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
                  onTap: () {
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
                    //delete from DB
                  },
                )
              ],
            )
          ]),
          value: checked,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? b) {
            setState(() {
              checked = b!;
            });
          }),
    );
  }
}
