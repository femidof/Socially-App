import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressBar {
  static circularProgress() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.purple[600]),
      ),
    );
  }

  static linearProgress() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.purple[600]),
      ),
    );
  }

  static circularStylishProgress() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10.0),
      child: SpinKitDoubleBounce(
        color: Colors.purple[600],
      ),
    );
  }
}
