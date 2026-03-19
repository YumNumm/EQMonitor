// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_refresh_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostRefreshTokenResponse _$PostRefreshTokenResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_PostRefreshTokenResponse',
  json,
  ($checkedConvert) {
    final val = _PostRefreshTokenResponse(
      tokenType: $checkedConvert('token_type', (v) => v as String),
      idToken: $checkedConvert('id_token', (v) => v as String),
      accessToken: $checkedConvert('access_token', (v) => v as String),
      refreshToken: $checkedConvert('refresh_token', (v) => v as String),
      accessTokenExpiresAt: $checkedConvert(
        'access_token_expires_at',
        (v) => DateTime.parse(v as String),
      ),
      refreshTokenExpiresAt: $checkedConvert(
        'refresh_token_expires_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'tokenType': 'token_type',
    'idToken': 'id_token',
    'accessToken': 'access_token',
    'refreshToken': 'refresh_token',
    'accessTokenExpiresAt': 'access_token_expires_at',
    'refreshTokenExpiresAt': 'refresh_token_expires_at',
  },
);

Map<String, dynamic> _$PostRefreshTokenResponseToJson(
  _PostRefreshTokenResponse instance,
) => <String, dynamic>{
  'token_type': instance.tokenType,
  'id_token': instance.idToken,
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'access_token_expires_at': instance.accessTokenExpiresAt.toIso8601String(),
  'refresh_token_expires_at': instance.refreshTokenExpiresAt.toIso8601String(),
};
