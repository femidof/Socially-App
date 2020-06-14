import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/widgets/appbar.dart';
import 'package:socially/models/widgets/progress_bar.dart';
import 'package:socially/screens/pages/callscreens/pickup/pickup_layout.dart';

Firestore firestore = Firestore.instance;

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: header(context, "Socially"),
      body: ProgressBar.circularStylishProgress(),
    );
  }
}
