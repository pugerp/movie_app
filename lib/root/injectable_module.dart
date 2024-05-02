import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/network/api_provider.dart';
import '../utils/network/custom_interceptor.dart';

@module
abstract class InjecatableModule {

  @preResolve
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  ApiProvider provider(Dio dio, CustomInterceptor interceptor) => ApiProvider(
        dio: dio,
        interceptor: interceptor,
        baseUrl: 'https://api.themoviedb.org/3/',
      );
}
