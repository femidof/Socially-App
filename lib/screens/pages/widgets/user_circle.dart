import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socially/provider/user_provider.dart';
import 'package:socially/utils/universal_variables.dart';
import 'package:socially/utils/utilities.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: UniversalVariables.separatorColor,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              Utils.getInitials(userProvider.getUser.displayName),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: UniversalVariables.lightBlueColor,
                fontSize: 13,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: UniversalVariables.blackColor,
                  width: 2,
                ),
                color: UniversalVariables.onlineDotColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
