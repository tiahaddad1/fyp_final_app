import 'package:flutter/material.dart';

class Skill {
  String skill_id;
  String name;
  bool is_completed;
  DateTime date_completed;
  String image;

  Skill({
    required this.skill_id,
    required this.name,
    required this.is_completed,
    required this.date_completed,
    required this.image,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      skill_id: json['skill_id'],
      name: json['name'],
      is_completed: json['is_completed'],
      date_completed: json['date_completed'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'skill_id': skill_id,
        'name': name,
        'is_completed': is_completed,
        'date_completed': date_completed,
        'image': image,
      };

  String getSkillID() {
    return this.skill_id;
  }

  String getName() {
    return this.name;
  }

  bool isCompleted() {
    return this.is_completed;
  }

  String getImage() {
    return this.image;
  }

  DateTime getDateCompleted() {
    return this.date_completed;
  }

  setSkillID(String skill_id) {
    this.skill_id = skill_id;
  }

  setName(String name) {
    this.name = name;
  }

  setIsCompleted(bool is_completed) {
    this.is_completed = is_completed;
  }

  setImage(String image) {
    this.image = image;
  }

  setDateCompleted(DateTime dateCompleted) {
    this.date_completed = dateCompleted;
  }
}
