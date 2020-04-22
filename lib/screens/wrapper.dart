import 'package:flutter/material.dart';
import 'package:socially/homepage.dart';
import 'package:socially/models/user.dart';
import 'package:provider/provider.dart';
import 'package:socially/services/auth.dart';
// import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return Home or Authenticate
    if (user == null) {
      return AuthService().handleAuth();
    } else {
      return MyHome();
    }
    // return Authenticate();
  }
}
