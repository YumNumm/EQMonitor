// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'telegram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelegramV1Impl _$$TelegramV1ImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramV1Impl',
      json,
      ($checkedConvert) {
        final val = _$TelegramV1Impl(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          type: $checkedConvert('type', (v) => v as String),
          schemaType: $checkedConvert('schema_type', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          infoType: $checkedConvert('info_type', (v) => v as String),
          pressTime:
              $checkedConvert('press_time', (v) => DateTime.parse(v as String)),
          reportTime: $checkedConvert(
              'report_time', (v) => DateTime.parse(v as String)),
          validTime: $checkedConvert('valid_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
          headline: $checkedConvert('headline', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as Map<String, dynamic>),
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
        'serialNo': 'serial_no'
      },
    );

Map<String, dynamic> _$$TelegramV1ImplToJson(_$TelegramV1Impl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'type': instance.type,
      'schema_type': instance.schemaType,
      'status': instance.status,
      'info_type': instance.infoType,
      'press_time': instance.pressTime.toIso8601String(),
      'report_time': instance.reportTime.toIso8601String(),
      'valid_time': instance.validTime?.toIso8601String(),
      'serial_no': instance.serialNo,
      'headline': instance.headline,
      'body': instance.body,
    };
