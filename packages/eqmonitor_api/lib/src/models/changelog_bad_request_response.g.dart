// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'changelog_bad_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChangelogBadRequestResponse _$ChangelogBadRequestResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ChangelogBadRequestResponse', json, ($checkedConvert) {
  final val = _ChangelogBadRequestResponse(
    code: $checkedConvert('code', (v) => v),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$ChangelogBadRequestResponseToJson(
  _ChangelogBadRequestResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
