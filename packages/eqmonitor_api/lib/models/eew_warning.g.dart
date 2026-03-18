// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewWarning _$EewWarningFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_EewWarning',
  json,
  ($checkedConvert) {
    final val = _EewWarning(
      zones: $checkedConvert(
        'zones',
        (v) => (v as List<dynamic>)
            .map((e) => EewWarningZoneItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      prefectures: $checkedConvert(
        'prefectures',
        (v) => (v as List<dynamic>)
            .map((e) => EewWarningZoneItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      regions: $checkedConvert(
        'regions',
        (v) => (v as List<dynamic>)
            .map((e) => EewWarningZoneItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$EewWarningToJson(_EewWarning instance) =>
    <String, dynamic>{
      'zones': instance.zones,
      'prefectures': instance.prefectures,
      'regions': instance.regions,
    };
