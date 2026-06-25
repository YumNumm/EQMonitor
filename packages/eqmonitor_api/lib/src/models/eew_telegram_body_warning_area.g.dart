// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_telegram_body_warning_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewTelegramBodyWarningArea _$EewTelegramBodyWarningAreaFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewTelegramBodyWarningArea', json, ($checkedConvert) {
  final val = _EewTelegramBodyWarningArea(
    eventId: $checkedConvert('eventId', (v) => v as String),
    serialNo: $checkedConvert('serialNo', (v) => v as num),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    hadWarning: $checkedConvert('hadWarning', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$EewTelegramBodyWarningAreaToJson(
  _EewTelegramBodyWarningArea instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'serialNo': instance.serialNo,
  'code': instance.code,
  'name': instance.name,
  'hadWarning': instance.hadWarning,
};
