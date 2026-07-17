// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_limited_response.freezed.dart';
part 'rate_limited_response.g.dart';

@Freezed()
abstract class RateLimitedResponse with _$RateLimitedResponse {
  const factory RateLimitedResponse({
    /// const: "RATE_LIMITED"
    required String code,
    required String message,
  }) = _RateLimitedResponse;

  factory RateLimitedResponse.fromJson(Map<String, Object?> json) =>
      _$RateLimitedResponseFromJson(json);
}
