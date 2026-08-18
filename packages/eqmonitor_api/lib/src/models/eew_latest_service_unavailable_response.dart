// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_latest_service_unavailable_response.freezed.dart';
part 'eew_latest_service_unavailable_response.g.dart';

@Freezed()
abstract class EewLatestServiceUnavailableResponse with _$EewLatestServiceUnavailableResponse {
  const factory EewLatestServiceUnavailableResponse({
    /// const: "SERVICE_UNAVAILABLE"
    required String code,
    required String message,
  }) = _EewLatestServiceUnavailableResponse;
  
  factory EewLatestServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$EewLatestServiceUnavailableResponseFromJson(json);
}
