import 'package:flutter/material.dart';
import 'package:socially/screens/pages/search_screen.dart';
import 'package:socially/utils/universal_variables.dart';

class QuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: UniversalVariables.separatorColor,
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 35,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "This is where all the contacts are listed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "This is where all the contacts are listed",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FlatButton(
                color: UniversalVariables.gradientColorEndhmm,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                ),
                child: Text("START SEARCHING"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
