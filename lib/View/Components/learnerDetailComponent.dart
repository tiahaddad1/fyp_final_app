import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class learnerDetailComp extends StatefulWidget {
  final String image;
  final String name;
  final Widget page;

  const learnerDetailComp(
      {super.key, required this.image, required this.name, required this.page});

  @override
  State<learnerDetailComp> createState() => _learnerDetailCompState();
}

class _learnerDetailCompState extends State<learnerDetailComp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        width: 220,
        margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 199, 226, 216)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Image.asset(
              widget.image,
              width: 32,
              height: 32,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              widget.name,
              style: TextStyle(
                  fontFamily: "lib/assets/Cabin-Regular",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          )
        ]),
      ),
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => widget.page));
        print("pushed");
      },
    );
  }
}
