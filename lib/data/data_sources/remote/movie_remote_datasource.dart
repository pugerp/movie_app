import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/utils/network/api_provider.dart';

import '../../models/movie/movie.dart';
import '../../models/paging/paging_response.dart';

abstract class MovieRemoteDatasource {
  Future<PagingResponse<Movie>> movies({
    required int page,
    required bool adults,
    required bool includeVideo,
    required String lng,
  });
}

@LazySingleton(as: MovieRemoteDatasource)
class MovieRemoteDatasourceImpl extends MovieRemoteDatasource {
  final ApiProvider provider;

  MovieRemoteDatasourceImpl({required this.provider});

  @override
  Future<PagingResponse<Movie>> movies(
      {required int page,
      required bool adults,
      required bool includeVideo,
      required String lng}) async {
    var params = {
      'page': page,
      'include_adults': false,
      'include_video': false,
      'language': 'en-US'
    };

    final response = await provider.get('discover/movie', queryParameters: params);

    if (response.statusCode == 200) {
      final result = PagingResponse.fromJson(response.data,
          (json) => Movie.fromJson(json as Map<String, dynamic>));
      return result;
    } else {
      throw DioException(requestOptions: response.requestOptions);
    }
  }
}
