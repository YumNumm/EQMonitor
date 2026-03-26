// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'id_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IdToken _$IdTokenFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_IdToken',
  json,
  ($checkedConvert) {
    final val = _IdToken(
      token: $checkedConvert('token', (v) => v as String),
      nonce: $checkedConvert('nonce', (v) => v as String?),
      accessToken: $checkedConvert('access_token', (v) => v as String?),
      refreshToken: $checkedConvert('refresh_token', (v) => v as String?),
      expiresAt: $checkedConvert('expires_at', (v) => v as num?),
      user: $checkedConvert(
        'user',
        (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'accessToken': 'access_token',
    'refreshToken': 'refresh_token',
    'expiresAt': 'expires_at',
  },
);

Map<String, dynamic> _$IdTokenToJson(_IdToken instance) => <String, dynamic>{
  'token': instance.token,
  'nonce': ?instance.nonce,
  'access_token': ?instance.accessToken,
  'refresh_token': ?instance.refreshToken,
  'expires_at': ?instance.expiresAt,
  'user': ?instance.user,
};
