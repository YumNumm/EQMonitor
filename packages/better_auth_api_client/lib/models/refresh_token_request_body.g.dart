// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'refresh_token_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RefreshTokenRequestBody _$RefreshTokenRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RefreshTokenRequestBody',
  json,
  ($checkedConvert) {
    final val = _RefreshTokenRequestBody(
      providerId: $checkedConvert('provider_id', (v) => v as String),
      accountId: $checkedConvert('account_id', (v) => v as String?),
      userId: $checkedConvert('user_id', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'providerId': 'provider_id',
    'accountId': 'account_id',
    'userId': 'user_id',
  },
);

Map<String, dynamic> _$RefreshTokenRequestBodyToJson(
  _RefreshTokenRequestBody instance,
) => <String, dynamic>{
  'provider_id': instance.providerId,
  'account_id': ?instance.accountId,
  'user_id': ?instance.userId,
};
