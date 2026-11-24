// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_archive_service_unavailable_response.freezed.dart';
part 'earthquake_archive_service_unavailable_response.g.dart';

@Freezed()
abstract class EarthquakeArchiveServiceUnavailableResponse with _$EarthquakeArchiveServiceUnavailableResponse {
  const factory EarthquakeArchiveServiceUnavailableResponse({
    /// const: "SERVICE_UNAVAILABLE"
    required String code,
    required String message,
  }) = _EarthquakeArchiveServiceUnavailableResponse;
  
  factory EarthquakeArchiveServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$EarthquakeArchiveServiceUnavailableResponseFromJson(json);
}
