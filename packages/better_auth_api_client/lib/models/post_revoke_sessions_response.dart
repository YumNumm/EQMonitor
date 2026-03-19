// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_revoke_sessions_response.freezed.dart';
part 'post_revoke_sessions_response.g.dart';

@Freezed()
abstract class PostRevokeSessionsResponse with _$PostRevokeSessionsResponse {
  const factory PostRevokeSessionsResponse({
    /// Indicates if all sessions were revoked successfully
    required bool status,
  }) = _PostRevokeSessionsResponse;
  
  factory PostRevokeSessionsResponse.fromJson(Map<String, Object?> json) => _$PostRevokeSessionsResponseFromJson(json);
}
