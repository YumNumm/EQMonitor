// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'latest_telegram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LatestTelegram _$LatestTelegramFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_LatestTelegram',
  json,
  ($checkedConvert) {
    final val = _LatestTelegram(
      id: $checkedConvert('id', (v) => v as String),
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$TelegramTypeEnumMap, v),
      ),
      title: $checkedConvert('title', (v) => v as String),
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
      comments: $checkedConvert(
        'comments',
        (v) => v == null ? null : Comments3.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'editorialOffice': 'editorial_office',
    'publishingOffice': 'publishing_office',
    'pressedAt': 'pressed_at',
    'reportedAt': 'reported_at',
    'infoKind': 'info_kind',
    'serialNo': 'serial_no',
    'targetedAt': 'targeted_at',
    'revokedAt': 'revoked_at',
  },
);

Map<String, dynamic> _$LatestTelegramToJson(_LatestTelegram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'editorial_office': instance.editorialOffice,
      'publishing_office': instance.publishingOffice,
      'pressed_at': instance.pressedAt.toIso8601String(),
      'reported_at': instance.reportedAt.toIso8601String(),
      'info_kind': instance.infoKind,
      'serial_no': ?instance.serialNo,
      'targeted_at': ?instance.targetedAt?.toIso8601String(),
      'revoked_at': ?instance.revokedAt?.toIso8601String(),
      'headline': ?instance.headline,
      'comments': ?instance.comments,
    };

const _$TelegramTypeEnumMap = {
  TelegramType.undefined0: '南海トラフ地震臨時情報',
  TelegramType.undefined1: '南海トラフ地震関連解説情報',
  TelegramType.undefined2: '北海道・三陸沖後発地震注意情報',
};
