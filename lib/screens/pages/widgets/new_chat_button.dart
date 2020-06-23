import 'package:flutter/material.dart';
import 'package:socially/utils/universal_variables.dart';

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // GestureDetector(
        // onTap: () async {
        // _auth.signOut();
        // FirebaseAuth.instance.signOut();
        // await AuthService().signOut();
        // },
        // child:
        Container(
      decoration: BoxDecoration(
          gradient: UniversalVariables.fabGradient,
          borderRadius: BorderRadius.circular(50)),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15),
      // ),
    );
  }
}
