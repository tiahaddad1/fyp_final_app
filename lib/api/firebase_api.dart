import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_application/Model/Learner_Tasks.dart';
import 'package:fyp_application/Model/Subtask.dart';
import 'package:fyp_application/Provider/User-provider.dart';
import 'package:fyp_application/Utils.dart';
import '../Model/Learner.dart';
import '../Model/Task.dart';
import '../Model/User.dart';
import '/Model/Caregiver.dart';
import '/Model/Task.dart' as t;

class FirebaseApi {
  //USER related methods//

  static Future<String> createCaregiver(Caregiver caregiver) async {
    final docOfCaregiver =
        FirebaseFirestore.instance.collection('caregiver').doc();
    caregiver.user_id = docOfCaregiver.id;
    await docOfCaregiver.set(caregiver.toJson());
    return docOfCaregiver.id;
  }

  static Future<String> createLearner(Learner learner) async {
    final docOfLearner = FirebaseFirestore.instance.collection('learner').doc();
    learner.user_id = docOfLearner.id;
    await docOfLearner.set(learner.toJson());
    return docOfLearner.id;
  }

  static Future<bool> compareLearnerEmail(emailCon) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _fireStore.collection('learner').get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    List<String> emails = [];
    bool ans = false;
    allData.forEach((learner) {
      emails.add(learner
          .toString()
          .replaceAll(new RegExp(r'[{}]'), '')
          .split(",")[5]
          .split("email: ")[1]);
    });

    for (var email in emails) {
      if (emailCon == email) {
        ans = true;
        break;
      } else {
        ans = false;
      }
    }
    print(ans);
    return ans;
  }

  static Stream<List> giveAllCaregivers() => FirebaseFirestore.instance
      .collection('caregiver')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Caregiver.fromJson(doc.data())).toList());

  static Future<bool> isDuplicateEmail(String email) async {
    bool a = false;
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('caregiver')
        .where('email', isEqualTo: email)
        .get();
    if (query == true) {
      print(query);
      a = true;
      print(a);
      return a;
    } else {
      print(query);
      print(a);
      return a;
    }
    // return query.docs.isNotEmpty;
  }

  static final _fireStore = FirebaseFirestore.instance;

  static Future<bool> compareEmail(emailCon) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await _fireStore.collection('caregiver').get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<String> emails = [];
    bool ans = false;
    allData.forEach((caregiver) {
      emails.add(caregiver
          .toString()
          .replaceAll(new RegExp(r'[{}]'), '')
          .split(",")[4]
          .split("email: ")[1]);
    });

    for (var email in emails) {
      if (emailCon == email) {
        ans = true;
        break;
      } else {
        ans = false;
      }
    }

    return ans;
  }

  static Future<String> returnCredentials(emailCon) async {
    print("returnCredentials is the prob");
    QuerySnapshot querySnapshot =
        await _fireStore.collection('caregiver').get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // print(allData);
    String e = "";
    List<String> emails = [];
    allData.forEach((caregiver) {
      emails.add(caregiver
          .toString()
          .replaceAll(new RegExp(r'[{}]'), '')
          .split(",")[4]
          .split("email: ")[1]);
    });
    for (var email in emails) {
      if (emailCon == email) {
        e = email;
        break;
      } else {
        continue;
      }
    }
    return e;
  }

  static Future<String> returnName(String user) async {
    QuerySnapshot querySnapshot;
    // if (user.substring(0, 1) == "c") {
    querySnapshot = await _fireStore.collection('caregiver').get();
    // } else {
    //   querySnapshot = await _fireStore.collection('learner').get();
    // }
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    String? name = "";
    List<String> emails = [];
    Map<String, String> names = Map();
    allData.forEach((u) {
      emails.add(u
          .toString()
          .replaceAll(new RegExp(r'[{}]'), '')
          .split(",")[4]
          .split("email: ")[1]);

      names[u
              .toString()
              .replaceAll(new RegExp(r'[{}]'), '')
              .split(",")[4]
              .split("email: ")[1]] =
          (u
              .toString()
              .replaceAll(new RegExp(r'[{}]'), '')
              .split(",")[0]
              .split("first_name: ")[1]);
    });

    return names[user.substring(2)]!;
  }

  static Future<List<Caregiver>?> getCaregivers() async {
    final doc = await _fireStore.collection('caregiver').get();
    final allData = doc.docs.map((d) => d.data()).toList();
    if (allData.length > 0) {
      try {
        final a = allData.map((document) {
          Caregiver caregiver = Caregiver.fromJson(document);
          return (caregiver);
        }).toList();
        // print(a);
        return a;
      } catch (Exception) {
        print(Exception);
      }
    }
    return [];
  }

  // static Future<Caregiver> getCaregiver(email) async {
  //   final doc = await FirebaseFirestore.instance
  //       .collection('caregiver')
  //       .where('email', isEqualTo: email);

  //   print(doc.);

  //   return doc;
  // }

  static Future<String> getCurrentCaregiver(email) async {
    String user = "";
    final getAll = await getCaregivers();
    for (int i = 0; i > getAll!.length; i++) {
      if (getAll[i].email == email) {
        user = getAll[i].getFirstName();
        break;
      }
    }
    return user;
  }

  static Future<String> profilePicture(email) async {
    // print(await FirebaseApi.getCurrentCaregiver(getUserEmail()).toString());
    // print(await FirebaseApi.giveAllCaregivers());

    final pp = await FirebaseStorage.instance
        .ref()
        .child("profilephoto/${email}")
        .getDownloadURL();

    return pp;
  }

  static Future<Caregiver>? getCurrentCaregiverName(String email) async {
    final a = await FirebaseFirestore.instance
        .collection('caregiver')
        .where('email', isEqualTo: email)
        .get();
    Caregiver c = new Caregiver(
      user_id: a.docs[0]['caregiverID'],
      first_name: a.docs[0]['first_name'],
      last_name: a.docs[0]['last_name'],
      email: a.docs[0]['email'],
      password: a.docs[0]['password'],
      about_description: a.docs[0]['about_description'],
      profile_pic: a.docs[0]['profile_pic'],
    );
    return c;
  }

  static updateImage(String image, String email) async {
    final a = await FirebaseFirestore.instance
        .collection('caregiver')
        .where('email', isEqualTo: email)
        .get();
    Caregiver c = new Caregiver(
      user_id: a.docs[0]['caregiverID'],
      first_name: a.docs[0]['first_name'],
      last_name: a.docs[0]['last_name'],
      email: a.docs[0]['email'],
      password: a.docs[0]['password'],
      about_description: a.docs[0]['about_description'],
      profile_pic: a.docs[0]['profile_pic'],
    );
    final docUser =
        FirebaseFirestore.instance.collection('caregiver').doc(c.user_id);

    await docUser.update({'profile_pic': image});
  }

  static updateImageLearner(String image, String email) async {
    // print(image);
    final a = await FirebaseFirestore.instance
        .collection('learner')
        .where('email', isEqualTo: email)
        .get();
    Learner l = new Learner(
        user_id: a.docs[0]['learnerID'],
        first_name: a.docs[0]['firstName'],
        last_name: a.docs[0]['lastName'],
        email: a.docs[0]['email'],
        password: a.docs[0]['password'],
        about_description: a.docs[0]['about_description'],
        profile_pic: a.docs[0]['profile_pic'],
        caregiver_assigned: a.docs[0]['caregiverAssigned'],
        birth_date: a.docs[0]['birth_date']);

    // print("1: " + l.toString());

    final docUser =
        FirebaseFirestore.instance.collection('learner').doc(l.user_id);
    // print("2: " + docUser.toString());
    await docUser.update({'profile_pic': image});
  }

  static updateDescription(String desc) async {
    final a = await FirebaseFirestore.instance
        .collection('caregiver')
        .where('email', isEqualTo: UserProvider.getUserEmail())
        .get();
    Caregiver c = new Caregiver(
      user_id: a.docs[0]['caregiverID'],
      first_name: a.docs[0]['first_name'],
      last_name: a.docs[0]['last_name'],
      email: a.docs[0]['email'],
      password: a.docs[0]['password'],
      about_description: a.docs[0]['about_description'],
      profile_pic: a.docs[0]['profile_pic'],
    );
    final docUser =
        FirebaseFirestore.instance.collection('caregiver').doc(c.user_id);
    await docUser.update({'about_description': desc});
  }

  static deleteLearner(Learner learner) async {
//delete from db
    final deleteLearner = await FirebaseFirestore.instance
        .collection("learner")
        .doc(learner.user_id)
        .delete()
        .then((value) => print("deleted!"));
//delete from firestore
    final path = "profilephoto/${learner.user_id}";
    final ref = FirebaseStorage.instance.ref().child(path);
    ref
        .delete()
        .then((value) => print("deleted image!"))
        .catchError((error) => {print(error)});
  }

  static deleteCaregiver(String caregiverEmail) async {
    //locating caregiver
    final queryCar = await FirebaseFirestore.instance
        .collection('caregiver')
        .where('email', isEqualTo: caregiverEmail)
        .get();
    final allDataCar = queryCar.docs.map((doc) => doc.data()).toList();

    allDataCar.forEach((element) async {
      Caregiver caregiver = Caregiver.fromJson(element);
      try {
        UserProvider.user!.delete();
        FirebaseAuth.instance.signOut();
      } catch (error) {
        print("ERROR with deleting current user: " + error.toString());
      }

      //get all learners who have the caregiver assigned
      final query = await FirebaseFirestore.instance
          .collection('learner')
          .where('caregiverAssigned', isEqualTo: caregiverEmail)
          .get();
      final allData =
          query.docs.map((doc) => doc.data()).toList(); //convert to list

      allData.forEach((element) async {
        //loop over and delete learners
        Learner learner = Learner.fromJson(element);
        deleteLearner(learner);
      });

//delete from db
      final deleteCaregiver = await FirebaseFirestore.instance
          .collection("caregiver")
          .doc(caregiver.user_id)
          .delete()
          .then((value) => print("deleted!"));
//delete from storage
      final path = "profilephoto/${caregiver.user_id}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref
          .delete()
          .then((value) => print("deleted image!"))
          .catchError((error) => {print(error)});
    });
  }

  static Future<String> getPPStatus(email) async {
    //work on retrieving image
    final a = await FirebaseFirestore.instance
        .collection('caregiver')
        .where('email', isEqualTo: email)
        .get();
    Caregiver c = new Caregiver(
      user_id: a.docs[0]['caregiverID'],
      first_name: a.docs[0]['first_name'],
      last_name: a.docs[0]['last_name'],
      email: a.docs[0]['email'],
      password: a.docs[0]['password'],
      about_description: a.docs[0]['about_description'],
      profile_pic: a.docs[0]['profile_pic'],
    );
    // print("PROFILE: " + c.profile_pic);
    return c.profile_pic;
  }

//KEY THAT WORKS FOR ALL IN THE CODE BELOW!!!
  static Future<Caregiver> getCaregiverObj(email) async {
    final pp = await FirebaseStorage.instance
        .ref()
        .child("profilephoto/${email}")
        .getDownloadURL();
    final a = await FirebaseFirestore.instance
        .collection('caregiver')
        .where('email', isEqualTo: email)
        .get();
    Caregiver c = new Caregiver(
      user_id: a.docs[0]['caregiverID'],
      first_name: a.docs[0]['first_name'],
      last_name: a.docs[0]['last_name'],
      email: a.docs[0]['email'],
      password: a.docs[0]['password'],
      about_description: a.docs[0]['about_description'],
      profile_pic: a.docs[0]['profile_pic'],
    );
    c.profile_pic = pp;
    // print("LOOK HERE: "+c.toString());
    return c;
  }
  /////////

  static Future<String> returnCredentialsLearner(emailCon) async {
    QuerySnapshot querySnapshot = await _fireStore.collection('learner').get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    String e = "";
    List<String> emails = [];
    allData.forEach((learner) {
      emails.add(learner
          .toString()
          .replaceAll(new RegExp(r'[{}]'), '')
          .split(",")[5]
          .split("email: ")[1]);
    });
    for (var email in emails) {
      if (emailCon == email) {
        e = email;
        break;
      } else {
        continue;
      }
    }
    return e;
  }

  static Future<String> returnImageLearner(email) async {
    final pp = await FirebaseStorage.instance
        .ref()
        .child("profilephoto/${email}")
        .getDownloadURL();
    // print("PROFILEEEE: " + pp);
    return pp;
  }

  static Future<bool> checkPassword(emailCon, passCon) async {
    // print("checkPassword is the prob");
    bool correct = false;
    if (await returnCredentials(emailCon) != "") {
      QuerySnapshot querySnapshot =
          await _fireStore.collection('caregiver').get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      // print(allData);
      List<String> pass = [];
      allData.forEach((caregiver) {
        pass.add(caregiver
            .toString()
            .replaceAll(new RegExp(r'[{}]'), '')
            .split(",")[2]
            .split("password:")[1]
            .trim());
      });
      // print(pass);
      for (var p in pass) {
        bool passBool = Utils().isValid(p, passCon);
        if (passBool == true) {
          correct = true;
          break;
        } else {
          continue;
        }
      }
      return correct;
    } else {
      return correct;
    }
  }

  static Future<bool> checkPasswordLearner(emailCon, passCon) async {
    bool correct = false;
    if (await returnCredentialsLearner(emailCon) != "") {
      QuerySnapshot querySnapshot =
          await _fireStore.collection('learner').get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      List<String> pass = [];
      allData.forEach((learner) {
        pass.add(learner
            .toString()
            .replaceAll(new RegExp(r'[{}]'), '')
            .split(",")[4]
            .split("password:")[1]
            .trim());
      });
      for (var p in pass) {
        bool passBool = Utils().isValid(p, passCon);

        // if (passCon == p) {
        if (passBool == true) {
          correct = true;
          break;
        } else {
          continue;
        }
      }
      return correct;
    } else {
      return correct;
    }
  }

  static Future<List<Learner>>? getAllLearners() async {
    final query = await FirebaseFirestore.instance
        .collection('learner')
        .where('caregiverAssigned', isEqualTo: UserProvider.getUserEmail())
        .get();

    final allData = query.docs.map((doc) => doc.data()).toList();

    if (allData.length > 0) {
      try {
        final a = allData.map((document) {
          Learner learner = Learner.fromJson(document);
          return (learner);
        }).toList();
        // print("HERRR: " + a.toString());
        return a;
      } catch (Exception) {
        //     print(Exception);
      }
    }
    return [];
  }

  //TASK related methods//
  static addTaskAndSubtasks(
      t.Task task, List<Subtask> subtasks, String learner_id) async {
    print("here??");
    try {
      final docOfTask = FirebaseFirestore.instance.collection('task').doc();
      task.task_id = docOfTask.id;
      task.subtasks = [
        subtasks.isEmpty ? "" : task.task_id + "-subtaskone",
        subtasks.isEmpty ? "" : task.task_id + "-subtasktwo"
      ];

      await docOfTask.set(task.toJson());

      if (true) {
        print("tat hete??");
        if (subtasks.isNotEmpty) {
          final docOfSubtask1 =
              FirebaseFirestore.instance.collection('subtask').doc();
          subtasks[0].subtask_id = task.task_id + "-subtaskone";
          await docOfSubtask1.set(subtasks[0].toJson());

          final docOfSubtask2 =
              FirebaseFirestore.instance.collection('subtask').doc();
          subtasks[1].subtask_id = task.task_id + "-subtasktwo";
          await docOfSubtask2.set(subtasks[1].toJson());

          final docOfTask_Learner =
              FirebaseFirestore.instance.collection('learner_tasks').doc();
          Learner_Tasks newLearnerTasks =
              new Learner_Tasks(task_id: task.task_id, user_id: learner_id);
          await docOfTask_Learner.set(newLearnerTasks.toJson());
        } else {}
      }
    } catch (error) {
      print("error with creating new task or subtask");
    }
    return task.task_id;
  }

  deleteTask(t.Task task, List<String> subtasks) async {
    final deleteTask = await FirebaseFirestore.instance
        .collection("task")
        .doc(task.task_id)
        .delete()
        .then((value) => print("task deleted!"));
//delete from firestore
    final path = "taskVideos/${task.name}";
    final ref = FirebaseStorage.instance.ref().child(path);
    ref
        .delete()
        .then((value) => print("deleted task video!"))
        .catchError((error) => {print(error)});
    //put deleteSubtask() method here
    final sub1 = await FirebaseFirestore.instance
        .collection("subtask")
        .where('subtask_id', isEqualTo: task.task_id + "subtask" + "one")
        .get();

    final sub2 = await FirebaseFirestore.instance
        .collection("subtask")
        .where('subtask_id', isEqualTo: task.task_id + "subtask" + "two")
        .get();

    final deletesub1 = await FirebaseFirestore.instance
        .collection("subtask")
        .doc(sub1.docs[0].id)
        .delete()
        .then((value) => print("subtask1 deleted!"));

    final deletesub2 = await FirebaseFirestore.instance
        .collection("subtask")
        .doc(sub2.docs[0].id)
        .delete()
        .then((value) => print("subtask2 deleted!"));

    final learnertask = await FirebaseFirestore.instance
        .collection("learner_tasks")
        .where('task_id', isEqualTo: task.task_id)
        .get();

    final deletelearnertask = await FirebaseFirestore.instance
        .collection("learner_tasks")
        .doc(learnertask.docs[0].id)
        .delete()
        .then((value) => print("learner_tasks deleted!"));

    subtasks.forEach((String title) {
      final path = "subtaskImages/${title}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref
          .delete()
          .then((value) => print("deleted!"))
          .catchError((error) => {print(error)});
    });
  }

  updateTask(
      String id,
      String title,
      String description,
      String date,
      String startTime,
      String endTime,
      String remindTask,
      int rewardPoints,
      String vid) async {
    //getting the collection itself
    final updateT = await FirebaseFirestore.instance
        .collection('task')
        .where('task_id', isEqualTo: id)
        .get();

    t.Task ta = new t.Task(
      task_id: updateT.docs[0]['task_id'],
      name: title == null ? updateT.docs[0]['name'] : title,
      description:
          description == null ? updateT.docs[0]['description'] : description,
      date: date == null ? updateT.docs[0]['date'] : date,
      start_time: startTime == null ? updateT.docs[0]['start_time'] : startTime,
      end_time: endTime == null ? updateT.docs[0]['end_time'] : endTime,
      rewards: rewardPoints == null ? updateT.docs[0]['rewards'] : rewardPoints,
      reminder: remindTask == null ? updateT.docs[0]['reminder'] : remindTask,
      video: vid == null ? updateT.docs[0]['video'] : vid,
      subtasks: updateT.docs[0]['subtasks'],
    );
    //getting the doc
    final docTask = FirebaseFirestore.instance.collection('task').doc(id);
    await docTask.update({
      'task_id': ta.task_id,
      'description': ta.description,
      'name': ta.name,
      'date': ta.date,
      'start_time': ta.start_time,
      'end_time': ta.end_time,
      'rewards': ta.rewards,
      'reminder': ta.reminder,
      'video': ta.video,
      'subtasks': ta.subtasks
    });

    final path = "taskVideos/${updateT.docs[0]['name']}";
    final ref = FirebaseStorage.instance.ref().child(path);
    ref
        .delete()
        .then((value) => print("deleted!"))
        .catchError((error) => {print(error)});
    final pathNEW = "taskVideos/${ta.name}";
    final refNEW = FirebaseStorage.instance.ref().child(pathNEW);
    await refNEW.putFile(File(vid));
  }

  updateSubtasks(
      String subtask1_id,
      String subtask2_id,
      String title1,
      String title2,
      String image1,
      String image2,
      String startTime,
      int duration,
      int rewardPoints1,
      int rewardPoints2,) {
    //put code for updating subtask details and info
  }
  deleteSubtasks() {
    //put code for deleting subtask(s)
  }

  getAllTasks() {}

  //do for all of subtasks as well, and put a check for subtasks included or not with length retrieved from db
}
