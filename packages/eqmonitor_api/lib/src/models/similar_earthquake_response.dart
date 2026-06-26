// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'similar_earthquake_item.dart';

part 'similar_earthquake_response.freezed.dart';
part 'similar_earthquake_response.g.dart';

@Freezed()
abstract class SimilarEarthquakeResponse with _$SimilarEarthquakeResponse {
  const factory SimilarEarthquakeResponse({
    required List<SimilarEarthquakeItem> items,
  }) = _SimilarEarthquakeResponse;
  
  factory SimilarEarthquakeResponse.fromJson(Map<String, Object?> json) => _$SimilarEarthquakeResponseFromJson(json);
}
