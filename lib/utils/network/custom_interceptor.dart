import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/utils/common/constants.dart' as constants;

@injectable
class CustomInterceptor extends Interceptor {
  final SharedPreferences sp;

  CustomInterceptor({required this.sp});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZjJlMTY0MTUxMmY5ODM1ZDJiM2Y4YjBhODgyOTVjMyIsInN1YiI6IjYyNWZjMzVkMDc5MmUxMTUxZGFmMGRkYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eyLOp6dXAbGG6tlq0XV6VFKd_7fr2UZyomKInVvCQk4';
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}