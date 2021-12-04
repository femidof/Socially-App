import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/demo/users.dart';
import 'package:socially/screens/chat_list_screen.dart';
import 'package:socially/shared/theme.dart';
import 'package:socially/shared/universal_variables.dart';
import 'package:contacts_service/contacts_service.dart';

RxBool ISLIGHT = false.obs;

class HomeLaunchScreen extends StatefulWidget {
  HomeLaunchScreen({Key? key}) : super(key: key);

  @override
  _HomeLaunchScreenState createState() => _HomeLaunchScreenState();
}

class _HomeLaunchScreenState extends State<HomeLaunchScreen> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  List<Contact>? contacts;

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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => UsersPage());
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
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
      appBar: AppBar(
        elevation: 1,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        foregroundColor: UniversalVariables.lightBlueColor,
        title: GestureDetector(
          child: Shimmer.fromColors(
            child: Text(
              "Socially",
              style: GoogleFonts.pacifico(
                fontSize: 24,
              ),
            ),
            baseColor: UniversalVariables.gradientColorEnd,
            highlightColor: UniversalVariables.gradientColorStart,
          ),
          onTap: () {
            Get.to(() => TestPage());
          },
        ),
        centerTitle: true,
        actions: [
          ObxValue(
            (data) => Switch(
              activeColor: Colors.blue,
              value: ISLIGHT.value,
              onChanged: (val) {
                ISLIGHT.value = val;
                Get.changeThemeMode(
                  ISLIGHT.value ? ThemeMode.light : ThemeMode.dark,
                );
                Themees().saveThemeStatus();
              },
            ),
            // FlutterSwitch(
            //   width: 100.0,
            //   height: 55.0,
            //   toggleSize: 45.0,
            //   value: ISLIGHT.value,
            //   borderRadius: 30.0,
            //   padding: 2.0,
            //   activeToggleColor: Color(0xFF6E40C9),
            //   inactiveToggleColor: Color(0xFF2F363D),
            //   activeSwitchBorder: Border.all(
            //     color: Color(0xFF3C1E70),
            //     width: 6.0,
            //   ),
            //   inactiveSwitchBorder: Border.all(
            //     color: Color(0xFFD1D5DA),
            //     width: 6.0,
            //   ),
            //   activeColor: Color(0xFF271052),
            //   inactiveColor: Colors.white,
            //   activeIcon: Icon(
            //     Icons.nightlight_round,
            //     color: Color(0xFFF8E3A1),
            //   ),
            //   inactiveIcon: Icon(
            //     Icons.wb_sunny,
            //     color: Color(0xFFFFDF5D),
            //   ),
            //   onToggle: (val) {
            //     setState(() {
            //       ISLIGHT.value = val;

            //       if (val) {
            //         // _textColor = Colors.white;
            //         // _appBarColor = Color.fromRGBO(22, 27, 34, 1);
            //         // _scaffoldBgcolor = Color(0xFF0D1117);
            //       } else {
            //         // _textColor = Colors.black;
            //         // _appBarColor = Color.fromRGBO(36, 41, 46, 1);
            //         // _scaffoldBgcolor = Colors.white;
            //       }
            //     });
            //   },
            // ),

            false.obs,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "New Chat",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Divider(
            color: UniversalVariables.separatorColor,
            height: 0.5,
          ),
          ChatListScreen(),
        ],
      ),
    )
        //     ],
        //   ),
        // )
        ;
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
