import 'package:flutter/material.dart';

class Reward {
   String reward_id;
   String name;
   int points;
   String image;

  Reward({
    required this.reward_id,
    required this.name,
    required this.points,
    required this.image,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      reward_id: json['reward_id'],
      name: json['name'],
      points: json['points'],
      image: json['image'],
    );
  }

      Map<String, dynamic> toJson() => {
        'reward_id': reward_id,
        'name': name,
        'points': points,
        'image':image,
      };

  String getRewardID() {
    return this.reward_id;
  }

  String getName() {
    return this.name;
  }

  int getPoints() {
    return this.points;
  }

  String getImage() {
    return this.image;
  }

   setRewardID(String reward_id) {
     this.reward_id=reward_id;
  }

   setName(String name) {
     this.name=name;
  }

   setPoints(int points) {
     this.points=points;
  }

   setImage(String image) {
     this.image=image;
  }  

}
