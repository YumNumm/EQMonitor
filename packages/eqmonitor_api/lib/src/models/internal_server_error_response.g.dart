// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'internal_server_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InternalServerErrorResponse _$InternalServerErrorResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_InternalServerErrorResponse', json, ($checkedConvert) {
  final val = _InternalServerErrorResponse(
    code: $checkedConvert('code', (v) => v),
    message: $checkedConvert('message', (v) => v),
    reason: $checkedConvert('reason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$InternalServerErrorResponseToJson(
  _InternalServerErrorResponse instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'reason': ?instance.reason,
};
