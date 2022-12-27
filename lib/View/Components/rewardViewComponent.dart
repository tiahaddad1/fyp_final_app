import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class rewardViewComponent extends StatefulWidget {
  final String text;
  final String image;
  final String reward;
  final bool addNew;

  const rewardViewComponent(
      {super.key,
      required this.text,
      required this.image,
      required this.reward,
      required this.addNew});

  @override
  State<rewardViewComponent> createState() => _rewardViewComponentState();
}

class _rewardViewComponentState extends State<rewardViewComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: 300,
      height: 65,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 1),
        ),
      ], borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 70,
            padding: widget.addNew==false?EdgeInsets.all(5):EdgeInsets.only(left: 12,right: 5,top: 7,bottom: 5),
            child: widget.addNew==false?Image.asset(widget.image):Image.asset("lib/assets/addImage.png"),
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            )),
          ),
          Container(
            alignment: Alignment.center,
            width: 230,
            height: 70,
            decoration: BoxDecoration(
                border: Border(
              right: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            )),
            padding: EdgeInsets.all(7),
            child: Text(
              widget.addNew==false?widget.text:"Add new reward",
              style: TextStyle(
                decoration: widget.addNew==false?TextDecoration.none:TextDecoration.underline,
                  fontFamily: "Fredoka-Medium",
                  color: widget.addNew==false?Colors.black:Color.fromARGB(255, 1, 38, 68),
                  fontSize: 19),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Color.fromARGB(255, 224, 227, 238),
              ),
              width: 60,
              height: 70,
              alignment: Alignment.center,
              child: widget.addNew==false?Text("+" + widget.reward,
                  style: TextStyle(
                      fontFamily: "Fredoka-Medium",
                      color: Color.fromARGB(255, 80, 169, 154),
                      fontSize: 23)):
                      Image.asset("lib/assets/starOne.png",width: 30,height: 40,)
                      ),
        ],
      ),
    );
  }
}
