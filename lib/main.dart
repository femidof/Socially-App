import 'package:flutter/material.dart';
import 'package:socially/services/auth.dart';

void main() => runApp(BaseStart());

class BaseStart extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: AuthService().handleAuth(),
    );
  }
}
