// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'telegram_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TelegramDetail _$TelegramDetailFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TelegramDetail',
  json,
  ($checkedConvert) {
    final val = _TelegramDetail(
      id: $checkedConvert('id', (v) => v as String),
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
        (v) => $enumDecode(_$InfoTypeEnumMap, v),
      ),
      editorialOffice: $checkedConvert('editorial_office', (v) => v as String),
      publishingOffice: $checkedConvert(
        'publishing_office',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      pressedAt: $checkedConvert(
        'pressed_at',
        (v) => DateTime.parse(v as String),
      ),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
      infoKind: $checkedConvert('info_kind', (v) => v as String),
      infoKindVersion: $checkedConvert('info_kind_version', (v) => v as String),
      hash: $checkedConvert('hash', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      body: $checkedConvert(
        'body',
        (v) => TelegramBodyUnion.fromJson(v as Map<String, dynamic>),
      ),
      serialNo: $checkedConvert('serial_no', (v) => v as num?),
      targetedAt: $checkedConvert(
        'targeted_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      revokedAt: $checkedConvert(
        'revoked_at',
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
    'pressedAt': 'pressed_at',
    'reportedAt': 'reported_at',
    'infoKind': 'info_kind',
    'infoKindVersion': 'info_kind_version',
    'createdAt': 'created_at',
    'serialNo': 'serial_no',
    'targetedAt': 'targeted_at',
    'revokedAt': 'revoked_at',
  },
);

Map<String, dynamic> _$TelegramDetailToJson(_TelegramDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'type': instance.type,
      'title': instance.title,
      'status': instance.status,
      'info_type': instance.infoType,
      'editorial_office': instance.editorialOffice,
      'publishing_office': instance.publishingOffice,
      'pressed_at': instance.pressedAt.toIso8601String(),
      'reported_at': instance.reportedAt.toIso8601String(),
      'info_kind': instance.infoKind,
      'info_kind_version': instance.infoKindVersion,
      'hash': instance.hash,
      'created_at': instance.createdAt.toIso8601String(),
      'body': instance.body,
      'serial_no': ?instance.serialNo,
      'targeted_at': ?instance.targetedAt?.toIso8601String(),
      'revoked_at': ?instance.revokedAt?.toIso8601String(),
      'headline': ?instance.headline,
    };

const _$TelegramTypeEnumMap = {
  TelegramType.undefined0: '南海トラフ地震臨時情報',
  TelegramType.undefined1: '南海トラフ地震関連解説情報',
  TelegramType.undefined2: '北海道・三陸沖後発地震注意情報',
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$InfoTypeEnumMap = {
  InfoType.publication: 'PUBLICATION',
  InfoType.correction: 'CORRECTION',
  InfoType.cancellation: 'CANCELLATION',
};
