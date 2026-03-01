// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'bad_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BadRequestResponse _$BadRequestResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BadRequestResponse', json, ($checkedConvert) {
      final val = _BadRequestResponse(
        code: $checkedConvert('code', (v) => v),
        message: $checkedConvert('message', (v) => v),
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$BadRequestResponseToJson(_BadRequestResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'reason': ?instance.reason,
    };
