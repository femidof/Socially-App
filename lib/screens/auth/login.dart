import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? phone;
  bool codeSent = false;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: const Center(
                child: Text(
                  'Phone Authentication',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40, right: 20, left: 10),
              margin: const EdgeInsets.only(top: 40, right: 20, left: 10),
              child: IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'US',
                onChanged: (phoneNumber) {
                  setState(() {
                    phone = phoneNumber.completeNumber;
                  });
                },
              ),
            ),
          ]),
          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OTPScreen(phone!)));
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          )
        ],
      ),
    );
  }
}
