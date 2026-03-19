// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_unlink_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostUnlinkAccountResponse _$PostUnlinkAccountResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostUnlinkAccountResponse', json, ($checkedConvert) {
  final val = _PostUnlinkAccountResponse(
    status: $checkedConvert('status', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PostUnlinkAccountResponseToJson(
  _PostUnlinkAccountResponse instance,
) => <String, dynamic>{'status': instance.status};
