import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class newSkillComp extends StatefulWidget {
  const newSkillComp({super.key});

  @override
  State<newSkillComp> createState() => _newSkillCompState();
}

class _newSkillCompState extends State<newSkillComp> {
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
          height: 210,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: Text(
                      "Skill:",
                      style: TextStyle(
                          fontFamily: "Cabin-Regular",
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Color.fromARGB(255, 3, 20, 66)),
                    ),
                    padding: EdgeInsets.only(left: 5, right: 15),
                  ),
                  Padding(
                    child: Container(
                        width: 170,
                        height: 30,
                        child: TextField(
                          cursorColor: Color.fromARGB(255, 100, 100, 100),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 8.0,
                              bottom: 5.0,
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 217, 217, 217),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 217, 217, 217))),
                          ),
                        )),
                    padding: EdgeInsets.only(bottom: 20, right: 10),
                  )
                ],
              ),
              Padding(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      child: Text(
                        "Upload image:",
                        style: TextStyle(
                            fontFamily: "Cabin-Regular",
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: Color.fromARGB(255, 3, 20, 66)),
                      ),
                      padding: EdgeInsets.only(left: 5, bottom: 10, right: 15),
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
                padding: EdgeInsets.only(bottom: 20, right: 10),
              ),
              SizedBox(
                  width: 95,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      //add details to db
                      Navigator.of(context).pop;
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
                            Color.fromARGB(255, 66, 135, 123))),
                  ))
            ],
          )
          // ]),
          //     Padding(
          //       child:
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 child: Text(
          //                   "Upload image:",
          //                   style: TextStyle(
          //                       fontFamily: "Fredoka-Medium",
          //                       fontWeight: FontWeight.w700,
          //                       fontSize: 18,
          //                       color: Color.fromARGB(255, 3, 20, 66)),
          //                 ),
          //                 padding: EdgeInsets.only(left: 5, bottom: 10),
          //               ),
          //               GestureDetector(
          //                 onTap: () {
          //                   //upload image!
          //                 },
          //                 child: Container(
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(20),
          //                         color: Color.fromARGB(255, 217, 217, 217)),
          //                     width: 90,
          //                     padding: EdgeInsets.only(top: 5, bottom: 5),
          //                     alignment: Alignment.center,
          //                     child: Image.asset(
          //                       "lib/assets/addImage.png",
          //                       width: 40,
          //                       height: 40,
          //                     )),
          //               )
          //             ],
          //           ),
          //       padding: EdgeInsets.only(bottom: 20),
          //     ),
          //     SizedBox(
          //         width: 95,
          //         height: 40,
          //         child: ElevatedButton(
          //           onPressed: () {
          //             //add details to db
          //           Navigator.of(context).pop;
          //           },
          //           child: Padding(
          //             child: Text("Done",
          //                 style: TextStyle(
          //                     color: Colors.white,
          //                     fontFamily: "Fredoka-SemiBold",
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 15)),
          //             padding: EdgeInsets.only(
          //                 left: 10, right: 10, top: 5, bottom: 5),
          //           ),
          //           style: ButtonStyle(
          //               shape:
          //                   MaterialStateProperty.all<RoundedRectangleBorder>(
          //                       RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(20.0))),
          //               backgroundColor: MaterialStatePropertyAll<Color>(
          //                   Color.fromARGB(255, 66,135,123))),
          //         ))
          //   ],
          // )
          ),
    );
  }
}
