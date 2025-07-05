// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'telegram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramV1 _$TelegramV1FromJson(Map<String, dynamic> json) => $checkedCreate(
  '_TelegramV1',
  json,
  ($checkedConvert) {
    final val = _TelegramV1(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
      type: $checkedConvert('type', (v) => v as String),
      schemaType: $checkedConvert('schema_type', (v) => v as String),
      status: $checkedConvert('status', (v) => v as String),
      infoType: $checkedConvert('info_type', (v) => v as String),
      pressTime: $checkedConvert(
        'press_time',
        (v) => DateTime.parse(v as String),
      ),
      reportTime: $checkedConvert(
        'report_time',
        (v) => DateTime.parse(v as String),
      ),
      body: $checkedConvert('body', (v) => v as Map<String, dynamic>),
      validTime: $checkedConvert(
        'valid_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
      headline: $checkedConvert('headline', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'schemaType': 'schema_type',
    'infoType': 'info_type',
    'pressTime': 'press_time',
    'reportTime': 'report_time',
    'validTime': 'valid_time',
    'serialNo': 'serial_no',
  },
);

Map<String, dynamic> _$TelegramV1ToJson(_TelegramV1 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'type': instance.type,
      'schema_type': instance.schemaType,
      'status': instance.status,
      'info_type': instance.infoType,
      'press_time': instance.pressTime.toIso8601String(),
      'report_time': instance.reportTime.toIso8601String(),
      'body': instance.body,
      'valid_time': instance.validTime?.toIso8601String(),
      'serial_no': instance.serialNo,
      'headline': instance.headline,
    };
