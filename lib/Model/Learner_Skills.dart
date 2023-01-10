import 'package:flutter/material.dart';

class Learner_Skills {
  String skill_id;
  String user_id;

  Learner_Skills({
    required this.skill_id,
    required this.user_id,
  });
  factory Learner_Skills.fromJson(Map<String, dynamic> json) {
    return Learner_Skills(
      skill_id: json['skill_id'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'skill_id': skill_id,
        'user_id': user_id,
      };

  String getSkillID() {
    return this.skill_id;
  }

  String getUserID() {
    return this.user_id;
  }

  setSkillID(String skill_id) {
    this.skill_id = skill_id;
  }

  setUserID(String userID) {
    this.user_id = userID;
  }
}
