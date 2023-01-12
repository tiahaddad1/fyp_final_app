import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_application/api/firebase_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '/Model/Learner.dart';

class LearnerProvider extends ChangeNotifier {
  late List<Learner> learners = [];

  static Future<String> loadProfilePic(String image) async {
    // print(await FirebaseStorage.instance
    //     .ref()
    //     .child("profilephoto/${image}")
    //     .getDownloadURL());
    return await FirebaseStorage.instance
        .ref()
        .child("profilephoto/${image}")
        .getDownloadURL();
  }

  static String giveImage(image) {
    String img = "";
    loadProfilePic(image)
        .whenComplete(() => img = loadProfilePic(image) as String);
    return img;
  }

  static void addLearner(Learner learner) => FirebaseApi.createLearner(learner);

  void setLearners(List<Learner> _learners) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        learners = _learners;
        notifyListeners();
      });

  void removeLearner(Learner learner) {
    learners.remove(learner);
    notifyListeners();
  }

  // static saveToLocalStorage(String learner_id) async {
  //   print("nat is here");
  //   final prefs = await SharedPreferences.getInstance();
  //   print(prefs);
  //   await prefs.setString('current_learner', learner_id);
  // }

  // static Future<String?> readFromLocalStorage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final learner = prefs.getString('current_learner');
  //   return learner;
  // }

  static saveToLocalStorage(String learnedID) async {
    final box = await Hive.openBox('current_learner');
    await box.put('current_learner', learnedID);
  }

  static Future<String?> readFromLocalStorage() async {
    Hive.init('path/to/directory');
    final box = await Hive.openBox('current_learner');
    print("Box: " + box.values.toString());
    return box.values.first;
  }
}
