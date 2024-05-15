import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/utils/network/failures.dart';

import '../../../data/models/movie/movie.dart';
import '../../../data/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';
part 'movie_bloc.freezed.dart';


@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepo;
  List<Movie> movies = [];
  int nextPage = 1;
  bool isLoadingLoadMore = false;

  MovieBloc({required this.movieRepo}) : super(const MovieState.initial()) {
    on<FetchMovie>(_FetchMovie);
  }

  _FetchMovie(FetchMovie event, Emitter<MovieState> emit) async {
    if (event.initial) {
      emit(const MovieState.loading());
    } else {
      isLoadingLoadMore = true;
    }

    final failedOrSuccess = await movieRepo.fetchMovies(page: event.page);
    emit(
      failedOrSuccess.fold(
        (failed) =>
            MovieState.error(message: (failed as RequestFailure).message),
        (success) {
          isLoadingLoadMore = false;
          movies.addAll(success.results);
          nextPage++;
          return MovieState.success(
            movies: movies,
            page: success.page,
          );
        },
      ),
    );
  }
}


