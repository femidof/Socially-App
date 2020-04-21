import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/animations/fadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:socially/services/auth.dart';
import 'package:socially/utils/universal_variables.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  String phoneNumber, verificationId, smsCode;
  bool codeSent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Form(
        key: formKey,
        child: Container(
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
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                // prefix: ,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(.8)),
                                hintText: "Enter Your Phone number"),
                            onChanged: (value) {
                              setState(() {
                                this.phoneNumber = value;
                              });
                            },
                          ),
                        ),
                        codeSent
                            ? Container(
                                decoration: BoxDecoration(),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  onChanged: (value) {
                                    setState(() {
                                      this.smsCode = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(.8)),
                                      hintText: "OTP Code"),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              FadeAnimation(
                  1.8,
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          // codeSent = codeSent;
                          codeSent
                              ? authService.signInWithOTP(
                                  smsCode, verificationId)
                              : verifyWithPhoneNumber(phoneNumber);
                        });
                        print("hello");
                      },
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue[800]),
                        child: Center(
                          child: codeSent
                              ? Text(
                                  "Verify OTP",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.7)),
                                )
                              : Text(
                                  "Verify Phone",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.7)),
                                ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyWithPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      await authService.signIn(authResult);
    };
    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) async {
      print("${authException.message}");
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      // setState if in stateful widget
      this.codeSent = true;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    try {
      // AuthResult result =
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout,
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
