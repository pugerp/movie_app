import 'package:dio/dio.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class ConnectionException implements Exception {}

class CustomException implements Exception {
  late String message;
  late int statusCode;

  CustomException.fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        statusCode = 0;
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        statusCode = 0;
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        statusCode = 0;
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        statusCode = error.response?.statusCode ?? 0;
        message = _handleError(
          error.response?.statusCode,
          error.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.unknown:
        if (error.message!.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    if (error != null) {
      String message = error['meta']['message'];
      String message_data = error['data']['message'];
      var code = error['meta']['code'];
      return message != null && message.isNotEmpty ? message : message_data;
    } else {
      return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
