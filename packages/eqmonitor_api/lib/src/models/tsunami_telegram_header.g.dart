// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegram_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiTelegramHeader _$TsunamiTelegramHeaderFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiTelegramHeader',
  json,
  ($checkedConvert) {
    final val = _TsunamiTelegramHeader(
      hash: $checkedConvert('hash', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$TelegramTypeEnumMap, v),
      ),
      title: $checkedConvert('title', (v) => v as String),
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$TelegramStatusEnumMap, v),
      ),
      infoType: $checkedConvert(
        'info_type',
        (v) => $enumDecode(_$TelegramInfoTypeEnumMap, v),
      ),
      editorialOffice: $checkedConvert('editorial_office', (v) => v as String),
      publishingOffice: $checkedConvert(
        'publishing_office',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      pressAt: $checkedConvert('press_at', (v) => DateTime.parse(v as String)),
      reportAt: $checkedConvert(
        'report_at',
        (v) => DateTime.parse(v as String),
      ),
      infoKind: $checkedConvert('info_kind', (v) => v as String),
      infoKindVersion: $checkedConvert('info_kind_version', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      serialNo: $checkedConvert('serial_no', (v) => v as num?),
      targetAt: $checkedConvert(
        'target_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      revokeAt: $checkedConvert(
        'revoke_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      headline: $checkedConvert('headline', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'infoType': 'info_type',
    'editorialOffice': 'editorial_office',
    'publishingOffice': 'publishing_office',
    'pressAt': 'press_at',
    'reportAt': 'report_at',
    'infoKind': 'info_kind',
    'infoKindVersion': 'info_kind_version',
    'createdAt': 'created_at',
    'serialNo': 'serial_no',
    'targetAt': 'target_at',
    'revokeAt': 'revoke_at',
  },
);

Map<String, dynamic> _$TsunamiTelegramHeaderToJson(
  _TsunamiTelegramHeader instance,
) => <String, dynamic>{
  'hash': instance.hash,
  'event_id': instance.eventId,
  'type': instance.type,
  'title': instance.title,
  'status': instance.status,
  'info_type': instance.infoType,
  'editorial_office': instance.editorialOffice,
  'publishing_office': instance.publishingOffice,
  'press_at': instance.pressAt.toIso8601String(),
  'report_at': instance.reportAt.toIso8601String(),
  'info_kind': instance.infoKind,
  'info_kind_version': instance.infoKindVersion,
  'created_at': instance.createdAt.toIso8601String(),
  'serial_no': ?instance.serialNo,
  'target_at': ?instance.targetAt?.toIso8601String(),
  'revoke_at': ?instance.revokeAt?.toIso8601String(),
  'headline': ?instance.headline,
};

const _$TelegramTypeEnumMap = {
  TelegramType.vzse40: 'VZSE40',
  TelegramType.vxse42: 'VXSE42',
  TelegramType.vxse43: 'VXSE43',
  TelegramType.vxse44: 'VXSE44',
  TelegramType.vxse45: 'VXSE45',
  TelegramType.vxse47: 'VXSE47',
  TelegramType.vtse41: 'VTSE41',
  TelegramType.vtse51: 'VTSE51',
  TelegramType.vtse52: 'VTSE52',
  TelegramType.vxse51: 'VXSE51',
  TelegramType.vxse52: 'VXSE52',
  TelegramType.vxse53: 'VXSE53',
  TelegramType.vxse56: 'VXSE56',
  TelegramType.vxse60: 'VXSE60',
  TelegramType.vxse61: 'VXSE61',
  TelegramType.vxse62: 'VXSE62',
  TelegramType.nankai: 'NANKAI',
  TelegramType.vyse60: 'VYSE60',
  TelegramType.shindoDb: 'SHINDO_DB',
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$TelegramInfoTypeEnumMap = {
  TelegramInfoType.publication: 'PUBLICATION',
  TelegramInfoType.correction: 'CORRECTION',
  TelegramInfoType.delay: 'DELAY',
  TelegramInfoType.cancellation: 'CANCELLATION',
};
