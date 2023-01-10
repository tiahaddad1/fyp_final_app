import 'package:flutter/material.dart';

class Learner_Tasks {
  String task_id;
  String user_id;

  Learner_Tasks({
    required this.task_id,
    required this.user_id,
  });
  factory Learner_Tasks.fromJson(Map<String, dynamic> json) {
    return Learner_Tasks(
      task_id: json['task_id'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'task_id': task_id,
        'user_id': user_id,
      };

  String getTaskID() {
    return this.task_id;
  }

  String getUserID() {
    return this.user_id;
  }

  setTaskID(String task_id) {
    this.task_id = task_id;
  }

  setUserID(String userID) {
    this.user_id = userID;
  }
}
