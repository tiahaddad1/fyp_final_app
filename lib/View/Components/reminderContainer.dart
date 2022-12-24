import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class reminderContainer extends StatefulWidget {
  const reminderContainer(
      {super.key, reminder}); //make required once backend done

  @override
  State<reminderContainer> createState() => _reminderContainerState();
}

class _reminderContainerState extends State<reminderContainer> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: CheckboxListTile(
          // title: Text(widget.reminder.name),
          title: Text(
            "Pray daily prayers",
            style: TextStyle(
                fontFamily: "Cambay-Regular",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          value: checked,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool? b) {
            setState(() {
              checked = b!;
            });
          }),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.3),
        ),
      ),
    );
  }
}
