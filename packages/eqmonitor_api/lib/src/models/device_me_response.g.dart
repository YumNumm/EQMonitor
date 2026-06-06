// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_me_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceMeResponse _$DeviceMeResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceMeResponse', json, ($checkedConvert) {
  final val = _DeviceMeResponse(
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert('type', (v) => v),
    registrationType: $checkedConvert('registrationType', (v) => v),
    userId: $checkedConvert('userId', (v) => v as String?),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    locale: $checkedConvert('locale', (v) => v as String? ?? 'ja'),
  );
  return val;
});

Map<String, dynamic> _$DeviceMeResponseToJson(_DeviceMeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'registrationType': instance.registrationType,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'locale': instance.locale,
    };
