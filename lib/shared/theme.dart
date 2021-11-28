import 'package:flutter/material.dart';
import 'package:socially/shared/universal_variables.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    accentColor: Colors.red,
    brightness: Brightness.light,
    primaryColor: Colors.amber,
    // buttonColor: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      disabledColor: Colors.grey,
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: UniversalVariables.gradientColorEndhmm,
    backgroundColor: Colors.black,
    buttonColor: Colors.red,
    accentColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.amber,
      disabledColor: Colors.grey,
    ),
  );
}
