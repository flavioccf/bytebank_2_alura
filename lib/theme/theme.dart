import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    backgroundColor: Color(0xff7a297a),
    primaryColor: Color(0xff993399),
    accentColor: Color(0xff993399),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xff993399),
      highlightColor: Color(0xff993399),
      splashColor: Color(0xff993399),
      textTheme: ButtonTextTheme.primary,
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xff993399),
  );
}
