import 'package:flutter/material.dart';
import 'package:socially/models/call.dart';
import 'package:socially/screens/pages/callscreens/call_screen.dart';
import 'package:socially/screens/pages/chatscreens/widgets/cached_images.dart';
import 'package:socially/services/call_methods.dart';
import 'package:socially/utils/permissions.dart';

class PickupScreen extends StatelessWidget {
  final Call call;

  final CallMethods callMethods = CallMethods();

  PickupScreen({
    @required this.call,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CachedImage(
              call.callerPic,
              isRound: true,
              radius: 180,
              // width: 150,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              call?.callerName ?? "Unknown Caller",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  onPressed: () async {
                    await callMethods.endCall(call: call);
                  },
                  color: Colors.redAccent,
                ),
                SizedBox(width: 25),
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () async =>
                      await Permissions.cameraAndMicrophonePermissionsGranted()
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallScreen(call: call),
                              ),
                            )
                          : {},
                  color: Colors.green,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
