import 'package:flutter/material.dart';
import 'package:socially/screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context, listen: true);

    //return Home or Authenticate
    // if (user == null) {
    // return
    // AuthService().handleAuth();
    // } else {
    return HomeScreen();
    // }
    // return Authenticate();
  }
}
