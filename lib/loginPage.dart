import 'package:shimmer/shimmer.dart';
import 'package:socially/animations/fadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:socially/utils/universal_variables.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeAnimation(
              1.2,
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: UniversalVariables.greyColor,
                child: Text(
                  "Socially",
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontSize: 70,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FadeAnimation(
                1.5,
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[300]))),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.8)),
                              hintText: "Phone number"),
                        ),
                      ),
                      // Container(
                      //   decoration: BoxDecoration(),
                      //   child: TextField(
                      //     obscureText: true,
                      //     decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         hintStyle:
                      //             TextStyle(color: Colors.grey.withOpacity(.8)),
                      //         hintText: "Password"),
                      //   ),
                      // ),
                    ],
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            FadeAnimation(
                1.8,
                Center(
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue[800]),
                    child: Center(
                        child: Text(
                      "SignUp/Login",
                      style: TextStyle(color: Colors.white.withOpacity(.7)),
                    )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
