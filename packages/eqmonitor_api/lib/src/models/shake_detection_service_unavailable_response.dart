// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_service_unavailable_response.freezed.dart';
part 'shake_detection_service_unavailable_response.g.dart';

@Freezed()
abstract class ShakeDetectionServiceUnavailableResponse with _$ShakeDetectionServiceUnavailableResponse {
  const factory ShakeDetectionServiceUnavailableResponse({
    /// const: "SERVICE_UNAVAILABLE"
    required String code,
    required String message,
  }) = _ShakeDetectionServiceUnavailableResponse;

  factory ShakeDetectionServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$ShakeDetectionServiceUnavailableResponseFromJson(json);
}
