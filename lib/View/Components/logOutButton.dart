import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../api/firebase_api.dart';

class logOutButton extends StatefulWidget {
  const logOutButton({super.key});

  @override
  State<logOutButton> createState() => _logOutButton();
}

class _logOutButton extends State<logOutButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 90,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll<double>(0.0),
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 251, 251, 251)),
          ),
          onPressed: (() {
            showDialog(  
              context: context,  
              builder: (BuildContext context) {  
              return  
              AlertDialog(
                title: Text("Log out?"),
                content: Text(
                    "Are you sure you want to log out of your account?"),
                actions: [
                  TextButton(
                    child: Text("Yes, I am sure"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
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
            // FirebaseAuth.instance.signOut();
          }),
          child: Container(
            child: Text("Log Out",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(255, 255, 117, 117),
                    fontWeight: FontWeight.bold,
                    fontSize: 13)),
          ),
        ));
  }
}
