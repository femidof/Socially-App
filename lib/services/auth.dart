import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socially/homepage.dart';
import 'package:socially/models/user.dart';
import 'package:socially/screens/pages/create_account.dart';
import 'package:socially/screens/pages/timeline.dart';
import 'package:socially/screens/pages/widgets/user_state.dart';
import 'package:socially/utils/utilities.dart';
import 'package:socially/welcome_screen.dart';
import 'package:socially/setup_page.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser;
  static final CollectionReference _userCollection =
      firestore.collection("users");

  //Handles Auth
  final usersRef = Firestore.instance.collection('users');
  // final usersRef = Firestore.instance.collection('user');

  handleAuth() {
    return StreamBuilder(
        stream: _auth.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data;

            return SetupPage(
              user: user,
            );

          } else {
            return GetStarted();
            // return MyHome();
          }
        });
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //SignIn
  signIn(AuthCredential authCreds, BuildContext context,
      String phoneNumber) async {
    _auth.signInWithCredential(authCreds);
    await _auth.signInWithCredential(authCreds);
    // await createUserInFirestore(context, phoneNumber);
    handleAuth();
    notifyListeners();

    // Navigator.pushReplacement(context,
    //     PageTransition(type: PageTransitionType.fade, child: MyHome()));
  }

  Future createUserInFirestore(BuildContext context, String phoneNumber) async {
    //check if user exists in users collection in  database according to their ID
    final FirebaseUser user = await _auth.currentUser();

    DocumentSnapshot doc = await usersRef.document(user.uid.toString()).get();
    final DateTime timestamp = DateTime.now();
    var userPr = Provider.of<User>(context);
// User get userPr => User.fromDocument(doc);
    if (!doc.exists) {
      print("Document Doesn't Exist");
      //if not exist go to create account page
      final String username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      //get username from create account

      await usersRef.document(user.uid).setData({
        "uid": user.uid,
        "username": username,
        "photoPhoto":
            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Amateur-made_Na'vi.jpg/1200px-Amateur-made_Na'vi.jpg",
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp,
        "state": "",
        "status": null,
        "phoneNumber": phoneNumber,
        "post": 0,
        "isAdmin": false
      });
      doc = await usersRef.document(user.uid).get();
    }
    currentUser = User.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);
    userPr = currentUser;
    return userPr;
    // Navigator.pop(context);
    // Navigator.pushReplacement(context,
    //     PageTransition(type: PageTransitionType.fade, child: MyHome()));
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

  void setUserState({@required String userId, @required UserState userState}) {
    int stateNum = Utils.stateToNum(userState);
    _userCollection.document(userId).updateData({"state": stateNum});
  }

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.document(uid).snapshots();
}
