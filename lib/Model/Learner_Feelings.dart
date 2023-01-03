import 'package:flutter/material.dart';

class Learner_Feeling {
  String feeling_id;
  String user_id;

  Learner_Feeling({
    required this.feeling_id,
    required this.user_id,
  });
  factory Learner_Feeling.fromJson(Map<String, dynamic> json) {
    return Learner_Feeling(
      feeling_id: json['feeling_id'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'feeling_id': feeling_id,
        'user_id': user_id,
      };

  String getFeelingID() {
    return this.feeling_id;
  }

  String getUserID() {
    return this.user_id;
  }

  setFeelingID(String feeling_id) {
    this.feeling_id = feeling_id;
  }

  setUserID(String userID) {
    this.user_id = userID;
  }
}
