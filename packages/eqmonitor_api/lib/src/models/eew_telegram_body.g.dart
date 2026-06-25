// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_telegram_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewTelegramBody _$EewTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewTelegramBody', json, ($checkedConvert) {
  final val = _EewTelegramBody(
    type: $checkedConvert('type', (v) => v as String),
    eew: $checkedConvert(
      'eew',
      (v) => EewTelegramBodyEew.fromJson(v as Map<String, dynamic>),
    ),
    eewIntensityRegions: $checkedConvert(
      'eewIntensityRegions',
      (v) => (v as List<dynamic>)
          .map(
            (e) => EewTelegramBodyIntensityRegion.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
    eewWarningZones: $checkedConvert(
      'eewWarningZones',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                EewTelegramBodyWarningArea.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    eewWarningPrefectures: $checkedConvert(
      'eewWarningPrefectures',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                EewTelegramBodyWarningArea.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    eewWarningRegions: $checkedConvert(
      'eewWarningRegions',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                EewTelegramBodyWarningArea.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$EewTelegramBodyToJson(_EewTelegramBody instance) =>
    <String, dynamic>{
      'type': instance.type,
      'eew': instance.eew,
      'eewIntensityRegions': instance.eewIntensityRegions,
      'eewWarningZones': instance.eewWarningZones,
      'eewWarningPrefectures': instance.eewWarningPrefectures,
      'eewWarningRegions': instance.eewWarningRegions,
    };
