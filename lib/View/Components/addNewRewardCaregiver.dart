import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/doneButtonCaregiver.dart';

class addNewRewardCaregiver extends StatefulWidget {
  const addNewRewardCaregiver({super.key});

  @override
  State<addNewRewardCaregiver> createState() => _addNewRewardCaregiverState();
}

class _addNewRewardCaregiverState extends State<addNewRewardCaregiver> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true), // passing false
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.red[900]),
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 241, 238, 238),
        content: Container(
            height: 265,
            width: double.infinity,
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: Text(
                      "New Reward",
                      style: TextStyle(
                          fontFamily: "Cabin-Regular",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color.fromARGB(255, 3, 20, 66)),
                    ),
                    padding: EdgeInsets.only(left: 5, bottom: 10),
                  ),
                  Padding(
                    child: TextField(
                      cursorColor: Color.fromARGB(255, 100, 100, 100),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 217, 217, 217),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 217, 217, 217))),
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: 5),
                  )
                ],
              ),
              Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          child: Text(
                            "Points",
                            style: TextStyle(
                                fontFamily: "Cabin-Regular",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color.fromARGB(255, 3, 20, 66)),
                          ),
                          padding: EdgeInsets.only(left: 5, bottom: 10),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: Color.fromARGB(255, 100, 100, 100),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 217, 217, 217),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 217, 217, 217))),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          child: Text(
                            "Add Image",
                            style: TextStyle(
                                fontFamily: "Cabin-Regular",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color.fromARGB(255, 3, 20, 66)),
                          ),
                          padding: EdgeInsets.only(left: 5, bottom: 10),
                        ),
                        GestureDetector(
                          onTap: () {
                            //upload image!
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 217, 217, 217)),
                              width: 90,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "lib/assets/addImage.png",
                                width: 40,
                                height: 40,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
                padding: EdgeInsets.only(bottom: 20, top: 20),
              ),
              doneButtonCaregiver(
                function: () {},
              ), //code to save to database, take the values from texteditcontroller
            ])));
  }
}
