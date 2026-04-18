// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake.dart';

part 'earthquake_detail_response.freezed.dart';
part 'earthquake_detail_response.g.dart';

@Freezed()
abstract class EarthquakeDetailResponse with _$EarthquakeDetailResponse {
  const factory EarthquakeDetailResponse({
    required Earthquake earthquake,
  }) = _EarthquakeDetailResponse;

  factory EarthquakeDetailResponse.fromJson(Map<String, Object?> json) =>
      _$EarthquakeDetailResponseFromJson(json);
}
