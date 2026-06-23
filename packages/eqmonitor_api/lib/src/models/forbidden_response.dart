// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'forbidden_response.freezed.dart';
part 'forbidden_response.g.dart';

@Freezed()
abstract class ForbiddenResponse with _$ForbiddenResponse {
  const factory ForbiddenResponse({
    required dynamic code,
    required String message,
  }) = _ForbiddenResponse;
  
  factory ForbiddenResponse.fromJson(Map<String, Object?> json) => _$ForbiddenResponseFromJson(json);
}
