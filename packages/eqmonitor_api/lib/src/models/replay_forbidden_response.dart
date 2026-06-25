// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_forbidden_response.freezed.dart';
part 'replay_forbidden_response.g.dart';

@Freezed()
abstract class ReplayForbiddenResponse with _$ReplayForbiddenResponse {
  const factory ReplayForbiddenResponse({
    required String code,
    required String message,
  }) = _ReplayForbiddenResponse;
  
  factory ReplayForbiddenResponse.fromJson(Map<String, Object?> json) => _$ReplayForbiddenResponseFromJson(json);
}
