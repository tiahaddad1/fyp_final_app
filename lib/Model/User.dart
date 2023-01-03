class User {
  late String user_id;
  String first_name;
  String last_name;
  String email;
  String password;
  String about_description;
  String profile_pic;

  User({
    required this.user_id,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password,
    required this.about_description,
    required this.profile_pic,
  }); //constructor

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      password: json['password'],
      about_description: json['about_description'],
      profile_pic: json['profile_pic'],
    );
  }

  String getFirstName() {
    return this.first_name;
  }

  String getLastName() {
    return this.last_name;
  }

  String getEmail() {
    return this.email;
  }

  String getPassword() {
    return this.password;
  }

  String getAboutDescription() {
    return this.about_description;
  }

  String getProfilePic() {
    return this.profile_pic;
  }

  String getUserID() {
    return this.user_id;
  }

  setFirstName(String first_name) {
    this.first_name = first_name;
  }

  setLastName(String last_name) {
    this.last_name = last_name;
  }

  setEmail(String email) {
    this.email = email;
  }

  setPassword(String password) {
    this.password = password;
  }

  setDescription(String description) {
    this.about_description = description;
  }

  setProfilePic(String profilePic) {
    this.profile_pic = profilePic;
  }

  setUserID(String userID) {
    this.user_id = userID;
  }
}
