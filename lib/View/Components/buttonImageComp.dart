import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class buttonImage extends StatefulWidget {
  final String? image;
  final String text;
  final function;
  final Color color;

  const buttonImage(
      {super.key,
      this.image,
      required this.text,
      required this.function,
      required this.color});

  @override
  State<buttonImage> createState() => _buttonImageState();
}

class _buttonImageState extends State<buttonImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SizedBox(
          width: 200,
          height: 50,
          child: new TextButton(
              onPressed: () {
                print("something something");
                widget.function();
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    child: widget.image != null
                        ? Image.asset(
                            widget.image!,
                            width: 30,
                            height: 30,
                          )
                        : null,
                    padding: EdgeInsets.only(right: 15)),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    decoration: TextDecoration.none,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
              style: ButtonStyle(
                  elevation: MaterialStatePropertyAll<double>(3),
                  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.all(10)),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(widget.color),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: widget.color))))),
        ));
  }
}
