import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socially/shared/universal_variables.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    accentColor: Colors.red,
    brightness: Brightness.light,
    primaryColor: Colors.amber,
    // buttonColor: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.yellow,
      disabledColor: Colors.grey,
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: UniversalVariables.gradientColorEndhmm,
    backgroundColor: Colors.black,
    buttonColor: Colors.red,
    accentColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.purple[900],
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ),
  );
}

class Themees {
  RxBool _isLightTheme = false.obs;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }

  getThemeStatus() async {
    var _isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : true;
    }).obs;
    _isLightTheme.value = (await _isLight.value)!;
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }
}
