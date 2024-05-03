import 'package:flutter/material.dart';

class DefaultTheme {
  static final ThemeData _defaultTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  static ThemeData light = _defaultTheme.copyWith(
    primaryColor: Colors.lightBlue,
    scaffoldBackgroundColor: Colors.white
  );

  static ThemeData dark = _defaultTheme.copyWith(
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.blueGrey,
  );
}