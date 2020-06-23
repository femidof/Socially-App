// import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:socially/models/contact.dart';
import 'package:socially/models/message.dart';
import 'package:socially/models/user.dart';
import 'package:socially/provider/image_upload_provider.dart';
import 'package:socially/shared/constants/strings.dart';

class FirebaseMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  static final Firestore firestore = Firestore.instance;
  static final CollectionReference _userCollection =
      firestore.collection("users");
  final CollectionReference _messageCollection =
      firestore.collection('messages');
  // firestore.collection("user"); for production
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

    // final CollectionReference _userCollection = firestore.collection('users');

    await _messageCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToContact(senderId: message.senderId, receiverId: message.senderId);

    return await _messageCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  DocumentReference getContactsDocument({String of, String forContact}) =>
      _userCollection
          .document(of)
          .collection(CONTACTS_COLLECTION)
          .document(forContact);
  addToContact({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSendersContact(senderId, receiverId, currentTime);
    await addToReceiversContact(senderId, receiverId, currentTime);
  }

  Future<void> addToSendersContact(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot senderSnapshot = await getContactsDocument(
      of: senderId,
      forContact: receiverId,
    ).get();
    if (!senderSnapshot.exists) {
      //doesnt exit
      Contact receiverContact = Contact(
        uid: receiverId,
        addedOn: currentTime,
      );
      var receiverMap = receiverContact.toMap(receiverContact);

      await getContactsDocument(
        of: senderId,
        forContact: receiverId,
      ).setData(receiverMap);
    }
  }

  Future<void> addToReceiversContact(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot = await getContactsDocument(
      of: receiverId,
      forContact: senderId,
    ).get();
    if (!receiverSnapshot.exists) {
      //doesnt exit
      Contact senderContact = Contact(
        uid: senderId,
        addedOn: currentTime,
      );
      var senderMap = senderContact.toMap(senderContact);

      await getContactsDocument(of: receiverId, forContact: senderId)
          .setData(senderMap);
    }
  }

  Stream<QuerySnapshot> fetchContacts({String userId}) => _userCollection
      .document(userId)
      .collection(CONTACTS_COLLECTION)
      .snapshots();

  Stream<QuerySnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      _messageCollection
          .document(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();

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
    await _messageCollection
        .document(_message.senderId)
        .collection(_message.receiverId)
        .add(map);

    await _messageCollection
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

  Future<User> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _userCollection.document(id).get();
      return User.fromMap(documentSnapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // syncData() async {
  //   var user = await auth.currentUser();
  //   firestore.collection("user").document(user.uid);
  //   auth.
  // }
}
