import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socially/homepage.dart';
import 'package:socially/welcome_screen.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MyHome();
          } else {
            // return GetStarted();
            return MyHome();
          }
        });
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds, context) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
    Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: MyHome()));
  }

  signInWithOTP(smsCode, verId, context) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds, context);
    Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: MyHome()));
  }
}
