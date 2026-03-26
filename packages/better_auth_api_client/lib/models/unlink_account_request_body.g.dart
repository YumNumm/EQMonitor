// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'unlink_account_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UnlinkAccountRequestBody _$UnlinkAccountRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_UnlinkAccountRequestBody',
  json,
  ($checkedConvert) {
    final val = _UnlinkAccountRequestBody(
      providerId: $checkedConvert('provider_id', (v) => v as String),
      accountId: $checkedConvert('account_id', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'providerId': 'provider_id', 'accountId': 'account_id'},
);

Map<String, dynamic> _$UnlinkAccountRequestBodyToJson(
  _UnlinkAccountRequestBody instance,
) => <String, dynamic>{
  'provider_id': instance.providerId,
  'account_id': ?instance.accountId,
};
