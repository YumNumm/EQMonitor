// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hypocenter_service_unavailable_response.freezed.dart';
part 'hypocenter_service_unavailable_response.g.dart';

@Freezed()
abstract class HypocenterServiceUnavailableResponse with _$HypocenterServiceUnavailableResponse {
  const factory HypocenterServiceUnavailableResponse({
    /// const: "SERVICE_UNAVAILABLE"
    required String code,
    required String message,
  }) = _HypocenterServiceUnavailableResponse;
  
  factory HypocenterServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$HypocenterServiceUnavailableResponseFromJson(json);
}
