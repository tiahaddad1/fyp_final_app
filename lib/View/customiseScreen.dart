import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Components/chooseImageComponent.dart';

class customiseScreen extends StatefulWidget {
  const customiseScreen({super.key});

  @override
  State<customiseScreen> createState() => _customiseScreenState();
}

class _customiseScreenState extends State<customiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                primary: Color.fromARGB(255, 240, 240, 240),
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
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            toolbarHeight: 150,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "Pick a theme please:",
                  style: TextStyle(
                      fontFamily: "Fredoka-Medium",
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 3, 20, 66),
                      fontSize: 28),
                ),
              )
            ])),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(children: [
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: chooseImageComponent(
                          image: "lib/assets/space.webp",
                          text: "Space",
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: chooseImageComponent(
                          image: "lib/assets/princess.jpeg",
                          text: "Princess",
                        )),
                  ])),
              Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Row(children: [
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: chooseImageComponent(
                          image: "lib/assets/cars.webp",
                          text: "Cars",
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: chooseImageComponent(
                          image: "lib/assets/barbie.jpeg",
                          text: "Barbie",
                        )),
                  ])),
              Padding(
                padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: chooseImageComponent(
                        image: "lib/assets/animals.webp",
                        text: "Animals",
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: chooseImageComponent(
                        image: "lib/assets/addPlus.png",
                        text: "Customise",
                        function: () {
                          print("put code for uploading image and save to db!");
                        },
                      )),
                ]),
              )
            ]));
  }
}
