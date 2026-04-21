// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'conflict_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConflictResponse _$ConflictResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ConflictResponse', json, ($checkedConvert) {
      final val = _ConflictResponse(
        code: $checkedConvert('code', (v) => v),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ConflictResponseToJson(_ConflictResponse instance) =>
    <String, dynamic>{'code': instance.code, 'message': instance.message};
