import 'package:flutter/material.dart';

import 'Subtask.dart';

class Subtask_One extends Subtask{

  Subtask_One({
    required super.subtask_id,
    required super.name,
    required super.time,
    required super.duration,
    required super.image,
    required super.rewards,
  });

  factory Subtask_One.fromJson(Map<String, dynamic> json) {
    return Subtask_One(
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
