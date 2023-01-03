
class Subtask {
  String subtask_id;
  String name;
  DateTime time;
  int duration;
  String image;
  int rewards;

  Subtask({
    required this.subtask_id,
    required this.name,
    required this.time,
    required this.duration,
    required this.image,
    required this.rewards,
  });

  factory Subtask.fromJson(Map<String, dynamic> json) {
    return Subtask(
      subtask_id: json['subtask_id'],
      name: json['name'],
      time: json['time'],
      duration: json['duration'],
      image: json['image'],
      rewards: json['rewards'],
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
  String getSubTaskID() {
    return this.subtask_id;
  }

  String getName() {
    return this.name;
  }

  DateTime getTime() {
    return this.time;
  }

  int getDuration() {
    return this.duration;
  }

  String getImage() {
    return this.image;
  }

  int getRewards() {
    return this.rewards;
  }  

   setSubTaskID(String subTaskID) {
     this.subtask_id=subTaskID;
  }

   setName(String name) {
     this.name=name;
  }

   setTime(DateTime time) {
     this.time=time;
  }

   setDuration(int duration) {
    this.duration=duration;
  }

  setImage(String image) {
     this.image=image;
  }

   setRewards(int rewards) {
     this.rewards=rewards;
  }    
}
