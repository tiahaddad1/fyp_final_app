import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class closeButton extends StatefulWidget {
  const closeButton({super.key});

  @override
  State<closeButton> createState() => _closeButtonState();
}

class _closeButtonState extends State<closeButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 25,
        width: 60,
        child: ElevatedButton(
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
          onPressed: Navigator.of(context).pop,
          child: Container(
            child: Text("Close",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9)),
          ),
        ));
  }
}
