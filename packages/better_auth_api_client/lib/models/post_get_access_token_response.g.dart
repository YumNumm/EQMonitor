// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_get_access_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostGetAccessTokenResponse _$PostGetAccessTokenResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_PostGetAccessTokenResponse',
  json,
  ($checkedConvert) {
    final val = _PostGetAccessTokenResponse(
      tokenType: $checkedConvert('token_type', (v) => v as String),
      idToken: $checkedConvert('id_token', (v) => v as String),
      accessToken: $checkedConvert('access_token', (v) => v as String),
      accessTokenExpiresAt: $checkedConvert(
        'access_token_expires_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'tokenType': 'token_type',
    'idToken': 'id_token',
    'accessToken': 'access_token',
    'accessTokenExpiresAt': 'access_token_expires_at',
  },
);

Map<String, dynamic> _$PostGetAccessTokenResponseToJson(
  _PostGetAccessTokenResponse instance,
) => <String, dynamic>{
  'token_type': instance.tokenType,
  'id_token': instance.idToken,
  'access_token': instance.accessToken,
  'access_token_expires_at': instance.accessTokenExpiresAt.toIso8601String(),
};
