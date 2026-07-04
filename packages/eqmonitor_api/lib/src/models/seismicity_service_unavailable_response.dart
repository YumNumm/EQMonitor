// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_service_unavailable_response.freezed.dart';
part 'seismicity_service_unavailable_response.g.dart';

@Freezed()
abstract class SeismicityServiceUnavailableResponse with _$SeismicityServiceUnavailableResponse {
  const factory SeismicityServiceUnavailableResponse({
    /// const: "SERVICE_UNAVAILABLE"
    required String code,
    required String message,
  }) = _SeismicityServiceUnavailableResponse;
  
  factory SeismicityServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$SeismicityServiceUnavailableResponseFromJson(json);
}
