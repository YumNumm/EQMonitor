// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'internal_server_error_response.freezed.dart';
part 'internal_server_error_response.g.dart';

@Freezed()
abstract class InternalServerErrorResponse with _$InternalServerErrorResponse {
  const factory InternalServerErrorResponse({
    required dynamic code,
    required dynamic message,
    @JsonKey(includeIfNull: false) String? reason,
  }) = _InternalServerErrorResponse;

  factory InternalServerErrorResponse.fromJson(Map<String, Object?> json) =>
      _$InternalServerErrorResponseFromJson(json);
}
