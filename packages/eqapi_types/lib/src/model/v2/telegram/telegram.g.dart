// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'telegram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Telegram _$TelegramFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Telegram',
  json,
  ($checkedConvert) {
    final val = _Telegram(
      id: $checkedConvert('id', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
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
      targetAt: $checkedConvert(
        'target_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      revokeAt: $checkedConvert(
        'revoke_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      headline: $checkedConvert('headline', (v) => v as String?),
      infoKind: $checkedConvert('info_kind', (v) => v as String),
      infoKindVersion: $checkedConvert('info_kind_version', (v) => v as String),
      hash: $checkedConvert('hash', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'serialNo': 'serial_no',
    'infoType': 'info_type',
    'editorialOffice': 'editorial_office',
    'publishingOffice': 'publishing_office',
    'pressAt': 'press_at',
    'reportAt': 'report_at',
    'targetAt': 'target_at',
    'revokeAt': 'revoke_at',
    'infoKind': 'info_kind',
    'infoKindVersion': 'info_kind_version',
    'createdAt': 'created_at',
  },
);

Map<String, dynamic> _$TelegramToJson(_Telegram instance) => <String, dynamic>{
  'id': instance.id,
  'event_id': instance.eventId,
  'serial_no': instance.serialNo,
  'type': _$TelegramTypeEnumMap[instance.type]!,
  'title': instance.title,
  'status': _$TelegramStatusEnumMap[instance.status]!,
  'info_type': _$TelegramInfoTypeEnumMap[instance.infoType]!,
  'editorial_office': instance.editorialOffice,
  'publishing_office': instance.publishingOffice,
  'press_at': instance.pressAt.toIso8601String(),
  'report_at': instance.reportAt.toIso8601String(),
  'target_at': instance.targetAt?.toIso8601String(),
  'revoke_at': instance.revokeAt?.toIso8601String(),
  'headline': instance.headline,
  'info_kind': instance.infoKind,
  'info_kind_version': instance.infoKindVersion,
  'hash': instance.hash,
  'created_at': instance.createdAt.toIso8601String(),
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

_TelegramDetail _$TelegramDetailFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TelegramDetail',
  json,
  ($checkedConvert) {
    final val = _TelegramDetail(
      id: $checkedConvert('id', (v) => v as String),
      eventId: $checkedConvert('event_id', (v) => v as String),
      serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
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
      targetAt: $checkedConvert(
        'target_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      revokeAt: $checkedConvert(
        'revoke_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      headline: $checkedConvert('headline', (v) => v as String?),
      infoKind: $checkedConvert('info_kind', (v) => v as String),
      infoKindVersion: $checkedConvert('info_kind_version', (v) => v as String),
      hash: $checkedConvert('hash', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      body: $checkedConvert('body', (v) => v),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'serialNo': 'serial_no',
    'infoType': 'info_type',
    'editorialOffice': 'editorial_office',
    'publishingOffice': 'publishing_office',
    'pressAt': 'press_at',
    'reportAt': 'report_at',
    'targetAt': 'target_at',
    'revokeAt': 'revoke_at',
    'infoKind': 'info_kind',
    'infoKindVersion': 'info_kind_version',
    'createdAt': 'created_at',
  },
);

Map<String, dynamic> _$TelegramDetailToJson(_TelegramDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'serial_no': instance.serialNo,
      'type': _$TelegramTypeEnumMap[instance.type]!,
      'title': instance.title,
      'status': _$TelegramStatusEnumMap[instance.status]!,
      'info_type': _$TelegramInfoTypeEnumMap[instance.infoType]!,
      'editorial_office': instance.editorialOffice,
      'publishing_office': instance.publishingOffice,
      'press_at': instance.pressAt.toIso8601String(),
      'report_at': instance.reportAt.toIso8601String(),
      'target_at': instance.targetAt?.toIso8601String(),
      'revoke_at': instance.revokeAt?.toIso8601String(),
      'headline': instance.headline,
      'info_kind': instance.infoKind,
      'info_kind_version': instance.infoKindVersion,
      'hash': instance.hash,
      'created_at': instance.createdAt.toIso8601String(),
      'body': instance.body,
    };
