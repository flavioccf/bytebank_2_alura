import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.green[900],
    accentColor: Colors.green[700],
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green[700],
      highlightColor: Colors.green[900],
      splashColor: Colors.green[800],
      textTheme: ButtonTextTheme.primary,
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green[900],
  );
}
