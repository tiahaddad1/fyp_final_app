import 'dart:ffi';

import 'package:video_player/video_player.dart';

import 'Subtask.dart';

class Task {
  String task_id;
  String name;
  String description;
  String date;
  String start_time;
  String end_time;
  int rewards;
  int reminder;
  String video;
  List<String> subtasks;

  Task({
    required this.task_id,
    required this.name,
    required this.description,
    required this.date,
    required this.start_time,
    required this.rewards,
    required this.end_time,
    required this.reminder,
    required this.video,
    required this.subtasks
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      task_id: json['task_id'],
      name: json['name'],
      description: json['description'],
      date: json['date'],
      start_time: json['start_time'],
      rewards: json['rewards'],
      end_time: json['end_time'],
      reminder: json['reminder'],
      video: json['video'],
      subtasks:json['subtasks']
    );
  }
  Map<String, dynamic> toJson() => {
        'task_id': task_id,
        'name': name,
        'description': description,
        'date': date,
        'start_time': start_time,
        'rewards': rewards,
        'end_time': end_time,
        'reminder': reminder,
        'video': video,
        'subtasks': subtasks
      };

  String getTaskID() {
    return this.task_id;
  }

  String getName() {
    return this.name;
  }

  String getDescription() {
    return this.description;
  }

  String getStartTime() {
    return this.start_time;
  }

  String getEndTime() {
    return this.end_time;
  }

  int getRewards() {
    return this.rewards;
  }

  int getReminder() {
    return this.reminder;
  }

  String getVideo() {
    return this.video;
  }

  String getDate() {
    return this.date;
  }

  List<String> getSubTasks() {
    return this.subtasks;
  }

   setTaskID(String task_id) {
     this.task_id=task_id;
  }

   setName(String name) {
     this.name=name;
  }

   setDescription(String description) {
     this.description=description;
  }

   setStartTime(String start_time) {
     this.start_time=start_time;
  }

   setEndTime(String end_time) {
     this.end_time=end_time;
  }

   setRewards(int rewards) {
     this.rewards=rewards;
  }

   setReminder(int reminder) {
     this.reminder=reminder;
  }

   setVideo(String video) {
     this.video=video;
  }

   setDate(String date) {
     this.date=date;
  }

   setSubTasks(List<String> subtasks) {
     this.subtasks=subtasks;
  }

}
