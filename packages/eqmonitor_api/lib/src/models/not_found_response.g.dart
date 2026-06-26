// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'not_found_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotFoundResponse _$NotFoundResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_NotFoundResponse', json, ($checkedConvert) {
      final val = _NotFoundResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$NotFoundResponseToJson(_NotFoundResponse instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};
