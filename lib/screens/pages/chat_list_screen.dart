import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:socially/components/firebase_methods.dart';
import 'package:socially/models/contact.dart';
// import 'package:socially/models/user.dart';
import 'package:socially/models/widgets/appbar.dart';
// import 'package:socially/models/widgets/custom_tile.dart';
import 'package:socially/models/widgets/progress_bar.dart';
import 'package:socially/provider/user_provider.dart';
import 'package:socially/screens/pages/widgets/contact_view.dart';
import 'package:socially/screens/pages/widgets/new_chat_button.dart';
import 'package:socially/screens/pages/widgets/quiet_box.dart';
import 'package:socially/screens/pages/widgets/user_circle.dart';
import 'package:socially/services/auth.dart';
// import 'package:socially/services/auth.dart';
// import 'package:socially/utils/universal_variables.dart';
// import 'package:socially/utils/utilities.dart';

class ChatListScreen extends StatelessWidget {
  final String initials;
  ChatListScreen({this.initials});

// final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMethods methods = FirebaseMethods();
// final AuthService _auths = AuthService();

  // String currentUserId;

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
          icon: Icon(
            // Icons.notifications,
            Icons.perm_phone_msg,
            color: Colors.white,
          ),
          onPressed: () {}),
      title: UserCircle(),
      centerTitle: true,
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(
        //     Icons.phone_in_talk,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        // ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/search_screen');
          },
        ),

        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {
            AuthService().signOut();
            // print("${user.uid}");
            // print("$currentUserId");
            // print("initials = $initials");
          },
        ),
      ],
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: customAppBar(context),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(),
    );
  }
}

class ChatListContainer extends StatelessWidget {
  final FirebaseMethods _chatMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      color: Color.fromRGBO(3, 9, 23, 1),
      child: StreamBuilder<QuerySnapshot>(
          stream: _chatMethods.fetchContacts(userId: userProvider.getUser.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docList = snapshot.data.documents;
              // print("testing and debuggin ${docList.toString()}");
              if (docList.isEmpty) {
                return QuietBox();
              }
              ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: docList.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromMap(docList[index].data);
                  return ContactView(
                    contact: contact,
                  );
                },
              );
            }
            // print("testing and debuggin ${userProvider.getUser.uid}");
            return ProgressBar.circularStylishProgress();
          }),
    );
  }
}
