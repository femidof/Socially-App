import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:socially/shared/universal_variables.dart';

import 'otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String? lastname;
  String? firstname;
  XFile? imageXFile;
  String? imagePath;
  bool uploadedImage = false;
  String? phone;
  bool codeSent = false;
  TextEditingController _controller = TextEditingController();
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isDismissible: false,
                    elevation: 0,
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: ListTile(
                              subtitle: Text("Take Picture"),
                              contentPadding:
                                  EdgeInsets.only(bottom: 7.0, left: 25),
                              onTap: () async {
                                await _picker.pickImage(
                                    source: ImageSource.camera);
                              },
                              leading: Icon(Icons.camera),
                              title: Text("Camera"),
                            ),
                          ),
                          ListTile(
                            subtitle: Text("Pick Picture from Library"),
                            contentPadding:
                                EdgeInsets.only(bottom: 7.0, left: 25),
                            onTap: () async {
                              imageXFile = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              Get.back();
                              if (imageXFile != null) {
                                uploadedImage = true;
                              }

                              imagePath = imageXFile!.path;
                              print("Image: $imagePath");
                              setState(() {});
                            },
                            leading: Icon(Icons.photo),
                            title: Text("Photo Gallery"),
                          ),
                          ListTile(
                            subtitle: Text("Close"),
                            contentPadding:
                                EdgeInsets.only(bottom: 16.0, left: 25),
                            onTap: () {
                              Get.back();
                            },
                            leading: Icon(Icons.cancel),
                            title: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  foregroundImage: uploadedImage
                      ? FileImage(File(imagePath!))
                      : AssetImage("assets/images/user.png") as ImageProvider,
                  radius: 50,
                ),
              ),
              // Image.file(),
              // firstName
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    firstname = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Firstname";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Firstname",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // lastname
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    lastname = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Lastname";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Lastname",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, right: 20, left: 10),
                // margin: const EdgeInsets.only(top: 40, right: 20, left: 10),
                child: IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 30,
                top: 20,
                left: 20,
                right: 20,
              ),
              width: double.infinity,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                color: UniversalVariables.gradientColorStarthmm,
                onPressed: () {
                  Map<String, String> map = {
                    "firstname": firstname!,
                    "lastname": lastname!,
                    "phone": phone!,
                    "imageUrl": imagePath!,
                  };
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(map)));
                  }
                },
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
