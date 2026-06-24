// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bad_request_response.freezed.dart';
part 'bad_request_response.g.dart';

@Freezed()
abstract class BadRequestResponse with _$BadRequestResponse {
  const factory BadRequestResponse({
    required dynamic code,
    required dynamic message,
    @JsonKey(includeIfNull: false)
    String? reason,
  }) = _BadRequestResponse;
  
  factory BadRequestResponse.fromJson(Map<String, Object?> json) => _$BadRequestResponseFromJson(json);
}
