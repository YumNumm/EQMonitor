// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_list_service_unavailable_response.freezed.dart';
part 'earthquake_list_service_unavailable_response.g.dart';

@Freezed()
abstract class EarthquakeListServiceUnavailableResponse with _$EarthquakeListServiceUnavailableResponse {
  const factory EarthquakeListServiceUnavailableResponse({
    /// const: "SERVICE_UNAVAILABLE"
    required String code,
    required String message,
  }) = _EarthquakeListServiceUnavailableResponse;
  
  factory EarthquakeListServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$EarthquakeListServiceUnavailableResponseFromJson(json);
}
