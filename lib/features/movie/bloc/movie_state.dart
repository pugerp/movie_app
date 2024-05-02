part of 'movie_bloc.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState.initial() = _Initial;
  const factory MovieState.loading() = _Loading;
  const factory MovieState.success({required List<Movie> movies, required int page}) = _Success;
  const factory MovieState.error({required String message}) = _Error;
}