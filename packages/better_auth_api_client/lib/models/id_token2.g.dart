// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'id_token2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IdToken2 _$IdToken2FromJson(Map<String, dynamic> json) => $checkedCreate(
  '_IdToken2',
  json,
  ($checkedConvert) {
    final val = _IdToken2(
      token: $checkedConvert('token', (v) => v as String),
      nonce: $checkedConvert('nonce', (v) => v as String?),
      accessToken: $checkedConvert('access_token', (v) => v as String?),
      refreshToken: $checkedConvert('refresh_token', (v) => v as String?),
      scopes: $checkedConvert('scopes', (v) => v as List<dynamic>?),
    );
    return val;
  },
  fieldKeyMap: const {
    'accessToken': 'access_token',
    'refreshToken': 'refresh_token',
  },
);

Map<String, dynamic> _$IdToken2ToJson(_IdToken2 instance) => <String, dynamic>{
  'token': instance.token,
  'nonce': ?instance.nonce,
  'access_token': ?instance.accessToken,
  'refresh_token': ?instance.refreshToken,
  'scopes': ?instance.scopes,
};
