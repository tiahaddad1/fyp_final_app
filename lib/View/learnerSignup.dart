import 'dart:io';
// import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/Model/Learner.dart';
import 'package:fyp_application/View/caregiverHome.dart';
import 'package:fyp_application/View/signUpCaregiver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../Provider/User-provider.dart';
import '../Provider/learner.dart';
import '../api/firebase_api.dart';

class learnerSignup extends StatefulWidget {
  const learnerSignup({super.key});

  @override
  State<learnerSignup> createState() => _learnerSignupState();
}

String userEmail = UserProvider.getUserEmail();
bool success = false;
String emailCreated = "";
String urlImage = "";

final navigatorKey = GlobalKey<NavigatorState>();
bool tap = false;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
DateTime? dateNow = DateTime.now();
final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final rePasswordController = TextEditingController();
final dateOfBirthController = TextEditingController();
Image imagePath = Image(
    image: AssetImage("lib/assets/uploadImage.png"), width: 60, height: 80);

class _learnerSignupState extends State<learnerSignup> {
  late File image;

  @override
  Widget build(BuildContext context) {
    Future<File> saveImagePermanently(String imagePath) async {
      final directory = await getApplicationDocumentsDirectory();
      final name = basename(imagePath);
      final image = File('${directory.path}/$name');
      return File(imagePath).copy(image.path);
    }

    late String urlDownload;

    capture() async {
      try {
        // ignore: deprecated_member_use
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        // if (image == null) return;

        final imageTemp = File(image!.path);
        final imagePermanent = await saveImagePermanently(image.path);
        setState(() => this.image = imagePermanent); //was imageTemp
        if (emailController != null) {
          final path = "profilephoto/${emailController.text}";
          final ref = FirebaseStorage.instance.ref().child(path);
          final uploadFile = await ref.putFile(File(image.path));
          urlDownload = (await uploadFile.ref.getDownloadURL());
          return urlDownload;
        }
        return "error";
      } on PlatformException catch (e) {
        print("Failed to pick image: $e");
        return "error";
      }
    }

    showCalendar() async {
      DateTime? pickDate = await showDatePicker(
          context: context,
          initialDate: DateTime(2008),
          firstDate: DateTime(2008),
          lastDate: DateTime(2018));
      if (DateFormat.yMd().format(pickDate!) ==
          DateFormat.yMd().format(DateTime.now())) {
        pickDate = DateTime.now().add(const Duration(days: 1));
        setState(() {
          dateNow = pickDate;
        });
      } else if (pickDate != null) {
        setState(() {
          dateNow = pickDate;
        });
      } else if (pickDate == null) {
        pickDate = dateNow;
      }
    }

    final formKey = GlobalKey<FormState>();

    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                    style: TextStyle(color: Colors.transparent),
                  ),
                )),
            body: Form(
                key: formKey,
                child: Container(
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: ListView(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10, top: 10),
                            // alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(left: 20),
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 6, 24, 54),
                                      fontSize: 22,
                                      fontFamily: "Lato-Regular",
                                      fontWeight: FontWeight.bold),
                                  text: "Create an account for a new ",
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "learner",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 190, 166, 221),
                                          fontSize: 22,
                                          fontFamily: "Lato-Regular",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text: "!",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 6, 24, 54),
                                            fontSize: 22,
                                            fontFamily: "Lato-Regular",
                                            fontWeight: FontWeight.bold))
                                  ]),
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 10, bottom: 10, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      "First Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lato-Regular",
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    height: 52,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 56, 56, 56),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromARGB(104, 255, 255, 255),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                          autofocus: false,
                                          cursorColor: Color.fromARGB(
                                              222, 171, 204, 244),
                                          controller: firstNameController,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 34, 63),
                                              fontFamily: "Lato-Regular",
                                              fontSize: 16),
                                          decoration: InputDecoration(
                                              hintText: "Enter First Name",
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                              focusedBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none),
                                        )),
                                      ],
                                    ),
                                  ),
                                ])),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 10, bottom: 10, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      "Last Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lato-Regular",
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    height: 52,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 56, 56, 56),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromARGB(104, 255, 255, 255),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                          autofocus: false,
                                          cursorColor: Color.fromARGB(
                                              222, 171, 204, 244),
                                          controller: lastNameController,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 34, 63),
                                              fontFamily: "Lato-Regular",
                                              fontSize: 16),
                                          decoration: InputDecoration(
                                              hintText: "Enter Last Name",
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                              focusedBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none),
                                        )),
                                      ],
                                    ),
                                  ),
                                ])),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 10, bottom: 10, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      "Birthday",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lato-Regular",
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8, left: 7),
                                    width: 350,
                                    height: 52,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Color.fromARGB(255, 56, 56, 56),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromARGB(104, 255, 255, 255)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            readOnly: true,
                                            autofocus: false,
                                            cursorColor: Color.fromARGB(
                                                222, 171, 204, 244),
                                            controller: dateOfBirthController,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Lato-Regular",
                                                fontSize: 16),
                                            decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 10),
                                                hintText: DateFormat.yMd()
                                                    .format(dateNow!),
                                                focusedBorder: InputBorder.none,
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    InputBorder.none),
                                          ),
                                        ),
                                        Container(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.calendar_today_outlined,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                            onPressed: () {
                                              showCalendar();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ])),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 10, bottom: 10, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lato-Regular",
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    height: 52,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 56, 56, 56),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromARGB(104, 255, 255, 255),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                                    .hasMatch(value)) {
                                              return "Please enter a valid e-mail address";
                                            } else {
                                              return null;
                                            }
                                          },
                                          autofocus: false,
                                          cursorColor: Color.fromARGB(
                                              222, 171, 204, 244),
                                          controller: emailController,
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: "Lato-Regular",
                                              fontSize: 16),
                                          decoration: InputDecoration(
                                              hintText: "Enter Email",
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                              focusedBorder: InputBorder.none,
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none),
                                        )),
                                      ],
                                    ),
                                  ),
                                ])),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 10, bottom: 10, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      "Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lato-Regular",
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    height: 52,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 56, 56, 56),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromARGB(104, 255, 255, 255),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                          autofocus: false,
                                          cursorColor: Color.fromARGB(
                                              222, 171, 204, 244),
                                          controller: repasswordController,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 34, 63),
                                              fontFamily: "Lato-Regular",
                                              fontSize: 16),
                                          decoration: InputDecoration(
                                            hintText: "Enter Password",
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                          obscureText: true,
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
                                      ],
                                    ),
                                  ),
                                ])),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 15, left: 10, bottom: 10, right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      "Confirm Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lato-Regular",
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  Container(
                                    width: 350,
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    height: 52,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 56, 56, 56),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Color.fromARGB(104, 255, 255, 255),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TextFormField(
                                          autofocus: false,
                                          cursorColor: Color.fromARGB(
                                              222, 171, 204, 244),
                                          controller: passwordController,
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontFamily: "Lato-Regular",
                                              fontSize: 16),
                                          decoration: InputDecoration(
                                            hintText: "Re-enter Password",
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                          ),
                                          obscureText: true,
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
                                      ],
                                    ),
                                  ),
                                ])),
                        Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 20, top: 20),
                            decoration: new BoxDecoration(
                              gradient: new LinearGradient(stops: [
                                0.02,
                                0.10
                              ], colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 255, 255, 255)
                              ]),
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(15.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 90, 89, 89)
                                      .withOpacity(0.1),
                                  spreadRadius: 7,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            height: 180,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Upload a profile picture",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: 'Lato-Regular',
                                        fontSize: 18),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(children: [
                                          InkWell(
                                              onTap: () {
                                                capture();
                                                tap = true;
                                              },
                                              child:
                                                  // image != null
                                                  //     ? Image.file(image!,
                                                  //         width: 150, height: 120)
                                                  //     :
                                                  imagePath),
                                        ]))
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: SizedBox(
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
                                      Learner newLearner = new Learner(
                                          user_id: "123",
                                          first_name: firstNameController.text,
                                          last_name: lastNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          profile_pic: "",
                                          about_description: "",
                                          birth_date: DateFormat.yMd()
                                              .format(dateNow!)
                                              .toString(),
                                          caregiver_assigned: userEmail);
                                      try {
                                        if (await FirebaseApi.compareLearnerEmail(
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
                                          if (tap == true) {
                                            LearnerProvider.addLearner(newLearner);

                                            if (true) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) => Center(
                                                      child:
                                                          CircularProgressIndicator()));
                                              try {
                                                await FirebaseAuth.instance
                                                    .createUserWithEmailAndPassword(
                                                        email: "L-" +
                                                            emailController.text
                                                                .trim(),
                                                        password: passwordController
                                                            .text
                                                            .trim());
                                                print("Signed Up!");
                                              } on FirebaseAuthException catch (e) {
                                                print("Error with signing up!");
                                              }
                                              navigatorKey.currentState!.popUntil(
                                                  (route) => route.isFirst);
                                              FirebaseAuth.instance.signOut();

                                              setState(() {
                                                success = true;
                                                emailCreated = emailController.text;
                                                // urlImage =
                                                //     LearnerProvider.loadProfilePic(
                                                //         emailCreated);
                                              });
                                              print(urlImage);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                        title: Text(
                                                          "Account Successfully Created!",
                                                          style: TextStyle(
                                                              color: Color.fromARGB(
                                                                  255, 4, 194, 26),
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                        content: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Image.asset(
                                                              'lib/assets/success.png',
                                                              alignment:
                                                                  Alignment.center,
                                                              height: 80,
                                                            )),
                                                        actions: [
                                                          TextButton(
                                                              child: Text("Okay!"),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                if (true) {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) =>
                                                                                  caregiverHome()));
                                                                }
                                                              }),
                                                        ],
                                                      ));
                                            }
                                          }
                                        }
                                      } catch (Excpetion) {
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
                                      if (tap == false) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                    "Please upload an image of the child!",
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
                                                  content: Image.asset(
                                                      "lib/assets/profile.png",
                                                      width: 100,
                                                      height: 100),
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
                                    },
                                  
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Create Account",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            decoration: TextDecoration.none,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Padding(
                                            child: Image.asset(
                                              "lib/assets/sparkle.png",
                                              width: 25,
                                              height: 25,
                                            ),
                                            padding: EdgeInsets.only(left: 5)),
                                      ]),
                                  style: ButtonStyle(
                                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                          EdgeInsets.all(10)),
                                      backgroundColor: MaterialStatePropertyAll<Color>(
                                          Color.fromARGB(255, 190, 166, 221)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 190, 166, 221)))))),
                            )),
                      ],
                    )))));
  }
}
