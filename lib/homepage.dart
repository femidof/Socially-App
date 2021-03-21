import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socially/components/firebase_methods.dart';
import 'package:socially/main.dart';
import 'package:socially/provider/user_provider.dart';
import 'package:socially/screens/pages/activity_feed.dart';
import 'package:socially/screens/pages/callscreens/pickup/pickup_layout.dart';
import 'package:socially/screens/pages/chat_list_screen.dart';
import 'package:socially/screens/pages/chat_page.dart';
import 'package:socially/screens/pages/contact_logs.dart';
import 'package:socially/screens/pages/profile.dart';
import 'package:socially/screens/pages/search.dart';
import 'package:socially/screens/pages/timeline.dart';
import 'package:socially/screens/pages/upload.dart';
import 'package:socially/screens/pages/widgets/user_state.dart';
import 'package:socially/services/auth.dart';
import 'package:socially/utils/utilities.dart';

final FirebaseMethods methods = FirebaseMethods();

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with WidgetsBindingObserver {
  String uid = '';
  PageController pageController;
  int pageIndex = 0;
  UserProvider userProvider;
  String currentUserId;
  String initials;
  AuthService _authMethods = AuthService();

  getUid() {}

  @override
  void initState() {
    super.initState();

    methods.getUserDetails().then((user) {
      setState(() {
        currentUserId = user.uid;
        initials = Utils.getInitials(user.displayName);
        // print("${user.uid} : wow wow wow");
        // print("${userProvider.getUser.uid} : intereest wow wow");
      });
    });
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();

      _authMethods.setUserState(
        userId: userProvider.getUser?.uid,
        userState: UserState.Online,
      );
    });
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
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    String currentUserId =
        (userProvider != null && userProvider.getUser != null)
            ? userProvider.getUser.uid
            : "";
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId,
                userState: UserState.Online,
              )
            : print("resumed state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId,
                userState: UserState.Offline,
              )
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId,
                userState: UserState.Waiting,
              )
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? _authMethods.setUserState(
                userId: currentUserId,
                userState: UserState.Offline,
              )
            : print("detached state");
        break;
      default:
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
        // Colors.black,
        body: PageView(
          children: <Widget>[
            Container(
              child: ChatListScreen(
                initials: initials,
              ),
            ),
            Timeline(),
            // ContactLogs(),
            // Search(),
            // Upload(),
            ActivityFeed(),
            Profile(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
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
            // pageController.animateToPage(
            //   pageIndex,
            //   duration: Duration(milliseconds: 1000),
            //   curve: Curves.easeInOut,
            // );
          },
          activeColor:
              // Theme.of(context).primaryColor,
              Color(0xffA800CB),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart),
              // backgroundColor: Colors.redAccent,
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
      ),
    );
  }
}
