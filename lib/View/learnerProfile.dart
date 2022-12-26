import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class learnerProfile extends StatefulWidget {
  const learnerProfile({super.key});

  @override
  State<learnerProfile> createState() => _learnerProfileState();
}

class _learnerProfileState extends State<learnerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromARGB(255, 190, 166, 221),
        toolbarHeight: 200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Container(
            child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(55), // Image radius
                  child: Image.asset("lib/assets/user1.png", fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      child: Text(
                        "Liam Harrison",
                        style: TextStyle(
                            color: Color.fromARGB(255, 63, 62, 59),
                            fontSize: 27,
                            fontFamily: "FredokaOne-Regular"),
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    Padding(
                      child: Row(
                        children: [
                          Image.asset(
                            "lib/assets/star.png",
                            width: 20,
                            height: 20,
                          ),
                          Padding(
                            child: Text("25",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontFamily: "Fredoka-Medium")),
                            padding: EdgeInsets.only(left: 5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    Text(
                      "my age: " + "12" + " years old",
                      style: TextStyle(
                          color: Color.fromARGB(255, 240, 240, 240),
                          fontSize: 18,
                          fontFamily: "Fredoka-SemiBold"),
                    ),
                  ]),
            )
          ],
        )),
      ),
      backgroundColor: Color.fromARGB(255, 249, 249, 250),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, bottom: 15),
            child: Text(
              "About me:",
              style: TextStyle(
                  fontFamily: "Fredoka-Medium",
                  fontSize: 20,
                  color: Colors.black),
            ),
          ),
          GestureDetector(
              onTap: () {
                print("clicked!");
              },
              child: Stack(alignment: Alignment.topRight, children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 100,
                  child: Text(
                    "blah blah blah...",
                    style: TextStyle(
                        color: Color.fromARGB(255, 49, 48, 46),
                        fontFamily: "Fredoka-SemiBold",
                        fontSize: 15),
                  ),
                ),
                Positioned(
                    bottom: 14,
                    right: 13,
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(5)),
                        color: Color.fromARGB(121, 217, 217, 217),
                        shape: BoxShape.rectangle,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Padding(
                              child: Image.asset(
                                "lib/assets/pencil.png",
                                width: 18,
                                height: 18,
                              ),
                              padding: EdgeInsets.only(top: 5, left: 5),
                            ),
                            Padding(
                              child: Text("edit",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Fredoka-Medium",
                                      fontSize: 13)),
                              padding: EdgeInsets.only(bottom: 5),
                            )
                          ],
                        ),
                      ),
                    ))
              ])),
        ],
      ),
    );
  }
}
