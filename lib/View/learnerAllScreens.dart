import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/taskComponent.dart';
import 'package:fyp_application/View/learnerHome.dart';
import 'package:fyp_application/View/learnerProfile.dart';
import 'package:fyp_application/View/learnerReminders.dart';
import 'package:fyp_application/View/learnerSkills.dart';
import 'package:fyp_application/View/taskScreen.dart';

import 'accomplishScreen.dart';

class learnerAllScreens extends StatefulWidget {
  const learnerAllScreens({super.key});

  @override
  State<learnerAllScreens> createState() => _learnerAllScreensState();
}

class _learnerAllScreensState extends State<learnerAllScreens> {
  int index = 0;
  final screens = [
    learnerHome(),
    learnerReminders(),
    learnerSkills(),
    learnerProfile(),
    // taskScreen()
    // accomplishScreen()
  ];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: screens[index],
          bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                  indicatorColor: Color.fromARGB(255, 191, 250, 197),
                  labelTextStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  )),
              child: NavigationBar(
                  height: 80,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  selectedIndex: index,
                  onDestinationSelected: (index) =>
                      setState(() => this.index = index),
                  destinations: [
                    NavigationDestination(
                        icon: Image.asset(
                          "lib/assets/home.png",
                          height: 40,
                        ),
                        label: 'Home'),
                    NavigationDestination(
                        icon: Image.asset(
                          "lib/assets/bell.png",
                          height: 40,
                        ),
                        label: 'Reminder'),
                    NavigationDestination(
                        icon: Image.asset(
                          "lib/assets/skill.png",
                          height: 40,
                        ),
                        label: 'Skills'),
                    NavigationDestination(
                        icon: Image.asset(
                          "lib/assets/user.png",
                          height: 40,
                        ),
                        label: 'Profile'),
                  ])),
          appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/space.webp"),
                    // ^ THIS IS CHANGED BASED ON USER'S SELECTION ^
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leadingWidth: 100,
              leading: null),
          // body: landingPage(),
        ));
  }
}
