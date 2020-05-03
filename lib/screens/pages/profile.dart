import 'package:flutter/material.dart';
import 'package:socially/models/widgets/appbar.dart';
import 'package:socially/screens/pages/callscreens/pickup/pickup_layout.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      scaffold: Scaffold(
        appBar: header(context, "Profile"),
        body: Text("Profile"),
      ),
    );
  }
}
