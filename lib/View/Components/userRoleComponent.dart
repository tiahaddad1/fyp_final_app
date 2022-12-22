import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class userRoleComponent extends StatefulWidget {
  final String role;
  final Color borderColour;
  final String image;
  final Widget? page;
  final double? width;
  final double? height;

  const userRoleComponent(
      {super.key,
      required this.role,
      required this.borderColour,
      required this.image,
      this.page,
      this.width,
      this.height});

  @override
  State<userRoleComponent> createState() => _userRoleComponentState();
}

class _userRoleComponentState extends State<userRoleComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15, bottom: 30),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 191, 190, 190),
                      spreadRadius: 1,
                      blurRadius: 3)
                ],
                border: Border.all(
                  color: widget.borderColour,
                  width: 3,
                )),
            width: 350,
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      widget.page!));
                        },
                        child: Text(widget.role,
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 34, 61),
                                fontFamily: "Lato-Regular",
                                fontWeight: FontWeight.w600,
                                fontSize: 23)))),
                Image.asset("lib/assets/${widget.image}.jpeg",
                    width: widget.width == null ? 200 : widget.width,
                    height: widget.height == null ? 200 : widget.height)
              ],
            )));
  }
}
