import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String uid;
  late String displayName;
  late String phoneNumber;
  late String email;
  late String username;
  late String status;
  late String bio;
  late int state;
  late String profilePhoto;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.phoneNumber,
    required this.email,
    required this.username,
    required this.status,
    required this.bio,
    required this.state,
    required this.profilePhoto,
  });

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['displayName'] = user.displayName;
    data['phoneNumber'] = user.phoneNumber;
    data['email'] = user.email;
    data['username'] = user.username;
    data["status"] = user.status;
    data["state"] = user.state;
    data["bio"] = user.bio;
    data["profilePhoto"] = user.profilePhoto;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
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

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['id'],
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
