import 'package:intl/intl.dart';

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