// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socially/homepage.dart';
// import 'package:socially/homepage.dart';
import 'package:socially/models/user.dart';
import 'package:socially/screens/authenticate/authenticate.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // String verificationId, phoneNumber, smsCode;
  // bool codeSent = false;
  //create user obj based on firebaseUser

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user
  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // // sign in with email and pass
  // Future signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     AuthResult result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Authenticate();
          } else {
            return MyHome();
          }
        });
  }

  // sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(AuthCredential authCreds) async {
    try {
      AuthResult result = await _auth.signInWithCredential(authCreds);
      await FirebaseAuth.instance.signInWithCredential(authCreds);
      FirebaseUser user = result.user;
      _userFromFirebaseUser(user);
      // return result;
    } catch (e) {
      print(e.toString());
      // return null;
    }
  }

  signInWithOTP(smsCode, verId) async {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    await signIn(authCreds);
  }
}
