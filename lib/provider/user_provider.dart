import 'package:flutter/material.dart';
import 'package:socially/components/firebase_methods.dart';
import 'package:socially/models/user.dart';

class UserProvider with ChangeNotifier {
  User _user;
  FirebaseMethods _firebaseRepository = FirebaseMethods();

  User get getUser => _user;

  void refreshUser() async {
    User user = await _firebaseRepository.getUserDetails();
    _user = user;
    notifyListeners();
  }

}