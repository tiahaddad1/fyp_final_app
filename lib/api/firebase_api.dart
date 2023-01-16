import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_application/Model/Learner_Reminders.dart';
import 'package:fyp_application/Model/Learner_Rewards.dart';
import 'package:fyp_application/Model/Learner_Tasks.dart';
import 'package:fyp_application/Model/Subtask.dart';
import 'package:fyp_application/Model/SubtaskOne.dart';
import 'package:fyp_application/Model/SubtaskTwo.dart';
import 'package:fyp_application/Provider/User-provider.dart';
import 'package:fyp_application/Provider/learner.dart';
import 'package:fyp_application/Utils.dart';
import 'package:fyp_application/View/learnerReminders.dart';
import 'package:intl/intl.dart';
import '../Model/Learner.dart';
import '../Model/Learner_Skills.dart';
import '../Model/Reminder.dart';
import '../Model/Reward.dart';
import '../Model/Skill.dart';
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

  static Future<Learner>? getCurrentLearner(String email) async {
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
        birth_date: a.docs[0]['birth_date'],
        caregiver_assigned: a.docs[0]['caregiverAssigned']);
    return l;
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

  static updateDescriptionLearner(String desc) async {
    final a = await FirebaseFirestore.instance
        .collection('learner')
        .where('email', isEqualTo: UserProvider.getUserEmail())
        .get();
    Learner l = new Learner(
        user_id: a.docs[0]['learnerID'],
        first_name: a.docs[0]['firstName'],
        last_name: a.docs[0]['lastName'],
        email: a.docs[0]['email'],
        password: a.docs[0]['password'],
        about_description: a.docs[0]['about_description'],
        profile_pic: a.docs[0]['profile_pic'],
        birth_date: a.docs[0]['birth_date'],
        caregiver_assigned: a.docs[0]['caregiverAssigned']);

    final docUser =
        FirebaseFirestore.instance.collection('learner').doc(l.user_id);
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

  static Future<String> getTaskVideo(String taskName) async {
    final storageRef = FirebaseStorage.instance.ref().child(taskName);
    final String url = await storageRef.getDownloadURL();
    print(url);
    return url;
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
        } else {
          final docOfTask_Learner =
              FirebaseFirestore.instance.collection('learner_tasks').doc();
          Learner_Tasks newLearnerTasks =
              new Learner_Tasks(task_id: task.task_id, user_id: learner_id);
          await docOfTask_Learner.set(newLearnerTasks.toJson());
        }
      }
    } catch (error) {
      print("error with creating new task or subtask");
    }
    return task.task_id;
  }

  static deleteTask(t.Task task) async {
    List<String> subtask_no = ['one', 'two'];

    subtask_no.forEach((no) async {
      final updateSubtask = await FirebaseFirestore.instance
          .collection('subtask')
          .where('subtask_id', isEqualTo: task.task_id + "-subtask" + no)
          .get();

      await FirebaseFirestore.instance
          .collection("subtask")
          .doc(updateSubtask.docs[0].id)
          .delete()
          .then((value) => print("subtask ${no} deleted!"));

      //  subtasks.forEach((String title) {
      final path = "subtaskImages/${updateSubtask.docs[0]['name']}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref
          .delete()
          .then((value) => print("deleted!"))
          .catchError((error) => {print(error)});
      // });
    });

    await FirebaseFirestore.instance
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

    // final sub1 = await FirebaseFirestore.instance
    //     .collection("subtask")
    //     .where('subtask_id', isEqualTo: task.task_id + "-subtask" + "one")
    //     .get();

    // final sub2 = await FirebaseFirestore.instance
    //     .collection("subtask")
    //     .where('subtask_id', isEqualTo: task.task_id + "-subtask" + "two")
    //     .get();

    // await FirebaseFirestore.instance
    //     .collection("subtask")
    //     .doc(sub1.docs[0].id)
    //     .delete()
    //     .then((value) => print("subtask1 deleted!"));

    // await FirebaseFirestore.instance
    //     .collection("subtask")
    //     .doc(sub2.docs[0].id)
    //     .delete()
    //     .then((value) => print("subtask2 deleted!"));

    final learnertask = await FirebaseFirestore.instance
        .collection("learner_tasks")
        .where('task_id', isEqualTo: task.task_id)
        .get();

    await FirebaseFirestore.instance
        .collection("learner_tasks")
        .doc(learnertask.docs[0].id)
        .delete()
        .then((value) => print("learner_tasks deleted!"));

    // subtasks.forEach((String title) {
    //   final path = "subtaskImages/${title}";
    //   final ref = FirebaseStorage.instance.ref().child(path);
    //   ref
    //       .delete()
    //       .then((value) => print("deleted!"))
    //       .catchError((error) => {print(error)});
    // });
  }

  static updateTask(
      String id,
      String title,
      String description,
      String date,
      String startTime,
      String endTime,
      int remindTask,
      int rewardPoints,
      String vid) async {
    //getting the collection itself
    final updateT = await FirebaseFirestore.instance
        .collection('task')
        .where('task_id', isEqualTo: id)
        .get();
    print("actual: " + updateT.docs[0]['video']);
    print("updated: " + vid);

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
    try {
      final path = "taskVideos/${updateT.docs[0]['name']}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref
          .delete()
          .then((value) => print("deleted!"))
          .catchError((error) => {print(error)});

      final pathNEW = "taskVideos/${ta.name}";
      final refNEW = FirebaseStorage.instance.ref().child(pathNEW);
      await refNEW.putFile(File(vid));
    } catch (error) {
      print("error with photo");
      final pathNEW = "taskVideos/${ta.name}";
      final refNEW = FirebaseStorage.instance.ref().child(pathNEW);
      await refNEW.putFile(File(vid));
    }
  }

  //create a method that indicates whether the task has subtasks or not
  static bool hasSubtasks(t.Task task) {
    if (task.subtasks.contains(null)) {
      return false;
    } else {
      return true;
    }
  }

  //create a method that gives the subtask object as array
  static Future<List<Subtask>?> getSubtasks(String task_id) async {
    List<String> subtask_no = ['one', 'two'];
    List<Subtask> subtaskss = [];

    subtask_no.forEach((no) async {
      final updateSubtask = await FirebaseFirestore.instance
          .collection('subtask')
          .where('subtask_id', isEqualTo: task_id + "-subtask" + no)
          .get();

      Subtask subtask = new Subtask(
          subtask_id: updateSubtask.docs[0]['subtask_id'],
          name: updateSubtask.docs[0]['name'],
          time: updateSubtask.docs[0]['time'],
          duration: updateSubtask.docs[0]['duration'],
          image: updateSubtask.docs[0]['image'],
          rewards: updateSubtask.docs[0]['rewards']);
      print("im inside the loop: " + updateSubtask.docs[0]['subtask_id']);
      subtaskss.add(subtask);
    });
    if (subtaskss.length == 0) {
      return null;
    } else {
      print(subtaskss[0].name);
      return subtaskss;
    }
  }

  static updateSubtasks(
    String subtask1_id,
    String subtask2_id,
    String title1,
    String title2,
    String image1,
    String image2,
    String startTime,
    int duration,
    int rewardPoints1,
    int rewardPoints2,
  ) async {
    List<String> subtask_no = ['one', 'two'];
    subtask_no.forEach((no) async {
      final updateSubtask = await FirebaseFirestore.instance
          .collection('subtask')
          .where('subtask_id',
              isEqualTo: no == 'one' ? subtask1_id : subtask2_id)
          .get();

      Subtask subtask = new Subtask(
          subtask_id: updateSubtask.docs[0]['subtask_id'],
          name: no == 'one'
              ? title1 == null
                  ? updateSubtask.docs[0]['name']
                  : title1
              : title2 == null
                  ? updateSubtask.docs[0]['name']
                  : title2,
          time: startTime == null ? updateSubtask.docs[0]['time'] : startTime,
          duration:
              duration == null ? updateSubtask.docs[0]['duration'] : duration,
          image: no == 'one'
              ? image1 == null
                  ? updateSubtask.docs[0]['image']
                  : image1
              : image2,
          rewards: no == 'one'
              ? rewardPoints1 == null
                  ? updateSubtask.docs[0]['rewards']
                  : rewardPoints1
              : rewardPoints2);

      await FirebaseFirestore.instance
          .collection("subtask")
          .doc(updateSubtask.docs[0].id)
          .update({
        'subtask_id': no == 'one' ? subtask1_id : subtask2_id,
        'name': no == 'one' ? title1 : title2,
        'time': startTime,
        'duration': duration,
        'image': no == 'one' ? image1 : image2,
        'rewards': no == 'one' ? rewardPoints1 : rewardPoints2
      });

      final path = "subtaskImages/${updateSubtask.docs[0]['name']}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref
          .delete()
          .then((value) => print(ref.delete() == null))
          .catchError((error) => {print(error)});

      final pathNEW = "subtaskImages/${subtask.name}";
      final refNEW = FirebaseStorage.instance.ref().child(pathNEW);
      final put = refNEW.putFile(File(no == 'one' ? image1 : image2));
      await put.whenComplete(() => print("doneee subtask"));
    });
  }

  deleteSubtasks(t.Task task, List<String> subtasks) async {
    List<String> subtask_no = ['one', 'two'];

    subtask_no.forEach((no) async {
      final updateSubtask = await FirebaseFirestore.instance
          .collection('subtask')
          .where('subtask_id', isEqualTo: task.task_id + "-subtask" + no)
          .get();

      await FirebaseFirestore.instance
          .collection("subtask")
          .doc(updateSubtask.docs[0].id)
          .delete()
          .then((value) => print("subtask ${no} deleted!"));
    });

    subtasks.forEach((String title) {
      final path = "subtaskImages/${title}";
      final ref = FirebaseStorage.instance.ref().child(path);
      ref
          .delete()
          .then((value) => print("deleted!"))
          .catchError((error) => {print(error)});
    });
  }

  static Future<List<t.Task>> getAllTasks(
      DateTime selectedDate, String learner_id) async {
    //pass the selected date
    //select the task table and take the tasks from the selecte ddate
    //return that list

//should be this:
    // String? currentL = await LearnerProvider.readFromLocalStorage();
//what works:
    // String currentL = "JzEyiITsGIuF4YM46TTx";
    // print("TIAAAA: "+learner_id);
    // print("current learner is: " + currentL);
    String d = selectedDate.toString().substring(0, 10);
    DateTime selectedDateString = DateFormat("yyyy-MM-dd").parse(d);
    String formatD = DateFormat("M/dd/yyyy").format(selectedDateString);
    print(DateTime.parse(d));

    final learnertasks = await FirebaseFirestore.instance
        .collection('learner_tasks')
        .where('user_id', isEqualTo: learner_id)
        .get();

    final allData =
        learnertasks.docs.map((learnertask) => learnertask.data()).toList();
    late List<Learner_Tasks> list = [];

    if (allData.length > 0) {
      try {
        //a list that loops through every element and assigns it to the object
        //learner_task
        list = allData.map((document) {
          Learner_Tasks learnertask = Learner_Tasks.fromJson(document);
          return (learnertask);
        }).toList();
      } catch (Exception) {
        print("list is empty, so null");
      }
    }
    late List<t.Task> taskss = [];

    if (list.length > 0) {
      try {
        list.forEach((lt) async {
          final checkTask = await FirebaseFirestore.instance
              .collection('task')
              .where('task_id', isEqualTo: lt.task_id) //equals to the learner
              .where('date', isEqualTo: formatD) //equals to the selected date
              .get();

          if (checkTask.size > 0) {
            t.Task ta = new t.Task(
              task_id: checkTask.docs[0]['task_id'],
              name: checkTask.docs[0]['name'],
              description: checkTask.docs[0]['description'],
              date: checkTask.docs[0]['date'],
              start_time: checkTask.docs[0]['start_time'],
              end_time: checkTask.docs[0]['end_time'],
              rewards: checkTask.docs[0]['rewards'],
              reminder: checkTask.docs[0]['reminder'],
              video: checkTask.docs[0]['video'],
              subtasks: checkTask.docs[0]['subtasks'],
            );
            taskss.add(ta);
            print("size before:");
            print(taskss.length);
          }
        });
      } catch (error) {
        print(error);
      }
    } else {
      print("the list is empty");
    }
    print("size after:");
    print(taskss.length);
    return taskss;
  }

  static Future<List<t.Task>> getAllTasksLearner(
      DateTime selectedDate, String learner_id) async {
    //pass the selected date
    //select the task table and take the tasks from the selecte ddate
    //return that list

//should be this:
    // String? currentL = await LearnerProvider.readFromLocalStorage();
//what works:
    // String currentL = "JzEyiITsGIuF4YM46TTx";
    // print("TIAAAA: "+learner_id);
    // print("current learner is: " + currentL);
    String d = selectedDate.toString().substring(0, 10);
    DateTime selectedDateString = DateFormat("yyyy-MM-dd").parse(d);
    String formatD = DateFormat("M/dd/yyyy").format(selectedDateString);
    // print(DateTime.parse(d));

    final learnertasks = await FirebaseFirestore.instance
        .collection('learner_tasks')
        .where('user_id', isEqualTo: learner_id)
        .get();

    final allData =
        learnertasks.docs.map((learnertask) => learnertask.data()).toList();
    late List<Learner_Tasks> list = [];

    if (allData.length > 0) {
      try {
        print("1");
        //a list that loops through every element and assigns it to the object
        //learner_task
        list = allData.map((document) {
          Learner_Tasks learnertask = Learner_Tasks.fromJson(document);
          return (learnertask);
        }).toList();
      } catch (Exception) {
        print("list is empty, so null");
      }
    }
    late List<t.Task> taskss = [];

    // if (list.length > 0) {
    //   try {

    return Future.wait(list.map((lt) async {
      // print("2");
      final checkTask = await FirebaseFirestore.instance
          .collection('task')
          .where('task_id', isEqualTo: lt.task_id) //equals to the learner
          .where('date', isEqualTo: formatD) //equals to the selected date
          .get();

      t.Task ta = new t.Task(
        task_id: checkTask.docs[0]['task_id'],
        name: checkTask.docs[0]['name'],
        description: checkTask.docs[0]['description'],
        date: checkTask.docs[0]['date'],
        start_time: checkTask.docs[0]['start_time'],
        end_time: checkTask.docs[0]['end_time'],
        rewards: checkTask.docs[0]['rewards'],
        reminder: checkTask.docs[0]['reminder'],
        video: checkTask.docs[0]['video'],
        subtasks: checkTask.docs[0]['subtasks'],
      );
      taskss.add(ta);
      return Future.value(ta);
    })).then((List<t.Task> taskss) {
      print(taskss.length);
      print(taskss);
      return taskss;
    });
  }

  //SKILLS related methods//

  static addSkill(Skill skill, String learner_id) async {
    try {
      final docOfSkill = FirebaseFirestore.instance.collection('skill').doc();
      skill.skill_id = docOfSkill.id;

      await docOfSkill.set(skill.toJson());
      final docOfSkill_Learner =
          FirebaseFirestore.instance.collection('learner_skills').doc();
      Learner_Skills newLearnerSkills =
          new Learner_Skills(skill_id: skill.skill_id, user_id: learner_id);
      await docOfSkill_Learner.set(newLearnerSkills.toJson());
    } catch (error) {
      print("unable to create new skill");
    }
  }

  static deleteSkill(Skill skill) async {
    await FirebaseFirestore.instance
        .collection("skill")
        .doc(skill.skill_id)
        .delete()
        .then((value) => print("skill deleted!"));

//delete from firestore
    final path = "skillImages/${skill.name}";
    final ref = FirebaseStorage.instance.ref().child(path);
    ref
        .delete()
        .then((value) => print("deleted skill image!"))
        .catchError((error) => {print(error)});

//delete learnerskill from db
    final learnerskill = await FirebaseFirestore.instance
        .collection("learner_skills")
        .where('skill_id', isEqualTo: skill.skill_id)
        .get();

    await FirebaseFirestore.instance
        .collection("learner_skills")
        .doc(learnerskill.docs[0].id)
        .delete()
        .then((value) => print("learner_skills deleted!"));
  }

  static updateSkill(String skill_id, String name, bool checked) async {
    final updateSkill = await FirebaseFirestore.instance
        .collection('skill')
        .where('skill_id', isEqualTo: skill_id)
        .get();

    Skill s = new Skill(
        skill_id: updateSkill.docs[0]['skill_id'],
        name: name == null || name == "" ? updateSkill.docs[0]['name'] : name,
        image: updateSkill.docs[0]['image'],
        date_completed: checked == true
            ? DateTime.now().toString().substring(0, 10)
            : updateSkill.docs[0]['date_completed'],
        is_completed: checked == true ? true : false);

    //getting the doc
    final docSkill =
        FirebaseFirestore.instance.collection('skill').doc(skill_id);

    await docSkill.update({
      'skill_id': s.skill_id,
      'name': s.name,
      'image': s.image,
      'date_completed': s.date_completed,
      'is_completed': s.is_completed,
    });
  }

  static Future<List<Skill>> getAllSkills(String learner_id) async {
    // print(learner_id);
    final learnerSkills = await FirebaseFirestore.instance
        .collection('learner_skills')
        .where('user_id', isEqualTo: learner_id)
        .get();

    final allData =
        learnerSkills.docs.map((learnerskill) => learnerskill.data()).toList();

    late List<Learner_Skills> list = [];

    if (allData.length > 0) {
      try {
        //a list that loops through every element and assigns it to the object
        //learner_task
        list = allData.map((document) {
          Learner_Skills learnersk = Learner_Skills.fromJson(document);
          return (learnersk);
        }).toList();
      } catch (Exception) {
        print("no skill for this learner");
      }
    }
    print("list:");
    print(list);

    List<Skill> skillsList = [];

    return Future.wait(list.map((ls) async {
      final checkSkill = await FirebaseFirestore.instance
          .collection('skill')
          .where('skill_id', isEqualTo: ls.skill_id)
          .get();
      Skill s = new Skill(
          skill_id: checkSkill.docs[0]['skill_id'],
          name: checkSkill.docs[0]['name'],
          image: checkSkill.docs[0]['image'],
          date_completed: checkSkill.docs[0]['date_completed'],
          is_completed: checkSkill.docs[0]['is_completed']);
      print("im hereeeee");
      skillsList.add(s);
      return Future.value(s);
    })).then((List<Skill> skills) {
      return skills;
    });

    // if (list.length > 0) {
    // try {
    // Future.wait(list.map((ls) async {

    //   final checkSkill = await FirebaseFirestore.instance
    //       .collection('skill')
    //       .where('skill_id', isEqualTo: ls.skill_id)
    //       .get();

    //   // if (checkSkill.size > 0) {
    //   Skill s = new Skill(
    //       skill_id: checkSkill.docs[0]['skill_id'],
    //       name: checkSkill.docs[0]['name'],
    //       image: checkSkill.docs[0]['image'],
    //       date_completed: checkSkill.docs[0]['date_completed'],
    //       is_completed: checkSkill.docs[0]['is_completed']);
    //   print("im hereeeee");
    //   // print(s);
    //   skillsList.add(s);
    // })).then((_) {
    //   print(skillsList.length);
    //   return skillsList;
    // });

    // list.forEach((ls) async {
    //   //print(ls.skill_id);

    //   final checkSkill = await FirebaseFirestore.instance
    //       .collection('skill')
    //       .where('skill_id', isEqualTo: ls.skill_id)
    //       .get();

    //   // if (checkSkill.size > 0) {
    //   Skill s = new Skill(
    //       skill_id: checkSkill.docs[0]['skill_id'],
    //       name: checkSkill.docs[0]['name'],
    //       image: checkSkill.docs[0]['image'],
    //       date_completed: checkSkill.docs[0]['date_completed'],
    //       is_completed: checkSkill.docs[0]['is_completed']);
    //   print("im hereeeee");
    //   // print(s);
    //   skillsList.add(s);
    //   // print(skillsList.length);
    //   print(skillsList.length);
    //   // }
    // });
    // print(skillsList);
    // print(skillsList.length);
    // } catch (error) {
    //   print(error);
    // }
    // } else {
    //   print("the list is empty");
    // }
    print("skills list:");
    print(skillsList.length);
    // print(skillsList);
    return skillsList;
  }

  //REMINDERS related methods//
  static addReminder(Reminder reminder, String learner_id) async {
    //first passes in an empty element then is updated with fields from db
    //reminder argument has (id from db, "")
    try {
      final docOfReminder =
          FirebaseFirestore.instance.collection('reminder').doc();
      reminder.reminder_id = docOfReminder.id;

      await docOfReminder.set(reminder.toJson());

      final docOfReminder_Learner =
          FirebaseFirestore.instance.collection('learner_reminders').doc();

      Learner_Reminders newLearnerReminders = new Learner_Reminders(
          reminder_id: reminder.reminder_id, user_id: learner_id);

      await docOfReminder_Learner.set(newLearnerReminders.toJson());
    } catch (error) {
      print("unable to create new reminder");
    }
  }

  static deleteReminder(Reminder reminder) async {
    await FirebaseFirestore.instance
        .collection("reminder")
        .doc(reminder.reminder_id)
        .delete()
        .then((value) => print("reminder deleted!"));

//delete learnerskill from db
    final learnerreminder = await FirebaseFirestore.instance
        .collection("learner_reminders")
        .where('reminder_id', isEqualTo: reminder.reminder_id)
        .get();

    await FirebaseFirestore.instance
        .collection("learner_reminders")
        .doc(learnerreminder.docs[0].id)
        .delete()
        .then((value) => print("learner_reminders deleted!"));
  }

  static updateReminder(String reminder_id, String name) async {
    final updateReminder = await FirebaseFirestore.instance
        .collection('reminder')
        .where('reminder_id', isEqualTo: reminder_id)
        .get();

    Reminder r = new Reminder(
      reminder_id: updateReminder.docs[0]['reminder_id'],
      name: name == null || name == "" ? updateReminder.docs[0]['name'] : name,
    );

    //getting the doc
    final docReminder =
        FirebaseFirestore.instance.collection('reminder').doc(reminder_id);

    await docReminder.update({
      'reminder_id': r.reminder_id,
      'name': r.name,
    });
  }

  static Future<List<Reminder>> getAllReminders(String learner_id) async {
    print(learner_id);
    final learnerReminders = await FirebaseFirestore.instance
        .collection('learner_reminders')
        .where('user_id', isEqualTo: learner_id)
        .get();

    final allData = learnerReminders.docs
        .map((learnerreminder) => learnerreminder.data())
        .toList();

    late List<Learner_Reminders> list = [];

    if (allData.length > 0) {
      try {
        //a list that loops through every element and assigns it to the object
        //learner_task
        list = allData.map((document) {
          Learner_Reminders learnerrm = Learner_Reminders.fromJson(document);
          return (learnerrm);
        }).toList();
      } catch (Exception) {
        print("no reminder for this learner");
      }
    }
    late List<Reminder> remindersList = [];
    // if (list.length > 0) {
    // try {
    return Future.wait(list.map((lr) async {
      final checkReminder = await FirebaseFirestore.instance
          .collection('reminder')
          .where('reminder_id', isEqualTo: lr.reminder_id)
          .get();
      Reminder r = new Reminder(
        reminder_id: checkReminder.docs[0]['reminder_id'],
        name: checkReminder.docs[0]['name'],
      );

      remindersList.add(r);
      return Future.value(r);
    })).then((List<Reminder> reminderss) {
      return reminderss;
    });

    list.forEach((lr) async {
      print(lr.reminder_id);

      final checkReminder = await FirebaseFirestore.instance
          .collection('reminder')
          .where('reminder_id', isEqualTo: lr.reminder_id)
          .get();

      // if (checkSkill.size > 0) {
      Reminder r = new Reminder(
        reminder_id: checkReminder.docs[0]['reminder_id'],
        name: checkReminder.docs[0]['name'],
      );

      remindersList.add(r);
      print(remindersList.length);
      // }
    });
    print(remindersList);
    // } catch (error) {
    //   print(error);
    // }
    // } else {
    //   print("the list is empty");
    // }
    print("reminder list:");
    print(remindersList.length);
    print(remindersList);
    return remindersList;
  }

  //REWARDS related methods//

  static addReward(Reward reward, String learner_id) async {
    try {
      final docOfReward = FirebaseFirestore.instance.collection('reward').doc();
      reward.reward_id = docOfReward.id;

      await docOfReward.set(reward.toJson());
      final docOfReward_Learner =
          FirebaseFirestore.instance.collection('learner_rewards').doc();
      Learner_Rewards newLearnerRewards =
          new Learner_Rewards(reward_id: reward.reward_id, user_id: learner_id);
      await docOfReward_Learner.set(newLearnerRewards.toJson());
    } catch (error) {
      print("unable to create new reward");
    }
  }

  static deleteReward(Reward reward) async {
    await FirebaseFirestore.instance
        .collection("reward")
        .doc(reward.reward_id)
        .delete()
        .then((value) => print("reward deleted!"));

//delete from firestore
    final path = "rewardImages/${reward.name}";
    final ref = FirebaseStorage.instance.ref().child(path);
    ref
        .delete()
        .then((value) => print("deleted reward image!"))
        .catchError((error) => {print(error)});

//delete learnerskill from db
    final learnerreward = await FirebaseFirestore.instance
        .collection("learner_rewards")
        .where('reward_id', isEqualTo: reward.reward_id)
        .get();

    await FirebaseFirestore.instance
        .collection("learner_rewards")
        .doc(learnerreward.docs[0].id)
        .delete()
        .then((value) => print("learner_rewards deleted!"));
  }

  static updateReward(String reward_id, String name, int points) async {
    final updateReward = await FirebaseFirestore.instance
        .collection('reward')
        .where('reward_id', isEqualTo: reward_id)
        .get();

    Reward r = new Reward(
        reward_id: updateReward.docs[0]['reward_id'],
        name: name == null || name == "" ? updateReward.docs[0]['name'] : name,
        image: updateReward.docs[0]['image'],
        points: points == null || points == 0
            ? updateReward.docs[0]['points']
            : points);

    //getting the doc
    final docReward =
        FirebaseFirestore.instance.collection('reward').doc(reward_id);

    await docReward.update({
      'reward_id': r.reward_id,
      'name': r.name,
      'image': r.image,
      'points': r.points
    });
  }

  static Future<List<Reward>> getAllRewards(String learner_id) async {
    print(learner_id);
    final learnerRewards = await FirebaseFirestore.instance
        .collection('learner_rewards')
        .where('user_id', isEqualTo: learner_id)
        .get();

    final allData = learnerRewards.docs
        .map((learnerreward) => learnerreward.data())
        .toList();

    late List<Learner_Rewards> list = [];

    if (allData.length > 0) {
      try {
        //a list that loops through every element and assigns it to the object
        //learner_task
        list = allData.map((document) {
          Learner_Rewards learnerr = Learner_Rewards.fromJson(document);
          return (learnerr);
        }).toList();
      } catch (Exception) {
        print("no rewards for this learner");
      }
    }
    late List<Reward> rewardsList = [];
    // if (list.length > 0) {
    // try {
    return Future.wait(list.map((lr) async {
      final checkReward = await FirebaseFirestore.instance
          .collection('reward')
          .where('reward_id', isEqualTo: lr.reward_id)
          .get();
      Reward rew = new Reward(
        reward_id: checkReward.docs[0]['reward_id'],
        name: checkReward.docs[0]['name'],
        image: checkReward.docs[0]['image'],
        points: checkReward.docs[0]['points'],
      );

      rewardsList.add(rew);
      return Future.value(rew);
    })).then((List<Reward> rewardss) {
      return rewardss;
    });
  }

  static Future<List<int>> getRewardsPoints(String learner_id) async {
    late List<int> points = [];

    List<Reward> allrewards = await getAllRewards(learner_id);

    return Future.wait(allrewards.map((reward) async {
      points.add(reward.points);
      return Future.value(reward.points);
    })).then((List<int> pointss) {
      return pointss;
    });
  }
}
