class Feeling {
   String feeling_id;
   String name;


  Feeling(
      {required this.feeling_id, required this.name});

  factory Feeling.fromJson(Map<String, dynamic> json) {
    return Feeling(
      feeling_id: json['feeling_id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() => {
        'feeling_id': feeling_id,
        'name': name,
      };

  String getFeelingID() {
    return this.feeling_id;
  }

  String getName() {
    return this.name;
  }

   setFeelingID(String feeling_id) {
     this.feeling_id=feeling_id;
  }

   setName(String name) {
     this.name=name;
  }
}
