import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socially/homepage.dart';
import 'package:socially/models/user.dart';
import 'package:socially/screens/pages/create_account.dart';
import 'package:socially/welcome_screen.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser;
//  Firestore firestore =
  //Handles Auth
  final usersRef = Firestore.instance.collection('user');
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MyHome();
          } else {
            return GetStarted();
            // return MyHome();
          }
        });
  }

  //Sign out
  signOut() {
    // _auth.signOut();
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds, BuildContext context,
      String phoneNumber) async {
    FirebaseAuth.instance.signInWithCredential(authCreds);
    await _auth.signInWithCredential(authCreds);
    await createUserInFirestore(context, phoneNumber);
    Navigator.pushReplacement(context,
        PageTransition(type: PageTransitionType.fade, child: MyHome()));
  }

  Future<void> createUserInFirestore(
      BuildContext context, String phoneNumber) async {
    //check if user exists in users collection in  database according to their ID
    final FirebaseUser user = await _auth.currentUser();
    DocumentSnapshot doc = await usersRef.document(user.uid.toString()).get();
    final DateTime timestamp = DateTime.now();

    if (!doc.exists) {
      print("Document Doesnt Exist");
      //if not exist go to create account page
      final String username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      //get username from create account

      await usersRef.document(user.uid).setData({
        "id": user.uid,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp,
        "state": "",
        "status": "",
        "phoneNumber": phoneNumber,
      });
      doc = await usersRef.document(user.uid).get();
    }
    currentUser = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);

    Navigator.pushReplacement(context,
        PageTransition(type: PageTransitionType.fade, child: MyHome()));
  }

  signInWithOTP(
      smsCode, verId, BuildContext context, String phoneNumber) async {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    await signIn(authCreds, context, phoneNumber);
    // createUserInFirestore(context);
    // Navigator.pushReplacement(context,
    //     PageTransition(type: PageTransitionType.fade, child: MyHome()));
  }
}
