import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_application/api/firebase_api.dart';

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
    loadProfilePic(image).whenComplete(()=>img=loadProfilePic(image) as String);
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
}
