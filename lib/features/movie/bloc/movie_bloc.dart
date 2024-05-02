import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/data/models/paging/paging_response.dart';
import 'package:movie_app/utils/network/failures.dart';

import '../../../data/models/movie/movie.dart';
import '../../../data/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';
part 'movie_bloc.freezed.dart';

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepo;

  MovieBloc({required this.movieRepo}) : super(const MovieState.initial()) {
    on<FetchMovie>(_FetchMovie);
  }

  _FetchMovie(FetchMovie event, Emitter<MovieState> emit) async {
    emit(const MovieState.loading());

    final failedOrSuccess = await movieRepo.fetchMovies();
    emit(
      failedOrSuccess.fold(
        (failed) =>
            MovieState.error(message: (failed as RequestFailure).message),
        (success) => MovieState.success(
          movies: success.results,
          page: success.page,
        ),
      ),
    );
  }
}
