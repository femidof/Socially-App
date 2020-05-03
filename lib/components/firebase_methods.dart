import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:socially/models/message.dart';
import 'package:socially/models/user.dart';
import 'package:socially/provider/image_upload_provider.dart';

class FirebaseMethods {
  static final Firestore firestore = Firestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection("user");
  //user class
  User user = User();
  StorageReference _storageReference;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

  Future<void> addMessageToDb(
      Message message, User sender, User receiver) async {
    var map = message.toMap();

    await firestore
        .collection("messages")
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    return await firestore
        .collection("messages")
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Future<List<User>> fetchAllUsers(FirebaseUser currentUser) async {
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot =
        await firestore.collection("users").getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }

  void uploadImage(
          {@required File image,
          @required String receiverId,
          @required String senderId,
          @required ImageUploadProvider imageUploadProvider}) =>
      uploadImages(image, receiverId, senderId, imageUploadProvider);

  void uploadImages(File image, String receiverId, String senderId,
      ImageUploadProvider imageUploadProvider) async {
    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // get url from image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    imageUploadProvider.setToIdle();

    // send image
    setImageMsg(url, receiverId, senderId);
  }

  Future<String> uploadImageToStorage(File image) async {
    try {
      _storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');

      StorageUploadTask _storageUploadTask = _storageReference.putFile(image);
      var url =
          await (await _storageUploadTask.onComplete).ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message _message;

    _message = Message.imageMessage(
      message: "IMAGE",
      receiverId: receiverId,
      senderId: senderId,
      photoUrl: url,
      timestamp: Timestamp.now(),
      type: 'image',
    );
    var map = _message.toImageMap();

    //set to db
    await firestore
        .collection("messages")
        .document(_message.senderId)
        .collection(_message.receiverId)
        .add(map);

    await firestore
        .collection("messages")
        .document(_message.receiverId)
        .collection(_message.senderId)
        .add(map);
  }

  Future<User> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();
    DocumentSnapshot documentSnapshot =
        await _userCollection.document(currentUser.uid).get();
    return User.fromMap(documentSnapshot.data);
  }
}
