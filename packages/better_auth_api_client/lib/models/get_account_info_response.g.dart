// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_account_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetAccountInfoResponse _$GetAccountInfoResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_GetAccountInfoResponse', json, ($checkedConvert) {
  final val = _GetAccountInfoResponse(
    user: $checkedConvert(
      'user',
      (v) => User4.fromJson(v as Map<String, dynamic>),
    ),
    data: $checkedConvert('data', (v) => v),
  );
  return val;
});

Map<String, dynamic> _$GetAccountInfoResponseToJson(
  _GetAccountInfoResponse instance,
) => <String, dynamic>{'user': instance.user, 'data': instance.data};
