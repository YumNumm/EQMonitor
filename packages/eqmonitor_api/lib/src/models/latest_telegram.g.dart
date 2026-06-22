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
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$TelegramTypeEnumMap, v),
      ),
      title: $checkedConvert('title', (v) => v as String),
      pressAt: $checkedConvert('press_at', (v) => DateTime.parse(v as String)),
      reportAt: $checkedConvert(
        'report_at',
        (v) => DateTime.parse(v as String),
      ),
      infoKind: $checkedConvert('info_kind', (v) => v as String),
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
      comments: $checkedConvert(
        'comments',
        (v) => v == null ? null : Comments3.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'pressAt': 'press_at',
    'reportAt': 'report_at',
    'infoKind': 'info_kind',
    'serialNo': 'serial_no',
    'targetAt': 'target_at',
    'revokeAt': 'revoke_at',
  },
);

Map<String, dynamic> _$LatestTelegramToJson(_LatestTelegram instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'press_at': instance.pressAt.toIso8601String(),
      'report_at': instance.reportAt.toIso8601String(),
      'info_kind': instance.infoKind,
      'serial_no': ?instance.serialNo,
      'target_at': ?instance.targetAt?.toIso8601String(),
      'revoke_at': ?instance.revokeAt?.toIso8601String(),
      'headline': ?instance.headline,
      'comments': ?instance.comments,
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
