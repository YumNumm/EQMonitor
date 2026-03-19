// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_request_body.freezed.dart';
part 'refresh_token_request_body.g.dart';

@Freezed()
abstract class RefreshTokenRequestBody with _$RefreshTokenRequestBody {
  const factory RefreshTokenRequestBody({
    /// The provider ID for the OAuth provider
    required String providerId,

    /// The account ID associated with the refresh token
    @JsonKey(includeIfNull: false)
    String? accountId,

    /// The user ID associated with the account
    @JsonKey(includeIfNull: false)
    String? userId,
  }) = _RefreshTokenRequestBody;
  
  factory RefreshTokenRequestBody.fromJson(Map<String, Object?> json) => _$RefreshTokenRequestBodyFromJson(json);
}
