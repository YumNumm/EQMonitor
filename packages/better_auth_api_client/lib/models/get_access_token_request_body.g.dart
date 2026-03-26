// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_access_token_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetAccessTokenRequestBody _$GetAccessTokenRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_GetAccessTokenRequestBody',
  json,
  ($checkedConvert) {
    final val = _GetAccessTokenRequestBody(
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

Map<String, dynamic> _$GetAccessTokenRequestBodyToJson(
  _GetAccessTokenRequestBody instance,
) => <String, dynamic>{
  'provider_id': instance.providerId,
  'account_id': ?instance.accountId,
  'user_id': ?instance.userId,
};
