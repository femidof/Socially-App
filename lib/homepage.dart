import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socially/main.dart';
import 'package:socially/screens/pages/activity_feed.dart';
import 'package:socially/screens/pages/chat_page.dart';
import 'package:socially/screens/pages/contact_logs.dart';
import 'package:socially/screens/pages/profile.dart';
import 'package:socially/screens/pages/search.dart';
import 'package:socially/screens/pages/timeline.dart';
import 'package:socially/screens/pages/upload.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String uid = '';
  PageController pageController;
  int pageIndex = 0;

  getUid() {}

  @override
  void initState() {
    pageController = PageController(
        // initialPage: 2,
        );
    this.uid = '';
    FirebaseAuth.instance.currentUser().then((val) {
      setState(() {
        this.uid = val.uid;
      });
    }).catchError((e) {
      print(e);
    });

    super.initState();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: SafeArea(
        child: PageView(
          children: <Widget>[
            ChatPage(),
            Timeline(),
            // ContactLogs(),
            // ActivityFeed(),
            // Search(),
            Upload(),
            Profile(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      
      bottomNavigationBar: CupertinoTabBar(
        border: Border(
            top: BorderSide(
          color: Colors.grey[700],
        )),
        backgroundColor: Theme.of(context).primaryColor,
        // Color(0xffA800CB),
        inactiveColor: Colors.grey[400],
        currentIndex: pageIndex,
        onTap: (int pageIndex) {
          pageController.jumpToPage(pageIndex);
        },
        activeColor:
            // Theme.of(context).primaryColor,
            Color(0xffA800CB),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart),
            // backgroundColor: Colors.redAccent,
            // activeIcon:
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications_active),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.filter_list),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),

      // appBar: new AppBar(
      //   title: new Text('Dashboard'),
      //   centerTitle: true,
      // ),
      // body: Center(
      //   child: Container(
      //     child: new Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         new Text('You are now logged in as ${uid}'),
      //         SizedBox(
      //           height: 15.0,
      //         ),
      //         new OutlineButton(
      //           borderSide: BorderSide(
      //               color: Colors.red, style: BorderStyle.solid, width: 3.0),
      //           child: Text('Logout'),
      //           onPressed: () {
      //             FirebaseAuth.instance.signOut().then((action) {
      //               Navigator.push(
      //                   context,
      //                   PageTransition(
      //                       type: PageTransitionType.fade, child: BaseStart()));
      //             }).catchError((e) {
      //               print(e);
      //             });
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }
}
