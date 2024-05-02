import 'package:freezed_annotation/freezed_annotation.dart';

part 'paging_response.freezed.dart';
part 'paging_response.g.dart';

@Freezed(genericArgumentFactories: true)
class PagingResponse<T> with _$PagingResponse<T> {
  const factory PagingResponse(
      {required int page,
      required List<T> results,
      @JsonKey(name: 'total_pages') required int totalPages,
      @JsonKey(name: 'total_results') required int totalResults}) = _PagingResponse<T>;

  factory PagingResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PagingResponseFromJson<T>(json, fromJsonT);
}
