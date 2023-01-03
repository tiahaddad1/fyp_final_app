class Reminder {
   String reminder_id;
   String name;


  Reminder(
      {required this.reminder_id, required this.name});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      reminder_id: json['reminder_id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() => {
        'reminder_id': reminder_id,
        'name': name,
      };

  String getReminderID() {
    return this.reminder_id;
  }

  String getName() {
    return this.name;
  }

   setReminderID(String reminder_id) {
     this.reminder_id=reminder_id;
  }

   setName(String name) {
     this.name=name;
  }
}
