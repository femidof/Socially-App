import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socially/models/widgets/appbar.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  String username;
  // String diplayName;
  final _formKey = GlobalKey<FormState>();

  submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      _formKey.currentState.save();
      SnackBar snackbar = SnackBar(
        content: Text("Welcome $username"),
      );
      _scaffoldkey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: header(context, "Set up your profile"),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Text(
                      "Create a username",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                        key: _formKey,
                        child: TextFormField(
                          autovalidate: true,
                          validator: (value) {
                            if (value.trim().length < 4 || value.isEmpty) {
                              return "Username too short";
                            } else if (value.trim().length > 12) {
                              return "Username too long";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => username = val,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username",
                            labelStyle:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                            hintText: "Must be at least 4 characters",
                          ),
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    width: 85,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.purple[600],
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Center(
                      child: Text("Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
