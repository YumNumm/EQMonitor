// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_service_unavailable_response.freezed.dart';
part 'parameter_service_unavailable_response.g.dart';

@Freezed()
abstract class ParameterServiceUnavailableResponse with _$ParameterServiceUnavailableResponse {
  const factory ParameterServiceUnavailableResponse({
    required dynamic code,
    required String message,
  }) = _ParameterServiceUnavailableResponse;
  
  factory ParameterServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$ParameterServiceUnavailableResponseFromJson(json);
}
