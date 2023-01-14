import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_application/View/Components/deleteButton.dart';
import 'package:fyp_application/View/Components/logOutButton.dart';
import 'package:fyp_application/View/Components/scheduleTaskComp.dart';
import 'package:fyp_application/View/editTaskScreen.dart';
import 'package:fyp_application/api/firebase_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../Model/Caregiver.dart';
import '../Model/Learner.dart';
import '../Provider/User-provider.dart';
import 'Components/learnerInfoCard.dart';
import 'learnerSignup.dart';

class caregiverHome extends StatefulWidget {
  const caregiverHome({super.key});

  @override
  State<caregiverHome> createState() => _caregiverHomeState();
}

class _caregiverHomeState extends State<caregiverHome> {
  String currentUser = UserProvider.getUserEmail();

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  TextEditingController caregiverDescriptionController =
      TextEditingController();
  late String urlDownload;

  capture() async {
    try {
      // ignore: deprecated_member_use
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // if (image == null) return;

      final imageTemp = File(image!.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      }); //was imageTemp
      // if (FirebaseApi.getPPStatus(currentUser) == "") {
      final path = "profilephoto/${currentUser}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref
          .delete()
          .then((value) => print("deleted!"))
          .catchError((error) => {print(error)});
      final uploadFile = await ref.putFile(File(image.path));
      urlDownload = (await uploadFile.ref.getDownloadURL());
      await FirebaseApi.updateImage(urlDownload, currentUser);
      print("OKAYYYY: " + urlDownload);
      setState((() => ppUpload = urlDownload));
      return urlDownload;
      // }
      // return "error";
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      return "error";
    }
  }

  late String? pp = "";
  late String? ppUpload = "";
  late String? userName = "";
  File? image;
  bool tapped = false;
  // Image imagePath = FirebaseApi.getPPStatus(UserProvider.getUserEmail()) != ""
  //     ? Image.network(
  //         FirebaseApi.getPPStatus(UserProvider.getUserEmail()).toString())
  //     : const Image(
  //         image: AssetImage("lib/assets/photo.png"), width: 70, height: 80);
  Image imagePath =
      Image(image: AssetImage("lib/assets/photo.png"), width: 70, height: 80);
  //       Future capture() async {
  //   try {
  //     // ignore: deprecated_member_use
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;

  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp); //was imageTemp

  //     // final MediaSource s = ModalRoute.of(context).media;
  //     // if (media == null) {
  //     //   return;
  //     // } else {
  //     //   fileMedia = media;
  //     // }
  //   } on PlatformException catch (e) {
  //     print("Failed to pick image: $e");
  //   }
  // }

  GestureDetector addNewLearnerComp(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => learnerSignup()));
        //navigates to add new learner screen
      },
      child: Container(
          alignment: Alignment.center,
          height: 70,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(10), ),
            border: Border(
              right: BorderSide(
                  width: 2.0, color: Color.fromARGB(255, 80, 169, 154)),
              bottom: BorderSide(
                  width: 2.0, color: Color.fromARGB(255, 80, 169, 154)),
              left: BorderSide(
                  width: 4.0, color: Color.fromARGB(255, 80, 169, 154)),
            ),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset(
                  "lib/assets/addNewLearner.png",
                  width: 35,
                  height: 35,
                ),
              ),
              Padding(
                child: Text(
                  "Add new learner",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Fredoka-Medium",
                      decoration: TextDecoration.underline,
                      fontSize: 17),
                ),
                padding: EdgeInsets.all(10),
              )
            ],
          )),
    );
  }

  String desc = "";
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Caregiver>(
        future: UserProvider.getCurrentUser(),
        builder: ((context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              print("still...");
              pp = "waiting...";
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              if (snapshot.hasData) {
                pp = snapshot.data.profile_pic;
                userName = snapshot.data.first_name;
                print('dataaa');
                return mainContent(context);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return mainContent(context);
              } else {
                pp = null;
                print(snapshot.error);
                return mainContent(context);
              }
            default:
              pp = null;
              // print(snapshot.connectionState);
              return mainContent(context);
          }
        }));
  }

  mainContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 251, 251, 251),
          toolbarHeight: 300,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.circular(20),

          //   ),
          // ),
          shape: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 66, 135, 123), width: 2)),
          title: Expanded(
              child: Column(
            children: [
              Padding(
                child: Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        // height: 50,
                        // width: double.infinity,
                        child: deleteButton(text: "Delete Account",user:currentUser,role:"c"),
                      ),    
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        height: 50,
                        // width: double.infinity,
                        child: logOutButton(),
                      )
                    ])),
                padding: EdgeInsets.only(bottom: 15),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Welcome back",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 100, 100, 100),
                                      fontSize: 15,
                                      fontFamily: "Cabin-Regular"),
                                  textAlign: TextAlign.left,
                                ),
                                padding: EdgeInsets.only(bottom: 20),
                              ),
                              Container(
                                  child: FutureBuilder<Caregiver>(
                                      future:
                                          FirebaseApi.getCurrentCaregiverName(
                                              currentUser),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.first_name
                                                    .substring(0, 1)
                                                    .toUpperCase() +
                                                snapshot.data!.first_name
                                                    .substring(1) +
                                                " " +
                                                snapshot.data!.last_name
                                                    .substring(0, 1)
                                                    .toUpperCase() +
                                                snapshot.data!.last_name
                                                    .substring(1),
                                            style: TextStyle(
                                                fontFamily: "Cabin-Regular",
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 66, 135, 123),
                                                fontWeight: FontWeight.w600),
                                          );
                                        } else {
                                          return Text(
                                            "",
                                            style: TextStyle(
                                                fontFamily: "Cabin-Regular",
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 66, 135, 123),
                                                fontWeight: FontWeight.w600),
                                          );
                                        }
                                      }))
                            ],
                          ),
                          padding: EdgeInsets.only(right: 10),
                        ),
                        Stack(alignment: Alignment.topRight, children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(15), // Image border
                            child: SizedBox.fromSize(
                                size: Size.fromRadius(55), // Image radius
                                child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Column(children: [
                                      InkWell(
                                          onTap: () {
                                            // if (tapped == false) {
                                            capture();
                                            // tapped = true;
                                            // }
                                          },
                                          child: pp != null
                                              ? Image.network(pp!,
                                                  width: 300, height: 90)
                                              : pp == "waiting..."
                                                  ? Image.network(ppUpload!,
                                                      width: 300, height: 90)
                                                  : imagePath),
                                    ]))),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 7,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    edit = true;
                                  });
                                  if (edit == true) {
                                    capture();
                                    setState(() {
                                      edit = false;
                                    });
                                    // upload image and save to DB!
                                  }
                                  print("clicked!");
                                },
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    child: Image.asset(
                                      "lib/assets/pencil.png",
                                      width: 18,
                                      height: 18,
                                    ),
                                    padding: EdgeInsets.only(top: 5, left: 5),
                                  ),
                                )),
                          ),
                        ])
                      ])),
              Stack(alignment: Alignment.topRight, children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 240, 240, 240),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 98, 98, 98).withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 65,
                    child: FutureBuilder<Caregiver>(
                        future:
                            FirebaseApi.getCurrentCaregiverName(currentUser),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return TextField(
                                readOnly: false,
                                minLines: 3,
                                style: TextStyle(fontSize: 13),
                                controller: caregiverDescriptionController,
                                showCursor: true,
                                cursorColor: Color.fromARGB(255, 66, 135, 123),
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: snapshot.data!.about_description ==
                                          ""
                                      ? "Please provide a description of yourself..."
                                      : snapshot.data!.about_description,
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 13),
                                ));
                          } else {
                            return TextField(
                                style: TextStyle(fontSize: 13),
                                controller: caregiverDescriptionController,
                                minLines: 3,
                                readOnly: false,
                                showCursor: true,
                                cursorColor: Color.fromARGB(255, 66, 135, 123),
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      "Please provide a description of yourself...",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 13),
                                ));
                          }
                        })),
                Positioned(
                    bottom: 14,
                    right: 13,
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(20)),
                        color: Color.fromARGB(170, 217, 217, 217),
                        shape: BoxShape.rectangle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            edit = true;
                          });
                          print("Desc: " + caregiverDescriptionController.text);
                          FirebaseApi.updateDescription(
                              caregiverDescriptionController.text);
                          print("clicked!");
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            child: Image.asset(
                              "lib/assets/pencil.png",
                              width: 18,
                              height: 18,
                            ),
                            padding:
                                EdgeInsets.only(top: 5, left: 5, bottom: 5),
                          ),
                        ),
                      ),
                    )),
              ]),
            ],
          )),
        ),
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        body: Column(children: [
          Container(
            padding: EdgeInsets.only(right: 20, bottom: 20, top: 20),
            height: 60,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                  onTap: () {
                    //view info guide here in a pop up
                  },
                  child: Image.asset(
                    "lib/assets/infoIcon.png",
                    height: 30,
                    width: 30,
                  ))
            ]),
          ),
          Container(
            padding: EdgeInsets.only(left: 25),
            alignment: Alignment.topLeft,
            child: Text(
              "My learners",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Cabin-Regular"),
            ),
          ),
          FutureBuilder<List<Learner>>(
              future: FirebaseApi.getAllLearners(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final learners = snapshot.data;
                  print(learners);
                  return Expanded(
                    //fix the design layout
                    child: SafeArea(
                        child: GridView.builder(
                      itemCount: snapshot.data!.length,
                      padding: EdgeInsets.only(top: 20),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final doc = snapshot.data![index];
                        return Center(
                            child: Wrap(children: [
                          learnerInfoCard(
                              first_name: doc.first_name,
                              last_name: doc.last_name,
                              learner: doc),
                        ]));
                      },
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 10),
                      // children: [
                      //   Center(
                      //       child: Wrap(

                      //         children:learners.map(learnerInfoCard).toList()
                      // children: learners.map((e) {
                      //   return learnerInfoCard(data: e);
                      // })
                      // [
                      //   learnerInfoCard(snapshot.data),
                      //   learnerInfoCard(),
                      //   learnerInfoCard(),
                      // ],
                    )),
                    // addNewLearnerComp(context)
                    // ],
                  );
                } else {
                  return 
                  Container(child: Center(
                    child: Image.asset(
                      "lib/assets/noData.png",
                      width: 50,
                      height: 55,
                    ),
                    // CircularProgressIndicator(), //show a text in the middle
                    //that there is no data
                  ),margin: EdgeInsets.all(30));
                }
              }),
          addNewLearnerComp(context)
        ]));
  }
  // else{
  //   return Center(child: CircularProgressIndicator(),);
  // }
}
          // )
              //future builder here
              //once learner account created, make sure to show all learners
              //associated to a therapist

              //     SafeArea(
              //         child: ListView(
              //   padding: EdgeInsets.only(top: 20),
              //   shrinkWrap: true,
              //   scrollDirection: Axis.vertical,
              //   children: [
              //     Center(
              //         child: Wrap(
              //       children: [
              //         learnerInfoCard(),
              //         learnerInfoCard(),
              //         learnerInfoCard(),
              //       ],
              //     )),
              //     addNewLearnerComp(context)
              //   ],
              // ))
//               )
//         ],
//       ),
//     );
//   }
// }
