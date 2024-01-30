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
          id: $checkedConvert('id', (v) => v as int),
          eventId: $checkedConvert('eventId', (v) => v as int),
          type: $checkedConvert('type', (v) => v as String),
          schemaType: $checkedConvert('schemaType', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          infoType: $checkedConvert('infoType', (v) => v as String),
          pressTime:
              $checkedConvert('pressTime', (v) => DateTime.parse(v as String)),
          reportTime:
              $checkedConvert('reportTime', (v) => DateTime.parse(v as String)),
          validTime: $checkedConvert('validTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          serialNo: $checkedConvert('serialNo', (v) => v as int?),
          headline: $checkedConvert('headline', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as Map<String, dynamic>),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramV1ImplToJson(_$TelegramV1Impl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'type': instance.type,
      'schemaType': instance.schemaType,
      'status': instance.status,
      'infoType': instance.infoType,
      'pressTime': instance.pressTime.toIso8601String(),
      'reportTime': instance.reportTime.toIso8601String(),
      'validTime': instance.validTime?.toIso8601String(),
      'serialNo': instance.serialNo,
      'headline': instance.headline,
      'body': instance.body,
    };
