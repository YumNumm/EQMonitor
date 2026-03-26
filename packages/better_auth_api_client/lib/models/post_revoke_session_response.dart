// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_revoke_session_response.freezed.dart';
part 'post_revoke_session_response.g.dart';

@Freezed()
abstract class PostRevokeSessionResponse with _$PostRevokeSessionResponse {
  const factory PostRevokeSessionResponse({
    /// Indicates if the session was revoked successfully
    required bool status,
  }) = _PostRevokeSessionResponse;
  
  factory PostRevokeSessionResponse.fromJson(Map<String, Object?> json) => _$PostRevokeSessionResponseFromJson(json);
}
