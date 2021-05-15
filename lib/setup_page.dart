import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/homepage.dart';
import 'package:socially/services/media_service.dart';
import 'package:socially/services/cloud_storage_service.dart';
import 'package:socially/utils/universal_variables.dart';

class SetupPage extends StatefulWidget {
  final FirebaseUser user;

  SetupPage({this.user});
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  double _deviceHeight;

  double _deviceWidth;

  GlobalKey<FormState> _formKey;
  // final storage = new FlutterSecureStorage();
  File _image;

  String _name;
  String _username;
  String _email;
  String _bio;
  final usersRef = Firestore.instance.collection('users');

  _SetupPageState() {
    _formKey = GlobalKey<FormState>();
  }
  @override
  void initState() {
    super.initState();
    // setStorage();
    _formKey = GlobalKey<FormState>();
  }

  // setStorage() async {
  //   await storage.write(key: "currentUser", value: widget.user.uid);
  // }

  Widget _headingWidget() {
    return Container(
      // height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: UniversalVariables.greyColor,
              child: Text(
                "Socially",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Pacifico",
                  fontSize: 50,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "We're glad you're here!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          Text(
            "Please enter in your details.",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(
        color: Colors.white,
      ),
      validator: (_input) {
        return _input.length != 0 ? null : "Please enter a name";
      },
      onChanged: (_input) {
        setState(() {
          _name = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Display Name",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(
        color: Colors.white,
      ),
      validator: (_input) {
        return _input.length != 0 ? null : "Please enter a name";
      },
      onChanged: (_input) {
        setState(() {
          _username = _input.trim();
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 5, left: 20),
        prefixIcon: FaIcon(FontAwesomeIcons.at),
        prefixIconConstraints: BoxConstraints(maxWidth: 25, minHeight: 25),
        hintText: "Username",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _bioTextField() {
    return TextFormField(
      maxLines: null,
      autocorrect: false,
      style: TextStyle(
        color: Colors.white,
      ),
      validator: (_input) {
        return _input.length != 0 ? null : "Tell us something about yourself";
      },
      onChanged: (_input) {
        setState(() {
          _bio = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Bio:   Available",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _imageSelectorWidget() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          File _imageFile = await MediaService.instance.getImageFromLibrary();

          setState(() {
            _image = _imageFile;
            _image = _imageFile;
          });
        },
        child: Container(
          height: _deviceHeight * 0.10,
          width: _deviceHeight * 0.10,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(200),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _image != null
                  ? FileImage(_image)
                  : NetworkImage(
                      "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputForm() {
    return Form(
      key: _formKey,
      onChanged: () {
        _formKey?.currentState?.save();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _imageSelectorWidget(),
          SizedBox(
            height: 10,
          ),
          _nameTextField(),
          _emailTextField(),
          _usernameTextField(),
          _bioTextField(),
          _confirmButton(),
        ],
      ),
    );
  }

  Widget _confirmButton() {
    return Container(
      child: Center(
        child: MaterialButton(
          onPressed: () async {
            // if (_formKey.currentState.validate() && _image != null) {
            var _result = await CloudStorageService.instance
                .uploadUserImage(widget.user.uid, _image);
            var _imageURL = await _result.ref.getDownloadURL();

            await usersRef.document(widget.user.uid).setData({
              "uid": widget.user.uid,
              "username": _username,
              "profilePhoto": _imageURL.toString(),
              "email": _email,
              "displayName": _name,
              "bio": _bio,
              "timestamp": DateTime.now(),
              "state": 1,
              "status": null,
              "phoneNumber": widget.user?.phoneNumber ?? "",
              "post": 0,
              "isAdmin": false
            });

            UserUpdateInfo userUpdateInfo = UserUpdateInfo();
            userUpdateInfo.photoUrl = _imageURL.toString();
            userUpdateInfo.displayName = _name;
            widget.user.updateProfile(userUpdateInfo);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHome(),
                ),
                (route) => false);
            // }
          },
          child: Text(
            "DONE",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(
        color: Colors.white,
      ),
      validator: (_input) {
        return _input.length != 0 && _input.contains('@')
            ? null
            : "Please enter a valid email";
      },
      onChanged: (_input) {
        setState(() {
          _email = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Email",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: UniversalVariables.gradientColorEndhmm,
      body: Container(
        height: _deviceHeight * 0.75,
        //used 0.06 instead of 0.10
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.06),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headingWidget(),
              _inputForm(),
              // _registerButton(),
              // _backToLoginPageButton(),
            ],
          ),
        ),
      ),
    );
  }
}
