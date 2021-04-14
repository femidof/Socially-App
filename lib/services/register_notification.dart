// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// void registerNotification() {
//   FirebaseMessaging firebaseMessaging;
//   firebaseMessaging.requestNotificationPermissions();

//   firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
//     print('onMessage: $message');
//     Platform.isAndroid
//         ? showNotification(message['notification'])
//         : showNotification(message['aps']['alert']);
//     return;
//   }, onResume: (Map<String, dynamic> message) {
//     print('onResume: $message');
//     return;
//   }, onLaunch: (Map<String, dynamic> message) {
//     print('onLaunch: $message');
//     return;
//   });

//   firebaseMessaging.getToken().then((token) {
//     print('token: $token');
//     Firestore.instance
//         .collection('users')
//         .document(currentUserId)
//         .updateData({'pushToken': token});
//   }).catchError((err) {
//     Fluttertoast.showToast(msg: err.message.toString());
//   });
// }

//   void showNotification(message) async {
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//       Platform.isAndroid ? 'com.dfa.flutterchatdemo' : 'com.duytq.flutterchatdemo',
//       'Flutter chat demo',
//       'your channel description',
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.Max,
//       priority: Priority.High,
//     );
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platformChannelSpecifics =
//         new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

//     print(message);
// //    print(message['body'].toString());
// //    print(json.encode(message));

//     await flutterLocalNotificationsPlugin.show(
//         0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
//         payload: json.encode(message));
