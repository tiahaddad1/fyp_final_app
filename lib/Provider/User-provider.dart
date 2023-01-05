import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_application/Model/Caregiver.dart';
import 'package:fyp_application/api/firebase_api.dart';

class UserProvider extends ChangeNotifier {
  static User? user = FirebaseAuth.instance.currentUser;

  setUserRole() {}

  static String getUserRole() {
    final email = user!.email!;
    final role = email.substring(0, 1);
    return role;
  }

  static String getUserEmail() {
    final email = user!.email!.substring(2);
    return email;
  }

  static Future<String?> getName() async {
    final a = await FirebaseApi.returnName(user!.email!);
    return a;
  }
    static Future<String?> getID() async {
    final a = await FirebaseApi.returnName(user!.uid);
    return a;
  }

  static name() {
    final n = getName().whenComplete(() {
      return getName();
    });
    return n;
  }

  // static Future<Image> profilePicture() async {
  //   // print(await FirebaseApi.getCurrentCaregiver(getUserEmail()).toString());
  //   // print(await FirebaseApi.giveAllCaregivers());
  //   final pp = await FirebaseStorage.instance
  //       .ref()
  //       .child("profilephoto/${getUserEmail()}")
  //       .getDownloadURL();
  //   return Image.network(pp, width: 100, height: 100);
  // }

  static Future<Caregiver> getCurrentUser() async {
    // print(FirebaseApi.giveAllCaregivers());
    print(await FirebaseApi.getCaregiverObj(await user!.email!.substring(2)));
    return await FirebaseApi.getCaregiverObj(await user!.email!.substring(2));
  }

  static userLogOut() {
    FirebaseAuth.instance.signOut();
  }
}
