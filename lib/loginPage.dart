import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/animations/fadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:socially/homepage.dart';
import 'package:socially/models/user.dart';
import 'package:socially/provider/user_provider.dart';
import 'package:socially/services/auth.dart';
import 'package:socially/utils/universal_variables.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // AuthService authService = AuthService();
  bool codeSent = false;
  // bool codeSent = false;
  final formKey = new GlobalKey<FormState>();
  String phonePrefix;
  String phoneNumber, verificationId, smsCode;
  //  String phoneNumber, verificationId, smsCode;
  User userP;

//  final FirebaseAuth _auth = FirebaseAuth.instance;
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('1');
  // User get userP => User.fromDocument(doc);

  @override
  void initState() {
    // TODO: implement initState


    final userP = Provider.of<User>(context);
    if (userP != null) {
      print("so it is here???");
      Navigator.pushReplacement(context,
          PageTransition(type: PageTransitionType.fade, child: MyHome()));
    }

    super.initState();
  }

  Future verifyPhone(phoneNumber) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      userP = AuthService().signIn(authResult, context, phoneNumber);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
    return userP;
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text(
            "+${country.phoneCode}",
            style: TextStyle(
              color: Colors.purple[200],
            ),
          ),
          SizedBox(width: 8.0),
          Flexible(
              child: Text(
            country.name,
            style: TextStyle(
              color: Colors.purple[300],
            ),
          ))
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Color.fromRGBO(3, 9, 23, 1),
            searchInputDecoration: InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: Text(
              'Select your phone code',
              style: TextStyle(color: Colors.black),
            ),
            onValuePicked: (Country country) => setState(() {
              _selectedDialogCountry = country;
              phonePrefix = country.phoneCode;
            }),
            itemBuilder: _buildDialogItem,
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('TR'),
              CountryPickerUtils.getCountryByIsoCode('US'),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // var user = Provider.of<StreamProvider>(context);
    final userP = Provider.of<User>(context, listen: true);
    if (userP != null) {
      print("so it is here???12333333");
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 80),
        child: Form(
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
                          ListTile(
                            onTap: () {
                              phonePrefix = '';
                              _openCountryPickerDialog();
                              setState(() {
                                phonePrefix = "+" + phonePrefix;
                              });
                            },
                            title: _buildDialogItem(_selectedDialogCountry),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(

                                  // prefix: ListTile(
                                  //   onTap: _openCountryPickerDialog,
                                  //   title:
                                  //       _buildDialogItem(_selectedDialogCountry),
                                  // ),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Enter Yours Phone number"),
                              onChanged: (value) {
                                setState(() {
                                  this.phoneNumber = value;
                                });
                              },
                            ),
                          ),
                          codeSent
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[300]))),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Colors.purple[400],
                                    ),
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
                          final mainPhoneNumber =
                              "+" + phonePrefix + phoneNumber;
                          setState(() {
                            print(mainPhoneNumber);
                            // codeSent = codeSent;
                            userP = codeSent
                                ? AuthService().signInWithOTP(smsCode,
                                    verificationId, context, mainPhoneNumber)
                                : verifyPhone(mainPhoneNumber);
                            // notifyListeners();
                            print("Works here");
                            if (userP == null) {
                              print("Error In System Process");
                              // return null;
                            } else {
                              print("${userP.toString()} that is it");
                              print("omgggggg?");
                              print("so it is here???");
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => MyHome(),
                              //     ));
                              // return MyHome();
                              //

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: AuthService().handleAuth()),
                                  (route) => false);
                            }
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
      ),
    );
  }
}
