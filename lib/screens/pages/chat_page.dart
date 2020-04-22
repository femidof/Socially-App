import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _ChatPageState extends State<ChatPage> {
  String currentUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.currentUser().then((user) {
      setState(() {
        currentUserId = user.uid;
      });
    });
  }

  // CustomAppBar customAppBar(BuildContext context) {}

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        // backgroundColor: Color.fromRGBO(50, 9, 23, 1),
        // backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
