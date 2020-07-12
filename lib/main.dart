import 'package:bytebank_2/route/routes.dart';
import 'package:bytebank_2/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: routeList(),
        theme: appTheme(),
        darkTheme: darkTheme()); //MaterialApp
  }
}
