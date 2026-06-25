// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'unauthorized_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UnauthorizedResponse _$UnauthorizedResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_UnauthorizedResponse', json, ($checkedConvert) {
  final val = _UnauthorizedResponse(
    code: $checkedConvert('code', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$UnauthorizedResponseToJson(
  _UnauthorizedResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
