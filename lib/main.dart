import 'package:flutter/material.dart';

import 'screens/dashboard.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: _buttonTheme(),
      ),
      home: Dashboard(),
    );
  }

  ButtonThemeData _buttonTheme() {
    return ButtonThemeData(
      buttonColor: Colors.blueAccent[700],
      textTheme: ButtonTextTheme.primary,
    );
  }
}
