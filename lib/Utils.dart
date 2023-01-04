import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utils {
  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List>.fromHandlers(
        handleData:
            (QuerySnapshot<Map<String, dynamic>> data, EventSink<List> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();
          sink.add(objects);
        },
      );
  
  static toDateTime(Timestamp value) {
    if (value == null) return null;
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;
    return date.toUtc();
  }

    static dynamic fromstringToutc(String string) {
    if (string == null) return null;
    return DateTime(int.parse(string)).toUtc();
  }  
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

   showSnackBar(String? text) {
    if (text == null) {
      return;
    }

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.white,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
