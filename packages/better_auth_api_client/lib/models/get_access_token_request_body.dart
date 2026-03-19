// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_access_token_request_body.freezed.dart';
part 'get_access_token_request_body.g.dart';

@Freezed()
abstract class GetAccessTokenRequestBody with _$GetAccessTokenRequestBody {
  const factory GetAccessTokenRequestBody({
    /// The provider ID for the OAuth provider
    required String providerId,

    /// The account ID associated with the refresh token
    @JsonKey(includeIfNull: false)
    String? accountId,

    /// The user ID associated with the account
    @JsonKey(includeIfNull: false)
    String? userId,
  }) = _GetAccessTokenRequestBody;
  
  factory GetAccessTokenRequestBody.fromJson(Map<String, Object?> json) => _$GetAccessTokenRequestBodyFromJson(json);
}
