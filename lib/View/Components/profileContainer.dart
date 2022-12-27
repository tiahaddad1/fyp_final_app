import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class profileContainer extends StatefulWidget {
  final String text;
  final String image;

  const profileContainer(
      {super.key, required this.text, required this.image});

  @override
  State<profileContainer> createState() => _profileContainerState();
}

class _profileContainerState extends State<profileContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      width: 130,
      height: 120,
      child: Column(children: [
        Padding(child: Text(
        widget.text,
        style: TextStyle(
            color: Color.fromARGB(255, 63,62,59),
            fontFamily: "Fredoka-Medium",
            fontSize: 19),
      ),padding: EdgeInsets.only(bottom: 5),),
      // Padding(child: 
      Image.asset(widget.image,width: 65,height: 65,)
      // ,padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),)
      ])
    );
  }
}
