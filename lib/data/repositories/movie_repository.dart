import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/data/data_sources/remote/movie_remote_datasource.dart';
import 'package:movie_app/utils/network/exceptions.dart';
import 'package:movie_app/utils/network/failures.dart';

import '../models/movie/movie.dart';
import '../models/paging/paging_response.dart';

abstract class MovieRepository {
  Future<Either<Failure, PagingResponse<Movie>>> fetchMovies();
}

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, PagingResponse<Movie>>> fetchMovies() async {
    try {
      final response = await remoteDatasource.movies(page: 1, adults: false, includeVideo: false, lng: 'en-US');
      return Right(response);
    } on DioException catch (e) {
      final errorMessage = CustomException.fromDioError(e).message;
      return Left(RequestFailure(message: errorMessage));
    }
  }

}