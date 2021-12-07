import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/demo/users.dart';
import 'package:socially/screens/chat_list_screen.dart';
import 'package:socially/screens/explore/explore.dart';
import 'package:socially/screens/notification/notification.dart';
import 'package:socially/shared/theme.dart';
import 'package:socially/shared/universal_variables.dart';
import 'package:contacts_service/contacts_service.dart';

class HomeLaunchScreen extends StatefulWidget {
  HomeLaunchScreen({Key? key}) : super(key: key);

  @override
  _HomeLaunchScreenState createState() => _HomeLaunchScreenState();
}

class _HomeLaunchScreenState extends State<HomeLaunchScreen> {
  User? _user;
  int _currentIndex = 0;
  final List _pageChildren = [
    ChatScreenChild(),
    ExploreScreenChild(),
    ChatScreenChild(),
    NotificationChildScreen(),
    ProfileChildScreen(
        // user: _user,
        ),
  ];
  List<Contact>? contacts;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<List<Contact>?> getLocalContacts() async {
    contacts = await ContactsService.getContacts();
    print("Contact wahala::: $contacts");
    return contacts;
  }

  // Future
  uploadContacts() async {}

  // Contacts from Firebase
  getAppUserContact() async {}

  @override
  void initState() {
    // TODO: implement initState
    _user = FirebaseChatCore.instance.firebaseUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        // border: Border(
        //     top: BorderSide(color: context.theme.scaffoldBackgroundColor)),
        backgroundColor: context.theme.scaffoldBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart),
            backgroundColor: Colors.redAccent,
            activeIcon: Icon(
              Icons.bubble_chart,
              color: Colors.blueAccent,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_sharp),
            backgroundColor: Colors.purple,
            activeIcon: Icon(
              Icons.explore_sharp,
              color: Colors.purple,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            activeIcon: Icon(
              Icons.whatshot,
              color: Colors.redAccent,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            activeIcon: Icon(
              Icons.notifications,
              color: Colors.greenAccent,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              color: Colors.amberAccent,
            ),
          ),
        ],
      ),
      body: _pageChildren[_currentIndex],
    );
  }
}

class ProfileChildScreen extends StatelessWidget {
  const ProfileChildScreen({Key? key}) : super(key: key);
  // final User? user;

  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseChatCore.instance.firebaseUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.pacifico(
              fontSize: 20, color: context.textTheme.bodyText1!.color),
        ),
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            _auth.signOut();
          },
          child: Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
