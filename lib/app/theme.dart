import 'package:flutter/material.dart';

var lightThemeData = new ThemeData(
  primaryColor: Colors.red,
  textTheme: new TextTheme(button: TextStyle(color: Colors.white70)),
  brightness: Brightness.light,
  accentColor: Colors.red,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

var darkThemeData = ThemeData(
  primaryColor: Colors.red,
  textTheme: new TextTheme(button: TextStyle(color: Colors.black54)),
  brightness: Brightness.dark,
  accentColor: Colors.red,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
