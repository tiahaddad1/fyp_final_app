import 'package:flutter/material.dart';

class Learner_Rewards{
  String reward_id;
  String user_id;

  Learner_Rewards({
    required this.reward_id,
    required this.user_id,
  });
    factory Learner_Rewards.fromJson(Map<String, dynamic> json) {
    return Learner_Rewards(
      reward_id: json['reward_id'],
      user_id: json['user_id'],
    );
  }

    Map<String, dynamic> toJson() => {
        'reward_id': reward_id,
        'user_id': user_id,
      };

    String getRewardID() {
    return this.reward_id;
  }

    String getUserID() {
    return this.user_id;
  }

   setRewardID(String reward_id) {
     this.reward_id=reward_id;
  }
    setUserID(String userID) {
    this.user_id = userID;
  }


  }
