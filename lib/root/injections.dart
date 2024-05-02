import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injections.config.dart';

final sl = GetIt.I;

@InjectableInit()
Future<void> configureDependenciesInjections() async => await sl.init();