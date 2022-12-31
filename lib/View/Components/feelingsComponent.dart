import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Model/FeelingsData.dart';

class feelingComp extends StatefulWidget {
  final String feeling;
  final String time;

  const feelingComp({super.key, required this.feeling, required this.time});

  @override
  State<feelingComp> createState() => _feelingCompState();
}

class _feelingCompState extends State<feelingComp> {
  //a function that returns an image of what feeling has been provided by the learner

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      height: 115,
      width: 130,
      margin: EdgeInsets.only(left: 5, bottom: 20, right: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(255, 240, 240, 240),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3, top: 5),
                    child: Image.asset(
                      "lib/assets/happy.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Text(widget.feeling,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          fontFamily: "Cabin-Regular"))
                ],
              )),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text("Reported at: " + widget.time,
                style: TextStyle(
                    color: Color.fromARGB(255, 94, 92, 92),
                    fontSize: 11,
                    fontFamily: "Cabin-Regular")),
          )
        ],
      ),
    ));
  }

}
