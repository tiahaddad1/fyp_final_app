import 'dart:ui';

import 'User.dart';

class Caregiver extends User {
  
  Caregiver({
    required super.user_id,    
    required super.first_name,
    required super.last_name,
    required super.email,
    required super.password,
    required super.about_description,
    required super.profile_pic,       
  });

  static Caregiver fromJson(Map<String, dynamic> json) => Caregiver(
        user_id:json['caregiverID'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        email: json['email'],
        password: json['password'],
        about_description: json['about_description'],
        profile_pic: json['profile_pic'],
      );

  Map<String, dynamic> toJson() => {
        'caregiverID': user_id,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'password': password,
        'about_description':about_description,
        'profile_pic':profile_pic
      };

}
