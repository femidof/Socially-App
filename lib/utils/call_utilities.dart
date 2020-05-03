import 'dart:math';

import 'package:flutter/material.dart';
import 'package:socially/models/call.dart';
import 'package:socially/models/user.dart';
import 'package:socially/screens/pages/callscreens/call_screen.dart';
import 'package:socially/services/call_methods.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({
    User from,
    User to,
    context,
  }) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.displayName,
      callerPic: from.profilePhoto,
      receiverId: to.uid,
      receiverName: to.displayName,
      receiverPic: to.profilePhoto,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call);
    call.hasDialled = true;
    if (callMade) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            call: call,
          ),
        ),
      );
    }
  }
}
