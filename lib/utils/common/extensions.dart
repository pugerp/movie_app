import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/main/bloc/theme_bloc.dart';

extension StringExtension on String {
  String hhMMFormat() {
    if (isNotEmpty) {
      var time = DateFormat("HH:mm:ss").parse(this);
      String formated = DateFormat("HH:mm").format(time);
      return formated;
    }
    return '';
  }

  String toMainPath() {
    return '/$this';
  }
}

extension ThemeStateX on ThemeState {
  ThemeMode get themeMode => when(
    initial: () => ThemeMode.system,
    light: () => ThemeMode.light,
    dark: () => ThemeMode.dark,
  );
}