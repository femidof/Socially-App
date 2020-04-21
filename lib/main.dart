import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socially/models/user.dart';
import 'package:socially/screens/wrapper.dart';
import 'package:socially/services/auth.dart';

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
