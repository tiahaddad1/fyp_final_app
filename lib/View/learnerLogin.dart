import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/learnerHome.dart';
import 'package:fyp_application/api/firebase_auth.dart';

import '../Provider/User-provider.dart';
import '../api/firebase_api.dart';

class learnerLogin extends StatefulWidget {
  const learnerLogin({super.key});

  String saveImage() {
    // if (success == true && await urlImage != "") {
    //   print(await urlImage);
    //   return await urlImage;
    // } else {
    //   return "";
    // }
    if (success == true && i != "") {
      return i;
    } else {
      return "";
    }
  }
  @override
  State<learnerLogin> createState() => _learnerLogin();
}

bool success = false;
String emailCreated = "";
String i = "";
final navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final emailControllerLearner = TextEditingController();
final passwordControllerLearner = TextEditingController();
bool loggedIn = false;
final userRole = UserProvider.getUserRole();

class _learnerLogin extends State<learnerLogin> {
    String urlImage = "";

  Future<String> getUrlImage() async {
    return await this.urlImage;
  }
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    loginScreen() {
      return Form(
          key: _formKey,
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/assets/clouds.jpg"),
                      fit: BoxFit.cover)),
              child: Column(children: [
                SizedBox(
                  height: 200,
                ),
                Padding(
                    child: Text(
                      "Log In!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 4, 37, 52),
                        fontFamily: 'RampartOne',
                        fontSize: 35,
                      ),
                    ),
                    padding: EdgeInsets.all(40)),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    color: Color.fromARGB(151, 255, 255, 255),
                    child: TextFormField(
                      controller: emailControllerLearner,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email Address',
                        labelText: 'Enter Email Address',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:15,left:15,right:15,bottom:25),
                  child: Container(
                    color: Color.fromARGB(151, 255, 255, 255),
                    child: TextFormField(
                      controller: passwordControllerLearner,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        labelText: 'Enter Password',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: new TextButton(
                        onPressed: () async {
                          if (passwordControllerLearner.text == "" ||
                              emailControllerLearner.text == "") {
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
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ));
                            return;
                          }

                          try {
                            if (await FirebaseApi.returnCredentialsLearner(
                                    emailControllerLearner.text) ==
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
                              if (await FirebaseApi.checkPasswordLearner(
                                      emailControllerLearner.text,
                                      passwordControllerLearner.text) ==
                                  true) {

                                try {
                                  await AuthService.signUp(
                                        "L-" +
                                              emailControllerLearner.text
                                                  .trim(),
                                         passwordControllerLearner
                                              .text
                                              .trim(),context);
                                  print("Signed Up!");
                                } on FirebaseAuthException catch (e) {
                                  print("Error with signing up!");
                                }
                                if (true) {

                                  print("yes");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => learnerHome()));
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
                          } catch (Excpetion) {
                            if (success = true) {
                              print("WAIT");
                            } else {
                              print("NO");
                            }
                          }
                        },
                        child: Text(
                          "Please go to my account",
                          style: TextStyle(
                            color: Color.fromARGB(255, 4, 37, 52),
                            decoration: TextDecoration.none,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(
                                        color: Color.fromARGB(255, 4, 37, 52)))))))
              ])));
    }

    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: scaffoldKey,
          appBar:
              // loggedIn == true && userRole=="l"
              //     ? null
              //     :
              AppBar(
                  elevation: 0.0,
                  backgroundColor: Color.fromARGB(255, 180, 208, 229),
                  automaticallyImplyLeading: false,
                  leadingWidth: 100,
                  leading: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: Colors.transparent,
                    ),
                    icon: Icon(Icons.arrow_back_ios_new,
                        color: Color.fromARGB(222, 0, 0, 0)),
                    onPressed: () => Navigator.of(context).pop(),
                    label: const Text(
                      "Go Back",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  )),
          body:

              StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
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
                                  "An issue has occured, please refresh the app.",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 171, 31, 21),
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ]));
                    } else if (snapshot.hasData) {
                      if (userRole == "l") {
                        loggedIn = true;
                        return learnerHome();
                      } else {
                        return loginScreen();
                      }
                    } else {
                      loggedIn = false;
             return loginScreen(); 
              // loginScreen(),
          }
          } )
        ));
  }
}
