import 'package:flutter/material.dart';
import 'package:fyp_application/Model/User.dart';
import 'Caregiver.dart';

class Learner extends User {
  String birth_date;
  String caregiver_assigned;

  Learner({
    required super.user_id,
    required super.first_name,
    required super.last_name,
    required super.email,
    required super.password,
    required super.about_description,
    required super.profile_pic,    
    required this.birth_date,
    required this.caregiver_assigned,
  });

  static Learner fromJson(Map<String, dynamic> json) => Learner(
      user_id: json['learnerID'],
      first_name: json['firstName'],
      last_name: json['lastName'],
      email: json['email'],
      password: json['password'],
      about_description: json['about_description'],
      profile_pic: json['profile_pic'],
      birth_date: json['birth_date'],
      caregiver_assigned: json['caregiverAssigned']);

  Map<String, dynamic> toJson() => {
        'learnerID': user_id,
        'firstName': first_name,
        'lastName': last_name,
        'email': email,
        'password': password,
        'about_description':about_description,
        'profile_pic':profile_pic,
        'birth_date': birth_date,
        'caregiverAssigned': caregiver_assigned,
      };


  String getCaregiverAssigned() {
    return this.caregiver_assigned;
  }

  String getDOB() {
    return this.birth_date;
  }


   setCaregiverAssigned(String caregiver) {
     this.caregiver_assigned=caregiver;
  }

   setDOB(String dob) {
     this.birth_date=dob;
  } 
}
