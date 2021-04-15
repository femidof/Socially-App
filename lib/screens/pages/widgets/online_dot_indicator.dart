import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socially/models/user.dart';
import 'package:socially/screens/pages/widgets/user_state.dart';
import 'package:socially/services/auth.dart';
import 'package:socially/utils/utilities.dart';

class OnlineDotIndicator extends StatelessWidget {
  final String uid;
  final AuthService _authService = AuthService();

  OnlineDotIndicator({
    @required this.uid,
  });
  @override
  Widget build(BuildContext context) {
    getColor(int state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        case UserState.Waiting:
          return Colors.black26;

        default:
          return Colors.orange;
      }
    }

    return Align(
        alignment: Alignment.bottomRight,
        child: StreamBuilder<DocumentSnapshot>(
          stream: _authService.getUserStream(
            uid: uid,
          ),
          builder: (context, snapshot) {
            User user;

            if (snapshot.hasData && snapshot.data.data != null) {
              user = User.fromMap(snapshot.data.data);
            }
            return Container(
              height: 10,
              width: 10,
              margin: EdgeInsets.only(
                right: 8,
                top: 8,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(user?.state),
              ),
            );
          },
        ));
  }
}
