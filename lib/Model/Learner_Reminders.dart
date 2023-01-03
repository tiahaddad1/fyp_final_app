import 'package:flutter/material.dart';

class Learner_Reminders{
  String reminder_id;
  String user_id;

  Learner_Reminders({
    required this.reminder_id,
    required this.user_id,
  });
    factory Learner_Reminders.fromJson(Map<String, dynamic> json) {
    return Learner_Reminders(
      reminder_id: json['reminder_id'],
      user_id: json['user_id'],
    );
  }

    Map<String, dynamic> toJson() => {
        'reminder_id': reminder_id,
        'user_id': user_id,
      };

    String getReminderID() {
    return this.reminder_id;
  }

    String getUserID() {
    return this.user_id;
  }

   setReminderID(String reminder_id) {
     this.reminder_id=reminder_id;
  }
    setUserID(String userID) {
    this.user_id = userID;
  }


  }
