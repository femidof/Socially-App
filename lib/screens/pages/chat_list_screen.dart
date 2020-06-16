import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socially/components/firebase_methods.dart';
import 'package:socially/models/user.dart';
import 'package:socially/models/widgets/appbar.dart';
import 'package:socially/models/widgets/custom_tile.dart';
import 'package:socially/services/auth.dart';
import 'package:socially/utils/universal_variables.dart';
import 'package:socially/utils/utilities.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}
// FirebaseMetho

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseMethods methods = FirebaseMethods();
final AuthService _auths = AuthService();

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUserId;
  String initials;
  // User user;

  @override
  void initState() {
    super.initState();
    methods.getUserDetails().then((user) {
      setState(() {
        currentUserId = user.uid;
        initials = Utils.getInitials(user.displayName);
      });
    });
    // _auth.currentUser().then((user) {
    //   setState(() {
    //     if (currentUserId == user.uid) {}
    //     currentUserId = user.uid;
    //     initials = Utils.getInitials(user.displayName);
    //   });
    // });
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
          icon: Icon(
            // Icons.notifications,
            Icons.perm_phone_msg,
            color: Colors.white,
          ),
          onPressed: () {}),
      title: UserCircle(
        text:
            // "DOF",
            initials,
      ),
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
      body: ChatListContainer(
        currentUserId: currentUserId,
      ),
      //  FloatingActionButton(
      //   onPressed: () {},
      // ),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  ChatListContainer({this.currentUserId});

  final String currentUserId;

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(3, 9, 23, 1),
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return CustomTile(
            mini: false,
            onTap: () {},
            title: Text(
              "My GirlFriend",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Arial",
                fontSize: 19,
              ),
            ),
            subtitle: Text(
              "Hello",
              style: TextStyle(
                color: UniversalVariables.greyColor,
                fontSize: 14,
              ),
            ),
            leading: Container(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage("assets/images/SOCIALLY.jpg"),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UniversalVariables.onlineDotColor,
                        border: Border.all(
                          color: UniversalVariables.blackColor,
                          width: 2,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserCircle extends StatelessWidget {
  UserCircle({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: UniversalVariables.separatorColor,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: UniversalVariables.lightBlueColor,
                fontSize: 13,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: UniversalVariables.blackColor,
                  width: 2,
                ),
                color: UniversalVariables.onlineDotColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // _auth.signOut();
        // FirebaseAuth.instance.signOut();
        await AuthService().signOut();
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: UniversalVariables.fabGradient,
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 25,
        ),
        padding: EdgeInsets.all(15),
      ),
    );
  }
}
