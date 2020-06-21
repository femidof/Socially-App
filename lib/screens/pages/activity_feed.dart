import 'package:flutter/material.dart';
import 'package:socially/models/widgets/appbar.dart';
import 'package:socially/models/widgets/progress_bar.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      appBar: header(context, "Activity"),
      body: ProgressBar.circularStylishProgress(),
    );
  }
}


class ActivityFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}
