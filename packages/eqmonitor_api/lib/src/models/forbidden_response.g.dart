// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'forbidden_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ForbiddenResponse _$ForbiddenResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ForbiddenResponse', json, ($checkedConvert) {
      final val = _ForbiddenResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ForbiddenResponseToJson(_ForbiddenResponse instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};
