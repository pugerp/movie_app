import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTheme {
  static final ThemeData _defaultTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(4.r))
        ))
      )
    )
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