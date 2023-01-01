import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class rewardStarComp extends StatefulWidget {
  final int reward;
  const rewardStarComp({super.key, required this.reward});

  @override
  State<rewardStarComp> createState() => _rewardStarCompState();
}

class _rewardStarCompState extends State<rewardStarComp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 77,
      decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
		  left: BorderSide(
			color: Color.fromARGB(255, 0, 0, 0),
			width: 1,
		  ),
		  right: BorderSide(
			color: Color.fromARGB(255, 0, 0, 0),
			width: 1,
		  ),      
      ),),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "lib/assets/star.png",
            width: 45,
            height: 45,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "+" + widget.reward.toString(),
              style: TextStyle(
                  color: Color.fromARGB(255, 63, 62, 59),
                  fontFamily: "Fredoka-SemiBold",
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
