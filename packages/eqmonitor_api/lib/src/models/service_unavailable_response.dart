// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_unavailable_response.freezed.dart';
part 'service_unavailable_response.g.dart';

@Freezed()
abstract class ServiceUnavailableResponse with _$ServiceUnavailableResponse {
  const factory ServiceUnavailableResponse({
    required String code,
    required String message,
  }) = _ServiceUnavailableResponse;
  
  factory ServiceUnavailableResponse.fromJson(Map<String, Object?> json) => _$ServiceUnavailableResponseFromJson(json);
}
