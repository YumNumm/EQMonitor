// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'id_token.freezed.dart';
part 'id_token.g.dart';

@Freezed()
abstract class IdToken with _$IdToken {
  const factory IdToken({
    /// ID token from the provider
    required String token,

    /// Nonce used to generate the token
    @JsonKey(includeIfNull: false)
    String? nonce,

    /// Access token from the provider
    @JsonKey(includeIfNull: false)
    String? accessToken,

    /// Refresh token from the provider
    @JsonKey(includeIfNull: false)
    String? refreshToken,

    /// Expiry date of the token
    @JsonKey(includeIfNull: false)
    num? expiresAt,

    /// The user object from the provider. Only available for some providers like Apple.
    @JsonKey(includeIfNull: false)
    User? user,
  }) = _IdToken;
  
  factory IdToken.fromJson(Map<String, Object?> json) => _$IdTokenFromJson(json);
}
