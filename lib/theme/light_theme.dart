import 'package:flutter/material.dart';

class LightTheme {
  final theme = ThemeData(
    primaryColor: Colors.white,
    secondaryHeaderColor: Colors.black87,
    backgroundColor: Colors.black54,
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal),
      bodyText1: TextStyle(
          color: Colors.white54,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic),
    ),
  );

  final kPrimaryGradient = const LinearGradient(
    colors: [Colors.indigo, Colors.black87],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
