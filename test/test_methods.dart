import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:fyp_application/Model/Learner.dart';
import 'package:fyp_application/Model/Task.dart';
import 'package:fyp_application/api/firebase_api.dart';
import 'package:test/test.dart';

checkEmailRegex(value) {
  if (value != "" ||
      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}

checkPasswordRegex(value) {
  if (value != "" ||
      value.length < 7 ||
      !RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}

Future main() async {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  test(
      'updateDescription() checks whether the user description detail is updated in the database',
      () async {
    expect(
        await Future.value(FirebaseApi.updateDescription(
            'A certified ABA therapist for young ASD learners')),
        equals('A certified ABA therapist for young ASD learners'));
  });

  test(
      'getAllLearners() checks whether all the learners are retrieved from the db',
      () async {
    expect(
        await Future.value(FirebaseApi.getAllLearners()),
        equals(new Learner(
            user_id: "JzEyiITsGIuF4YM46TTx",
            first_name: "anything",
            last_name: "Anything11",
            email: "anything1@fmail.com",
            password: "",
            about_description: "ksmmckmsdlmsdmdsskcmkdsmdk",
            profile_pic:
                "https://firebasestorage.googleapis.com/v0/b/fypapplication-550a3.appspot.com/o/profilephoto%2Fanything1%40fmail.com?alt=media&token=9d1a3db7-df74-4a0c-b66b-bde6a11db49c",
            birth_date: "1/7/2023",
            caregiver_assigned: "haddad_tia@hotmail.com")));
  });

  test(
      'deleteCaregiver() checks whether the logged in caregiver user is deleted from the db',
      () async {
    expect(
        await Future.value(FirebaseApi.deleteCaregiver("bW0thzWoWNI7WCqeQe40")),
        equals(true));
  });

  test(
      'addTaskAndSubtasks() checks whether the task and/or subtasks were successfully added in the database',
      () async {
    expect(
        await Future.value(FirebaseApi.addTaskAndSubtasks(
            new Task(
                task_id: "",
                name: "Cook",
                description: "Bake brownies",
                date: "21/02/2023",
                start_time: "12:00",
                rewards: 0,
                end_time: "14:00",
                reminder: 0,
                video:
                    "https://firebasestorage.googleapis.com/v0/b/fypapplication-550a3.appspot.com/o/profilephoto%2Fanything1%40fmail.com?alt=media&token=9d1a3db7-df74-4a0c-b66b-bde6a11db49c",
                subtasks: []),
            [],
            "JzEyiITsGIuF4YM46TTx")),
        equals(
            "")); //not knowing the newly created task's id but would generate a fail test case
  });

  test(
      'checkEmailRegex() checks the email entered meets the requirements of matching a word character, hyphen, period, any word or charac, domain extension: .com/.org ',
      () {
    expect(checkEmailRegex("hadd_tia"), equals(false));
  });

  test(
      'checkPasswordRegex() checks the password entered meets the requirements of matching more than 7 characters, one digit, one lower case letter, one upper case letter, and one non-alpha char. ',
      () {
    expect(checkPasswordRegex("12345"), equals(false));
  });
}
