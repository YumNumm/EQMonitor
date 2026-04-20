// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'conflict_response.freezed.dart';
part 'conflict_response.g.dart';

@Freezed()
abstract class ConflictResponse with _$ConflictResponse {
  const factory ConflictResponse({
    required dynamic code,
    required String message,
  }) = _ConflictResponse;

  factory ConflictResponse.fromJson(Map<String, Object?> json) =>
      _$ConflictResponseFromJson(json);
}
