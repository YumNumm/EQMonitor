// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'revoke_session_request_body.freezed.dart';
part 'revoke_session_request_body.g.dart';

@Freezed()
abstract class RevokeSessionRequestBody with _$RevokeSessionRequestBody {
  const factory RevokeSessionRequestBody({
    /// The token to revoke
    required String token,
  }) = _RevokeSessionRequestBody;
  
  factory RevokeSessionRequestBody.fromJson(Map<String, Object?> json) => _$RevokeSessionRequestBodyFromJson(json);
}
