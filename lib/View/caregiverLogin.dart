import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/caregiverHome.dart';

import '../Provider/User-provider.dart';
import '../api/firebase_api.dart';
import '../api/firebase_auth.dart';
import 'Components/buttonComponent.dart';

class logInCaregiver extends StatefulWidget {
  const logInCaregiver({super.key});

  @override
  State<logInCaregiver> createState() => _logInCaregiver();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final navigatorKey = GlobalKey<NavigatorState>();

final userRole = UserProvider.getUserRole();
class _logInCaregiver extends State<logInCaregiver> {
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Padding(
                child: Image.asset(
                  "lib/assets/logo.png",
                  width: 40,
                  height: 60,
                ),
                padding: EdgeInsets.only(bottom: 15)),
            backgroundColor: Color.fromARGB(255, 66, 135, 123),
            automaticallyImplyLeading: false,
            leadingWidth: 100,
            leading: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                ),
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
                label: Text("")),
          ),
          body: logInDetails(),
        ));
  }
}

class logInDetails extends StatelessWidget {
  const logInDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Align(
        alignment: Alignment.center,
        child: Form(
            key: _formKey,
            child: Column(children: [
              Padding(
                child: Container(
                  child: Image.asset(
                    "lib/assets/welcomeBack.jpeg",
                    width: 350,
                    height: 250,
                  ),
                ),
                padding: EdgeInsets.only(top: 15),
              ),
              Padding(
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cabin',
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(20)),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email Address',
                    labelText: 'Enter Email Address',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    labelText: 'Enter Password',
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: new TextButton(
                    onPressed: () async {
                      if (passwordController.text == "" ||
                          emailController.text == "") {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                    "Empty Fields!",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(
                                      "Please enter your information in the fields provided."),
                                  actions: [
                                    TextButton(
                                      child: Text("Okay"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ));
                        return;
                      }
                      try {
                        if (await FirebaseApi.returnCredentials(
                                emailController.text) ==
                            "") {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                      "User not found!",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 21, 67, 194),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Image.asset(
                                      'lib/assets/userNotFound.webp',
                                      alignment: Alignment.center,
                                      height: 100,
                                    ),
                                    actions: [
                                      TextButton(
                                          child: Text("Okay"),
                                          onPressed: () =>
                                              Navigator.pop(context)),
                                    ],
                                  ));
                        } else {
                          if (await FirebaseApi.checkPassword(
                                  emailController.text,
                                  passwordController.text) ==
                              true) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                    child: CircularProgressIndicator()));
                            try {
                              await AuthService.login(
                                          "C-" + emailController.text.trim(),
                               
                                          passwordController.text.trim(),context);
                              print("Signed Up!");
                              print(userRole);
                            } on FirebaseAuthException catch (e) {
                              print(e);
                              print("Error with signing up!");
                            }
                            if (true) {
                              // navigatorKey.currentState!.popUntil(
                              //  (route) => route.isFirst);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => caregiverHome()));
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                        "Incorrect Password!",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 161, 0, 0),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                          "Please enter your password correctly."),
                                      actions: [
                                        TextButton(
                                          child: Text("Okay"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ));
                          }
                        }
                      } catch (Exception) {
                        final snackBarC = SnackBar(
                            content: Text(
                                "An internal issue has occured! Please try again later."));
                        action:
                        SnackBarAction(
                          label: 'Undo',
                          onPressed: () {},
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBarC);
                      }
                    },
                    child: buttonComponent(
                      colour: Color.fromARGB(255, 66, 135, 123),
                      text: "Log in",
                      function: () => {
                        Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    caregiverHome()
                                    ))
                      },
                    ),
                  )),
            ])));
  }
}
