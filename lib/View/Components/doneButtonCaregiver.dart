import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class doneButtonCaregiver extends StatefulWidget {
  final function;
  const doneButtonCaregiver({super.key, required this.function});

  @override
  State<doneButtonCaregiver> createState() => _doneButtonCaregiverState();
}

class _doneButtonCaregiverState extends State<doneButtonCaregiver> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 95,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            //add details to db
            // widget.function();
            Navigator.of(context).pop;
          },
          child: Padding(
            child: Text("Done",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Fredoka-SemiBold",
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 66, 135, 123))),
        ));
  }
}
