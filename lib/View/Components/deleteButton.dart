import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Provider/User-provider.dart';
import 'package:fyp_application/View/caregiverHome.dart';
import 'package:fyp_application/View/userRole.dart';

import '../../Model/User.dart';
import '../../api/firebase_api.dart';

class deleteButton extends StatefulWidget {
  final String text;
  final user;
  final String role;
  const deleteButton(
      {super.key, required this.text, required this.user, required this.role});

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
            if (widget.role == "c") {
              showDialog(  
              context: context,  
              builder: (BuildContext context) {  
              return  
              AlertDialog(
                title: Text("Delete your account?"),
                content: Text(
                    "Are you sure you want to permanently delete your account?"),
                actions: [
                  TextButton(
                    child: Text("Yes, I am sure"),
                    onPressed: () {
                      FirebaseApi.deleteCaregiver(widget.user);
                      Navigator.push(context,
                MaterialPageRoute(builder: (context) => userRoleScreen()));
                    },
                  ),
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );    },  
  );
              // UserProvider.userLogOut();
              print("deleting caregiver...");
            } else if (widget.role == "l") {
              showDialog(  
              context: context,  
              builder: (BuildContext context) {  
              return  
               AlertDialog(
                title: Text("Delete selected learner?"),
                content: Text(
                    "Are you sure you want to permanently delete the learner?"),
                actions: [
                  TextButton(
                    child: Text("Yes, I am sure"),
                    onPressed: () {
                      FirebaseApi.deleteLearner(widget.user);
                      Navigator.push(context,
                MaterialPageRoute(builder: (context) => caregiverHome()));
                    },
                  ),
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );},  
  );
            }
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
