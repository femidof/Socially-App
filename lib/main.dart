import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:socially/loginPage.dart';
import 'package:socially/Animations/fadeAnimation.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(BaseStart());

class BaseStart extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        home: Wrapper(),
      ),
    );
  }
}
