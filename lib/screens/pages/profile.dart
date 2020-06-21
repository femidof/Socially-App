import 'package:flutter/material.dart';
import 'package:socially/models/widgets/appbar.dart';
import 'package:socially/models/widgets/progress_bar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: header(context, "Profile"),
      body: ProgressBar.circularStylishProgress(),
    );
  }
}
