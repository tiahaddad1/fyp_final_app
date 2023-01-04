import 'package:flutter/material.dart';

import '../api/firebase_api.dart';
import '/Model/Caregiver.dart';

class CaregiverProvider extends ChangeNotifier {
  late List<Caregiver> caregivers = [];

  static void addCaregiver(Caregiver caregiver) =>
      FirebaseApi.createCaregiver(caregiver);

  void setCaregivers(List<Caregiver> _caregivers) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        caregivers = _caregivers;
        notifyListeners();
      });

  void removeCaregiver(Caregiver caregiver) {
    caregivers.remove(caregiver);
    notifyListeners();
  }
}
