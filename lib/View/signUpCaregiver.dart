import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Model/Caregiver.dart';
import '../Provider/caregiver.dart';
import '../api/firebase_api.dart';
import '../api/firebase_auth.dart';
import 'Components/buttonComponent.dart';
import 'caregiverLogin.dart';

class signUpCaregiver extends StatefulWidget {
  const signUpCaregiver({super.key});

  @override
  State<signUpCaregiver> createState() => _signUpCaregiverState();
}

final error = false;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final repasswordController = TextEditingController();
final navigatorKey = GlobalKey<NavigatorState>();

// navigateToLogin(BuildContext context){
// Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//             caregiverLogin()));
// }

class _signUpCaregiverState extends State<signUpCaregiver> {
  @override
  initState() {
    super.initState();
  }
  //   Future signUpF(String email, String password, BuildContext context) async {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) => Center(child: CircularProgressIndicator()));
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: email.trim(), password: password.trim());
  //     print("Signed Up!");
  //   } on FirebaseAuthException catch (e) {
  //     print("Error with signing up!");
  //   }
  //   navigatorKey.currentState!.popUntil((route) => route.isFirst);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
            // title: Text("Sign Up"),
            leading: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                ),
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
                label: Text("")),
          ),
          body: enterDetails(),
        ));
  }
}

class enterDetails extends StatelessWidget {
  const enterDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Align(
        alignment: Alignment.center,
        child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "lib/assets/signUpCaregiver.webp",
                          width: 500,
                          height: 310,
                        )),
                    Padding(
                      child: Text(
                        "Create an account!",
                        style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.w500,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cabin',
                        ),
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Forename',
                                    hintText: 'Your forename',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^[a-z A-Z]+$')
                                            .hasMatch(value)) {
                                      return "Please enter a valid name";
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Surname',
                                    hintText: 'Your surname',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^[a-z A-Z]+$')
                                            .hasMatch(value)) {
                                      return "Please enter a valid name";
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Enter E-mail',
                                    hintText: 'E-mail Address',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                            .hasMatch(value)) {
                                      return "Please enter a valid e-mail address";
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Enter New Password',
                                    hintText: 'New Password',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        value.length < 7 ||
                                        !RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
                                            .hasMatch(value)) {
                                      return "Password must have special characters, numbers, [A-Z a-z]";
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                    controller: repasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Re-Enter Password",
                                      labelText: "Confirm Password",
                                    ))),
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 30,
                                child: new TextButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      print("Inputs are OK");
                                    } else {
                                      print("Inputs are incorrectly entered");
                                      return;
                                    }

                                    if (repasswordController.text !=
                                        passwordController.text) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                  "Incorrect Password!",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                        255,
                                                        158,
                                                        11,
                                                        0,
                                                      ),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Text(
                                                    "Please re-enter your password correctly"),
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
                                              Caregiver newCaregiver = new Caregiver(
                                                  user_id: "123",
                                                  first_name: firstNameController.text,
                                                  last_name: lastNameController.text,
                                                  email: emailController.text,
                                                  password: Crypt.sha256(passwordController.text).toString(),
                                                  about_description: "",
                                                  profile_pic: "");
                                              try {
                                                if (await FirebaseApi.compareEmail(
                                                        emailController.text) ==
                                                    true) {
                                                  final snackBarC = SnackBar(
                                                      content: Text(
                                                          "This email already exists! Please try another email."));
                                                  action:
                                                  SnackBarAction(
                                                    label: 'Undo',
                                                    onPressed: () {},
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBarC);
                                                } else {
                                                  CaregiverProvider.addCaregiver(
                                                      newCaregiver);
                                      //saving to Firebase Authentication 272- 294:
                                                  if (error == false) {
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (context) => Center(
                                                            child:
                                                                CircularProgressIndicator()));
                                                    try {
                                                      await AuthService.signUp(
                                                             "C-"+emailController
                                                                  .text
                                                                  .trim(),
                                                                  passwordController
                                                                      .text
                                                                      .trim(),context);
                                                      print("Signed Up!");
                                                    } on FirebaseAuthException catch (e) {
                                                      print("Error with signing up!");
                                                    }
                                                    navigatorKey.currentState!.popUntil(
                                                        (route) => route.isFirst);
                                                      FirebaseAuth.instance.signOut();
                                                    if (true)
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                  "Account Created!",
                                                                  style: TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              4,
                                                                              194,
                                                                              26),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                content: Padding(
                                                                    padding:
                                                                        EdgeInsets.only(
                                                                            top: 10),
                                                                    child: Image.asset(
                                                                      'lib/assets/success.png',
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      height: 80,
                                                                    )),
                                                                actions: [
                                                                  TextButton(
                                                                      child: Text(
                                                                          "Log in!"),
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        if (true) {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) =>
                                                                                      logInCaregiver()));
                                                                        }
                                                                      }),
                                                                ],
                                                              ));
                                                  }
                                                }
                                              } catch (a) {
                                                print(a);
                                                final snackBarC = SnackBar(
                                                    content: Text(
                                                        "An internal issue has occured! Please try again later."));
                                                action:
                                                SnackBarAction(
                                                  label: 'Undo',
                                                  onPressed: () {},
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBarC);
                                              }
                                  },
                                  child: buttonComponent(
                                    colour: Color.fromARGB(255, 66, 135, 123),
                                    text: "Sign Up",
                                    function: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  logInCaregiver()))
                                    },
                                  ),
                                )),
                          ],
                        ))
                  ]),
            )));
  }
}
