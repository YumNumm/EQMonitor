// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_list_accounts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetListAccountsResponse _$GetListAccountsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_GetListAccountsResponse',
  json,
  ($checkedConvert) {
    final val = _GetListAccountsResponse(
      id: $checkedConvert('id', (v) => v as String),
      providerId: $checkedConvert('provider_id', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
      accountId: $checkedConvert('account_id', (v) => v as String),
      userId: $checkedConvert('user_id', (v) => v as String),
      scopes: $checkedConvert(
        'scopes',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'providerId': 'provider_id',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'accountId': 'account_id',
    'userId': 'user_id',
  },
);

Map<String, dynamic> _$GetListAccountsResponseToJson(
  _GetListAccountsResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'provider_id': instance.providerId,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'account_id': instance.accountId,
  'user_id': instance.userId,
  'scopes': instance.scopes,
};
