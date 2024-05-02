import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/root/injections.dart';
import 'package:movie_app/root/movie_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependenciesInjections();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const MovieApp()));
}
