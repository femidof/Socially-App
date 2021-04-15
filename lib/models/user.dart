import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String displayName;
  String phoneNumber;
  String email;
  String username;
  String status;
  String bio;
  int state;
  String profilePhoto;

  User({
    this.uid,
    this.displayName,
    this.phoneNumber,
    this.email,
    this.username,
    this.status,
    this.bio,
    this.state,
    this.profilePhoto,
  });

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['uid'] = user?.uid;
    data['displayName'] = user?.displayName;
    data['phoneNumber'] = user?.phoneNumber;
    data['email'] = user?.email;
    data['username'] = user?.username;
    data["status"] = user?.status;
    data["state"] = user?.state;
    data["bio"] = user?.bio;
    data["profilePhoto"] = user?.profilePhoto;
    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.displayName = mapData['displayName'];
    this.phoneNumber = mapData['phoneNumber'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.status = mapData['status'];
    this.state = mapData['state'];
    this.bio = mapData['bio'];
    this.profilePhoto = mapData['profilePhoto'];
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      uid: doc['uid'],
      email: doc['email'],
      displayName: doc['displayName'],
      phoneNumber: doc['phoneNumber'],
      username: doc['username'],
      status: doc['status'],
      state: doc['state'],
      bio: doc['bio'],
      profilePhoto: doc['profilePhoto'],
    );
  }

  
}
