import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'closeButton.dart';

class newRewardComponent extends StatefulWidget {
  const newRewardComponent({super.key});

  @override
  State<newRewardComponent> createState() => _newRewardComponentState();
}

class _newRewardComponentState extends State<newRewardComponent> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [closeButton()],
        backgroundColor: Color.fromARGB(255, 241, 238, 238),
        content: Container(
          height: 270,
          width: double.infinity,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: Text(
                      "New Reward",
                      style: TextStyle(
                          fontFamily: "Fredoka-Medium",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
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
                    padding: EdgeInsets.only(bottom: 20),
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
                            "Reward Points",
                            style: TextStyle(
                                fontFamily: "Fredoka-Medium",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
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
                                fontFamily: "Fredoka-Medium",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
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
                padding: EdgeInsets.only(bottom: 20),
              ),
              SizedBox(
                  width: 95,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      onPressed:
                      Navigator.of(context).pop;
                      //add details to db
                    },
                    child: Padding(
                      child: Text("Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Fredoka-SemiBold",
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 10, 207, 131))),
                  ))
            ],
          ),
        ));
  }
}
