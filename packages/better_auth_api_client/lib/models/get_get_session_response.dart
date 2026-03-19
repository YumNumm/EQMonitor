// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'session.dart';
import 'user.dart';

part 'get_get_session_response.freezed.dart';
part 'get_get_session_response.g.dart';

@Freezed()
abstract class GetGetSessionResponse with _$GetGetSessionResponse {
  const factory GetGetSessionResponse({
    required Session session,
    required User user,
  }) = _GetGetSessionResponse;
  
  factory GetGetSessionResponse.fromJson(Map<String, Object?> json) => _$GetGetSessionResponseFromJson(json);
}
