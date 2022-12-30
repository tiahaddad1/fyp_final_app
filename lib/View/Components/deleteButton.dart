import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class deleteButton extends StatefulWidget {
  final String text;
  final function;
  const deleteButton({super.key, required this.text, required this.function});

  @override
  State<deleteButton> createState() => _deleteButtonState();
}

class _deleteButtonState extends State<deleteButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        width: 100,
        child: TextButton(
          style: ButtonStyle(
            shadowColor: MaterialStatePropertyAll<Color>(Colors.grey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 255, 117, 117)),
          ),
          onPressed: () {
            widget.function();
          },
          child: Container(
            child: Text(widget.text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10)),
          ),
        ));
  }
}
