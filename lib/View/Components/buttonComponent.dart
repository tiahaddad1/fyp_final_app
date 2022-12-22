import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class buttonComponent extends StatefulWidget {
  final Color colour;
  final String text;
  final function;

  const buttonComponent(
      {super.key,
      required this.colour,
      required this.text,
      this.function});

  @override
  State<buttonComponent> createState() => _buttonComponentState();
}

class _buttonComponentState extends State<buttonComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 100, top:40),
        child: TextButton(
            onPressed: () {
              widget.function();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => widget.page!));
            },
            child: Padding(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              padding: EdgeInsets.all(5),
            ),
            style: ButtonStyle(
                minimumSize: MaterialStatePropertyAll<Size>(Size.fromHeight(0)),
                shadowColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(255, 47, 47, 47)),
                elevation: MaterialStatePropertyAll<double>(10.0),
                backgroundColor: MaterialStatePropertyAll<Color>(widget.colour),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                    side: BorderSide(color: widget.colour))))));
  }
}
