// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'unauthorized_response.freezed.dart';
part 'unauthorized_response.g.dart';

@Freezed()
abstract class UnauthorizedResponse with _$UnauthorizedResponse {
  const factory UnauthorizedResponse({
    required dynamic code,
    required String message,
  }) = _UnauthorizedResponse;

  factory UnauthorizedResponse.fromJson(Map<String, Object?> json) =>
      _$UnauthorizedResponseFromJson(json);
}
