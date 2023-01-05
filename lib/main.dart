import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_application/Utils.dart';
import 'package:fyp_application/View/caregiverHome.dart';
import 'package:fyp_application/View/caregiverLogin.dart';
import 'package:fyp_application/View/learnerAllScreens.dart';
import 'package:fyp_application/View/learnerHome.dart';

import 'Provider/User-provider.dart';
import 'View/userRole.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorK = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorK,
      scaffoldMessengerKey: Utils().messengerKey,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              if (UserProvider.getUserRole() == "C") {
                return caregiverHome();
              } else {
                return learnerAllScreens();
              }
            } else if (snapshot.hasError) {
              return Container(
                  color: Colors.white,
                  alignment: Alignment.bottomCenter,
                  child: Column(children: [
                    Image.asset(
                      "lib/assets/issue.png",
                      width: 100,
                      height: 200,
                    ),
                    Padding(
                        padding: EdgeInsets.all(60),
                        child: Text(
                          "An issue has occured, please try to open the app later.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 171, 31, 21),
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ]));
            } else {
              return userRoleScreen();
            }
          }),
    );
  }
}
