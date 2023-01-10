import 'package:flutter/material.dart';

import 'Subtask.dart';

class Subtask_Two extends Subtask{

  Subtask_Two({
    required super.subtask_id,
    required super.name,
    required super.time,
    required super.duration,
    required super.image,
    required super.rewards,
  });

  factory Subtask_Two.fromJson(Map<String, dynamic> json) {
    return Subtask_Two(
      subtask_id: json['subtask_id'],
      name: json['name'],
      time: json['time'],
      duration: json['duration'],
      image: json['image'],   
      rewards: json['points'],       
    );
  }

    Map<String, dynamic> toJson() => {
        'subtask_id': subtask_id,
        'name': name,
        'time': time,
        'duration': duration,
        'image':image,
        'rewards':rewards,
      };
      
}
