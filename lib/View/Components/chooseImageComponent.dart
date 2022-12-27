import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class chooseImageComponent extends StatefulWidget {
  final String image;
  final String text;
  final function;

  const chooseImageComponent(
      {super.key, required this.image, required this.text, this.function});

  @override
  State<chooseImageComponent> createState() => _chooseImageComponentState();
}

bool imageClick = false;

class _chooseImageComponentState extends State<chooseImageComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
        padding: EdgeInsets.only(top: 5),
        width: 160,
        height: 180,
        child: Column(children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: imageClick == false
                        ? Colors.grey.withOpacity(0.2)
                        : Color.fromARGB(255, 132, 223, 137)!,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              width: 150,
              height: 120,
              child: GestureDetector(
                  onTap: () {
                    if (widget.function == null) {
                      setState(() {
                        imageClick = true;
                      });
                      print("clicked on an image");
                    } else {
                      widget.function();
                    }
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(50), // Image radius
                        child: Image.asset(widget.image, fit: BoxFit.cover),
                      )))),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                widget.text,
                style: TextStyle(
                    color: Color.fromARGB(255, 63, 62, 59),
                    fontFamily: "Fredoka-Medium",
                    fontSize: 20),
              ),
            ),
          )
        ]));
  }
}
