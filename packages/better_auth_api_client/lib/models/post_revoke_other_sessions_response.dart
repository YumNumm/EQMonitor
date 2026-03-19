// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_revoke_other_sessions_response.freezed.dart';
part 'post_revoke_other_sessions_response.g.dart';

@Freezed()
abstract class PostRevokeOtherSessionsResponse with _$PostRevokeOtherSessionsResponse {
  const factory PostRevokeOtherSessionsResponse({
    /// Indicates if all other sessions were revoked successfully
    required bool status,
  }) = _PostRevokeOtherSessionsResponse;
  
  factory PostRevokeOtherSessionsResponse.fromJson(Map<String, Object?> json) => _$PostRevokeOtherSessionsResponseFromJson(json);
}
