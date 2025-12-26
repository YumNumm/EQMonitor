// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew_warning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewWarningZoneItem _$EewWarningZoneItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewWarningZoneItem', json, ($checkedConvert) {
      final val = _EewWarningZoneItem(
        value: $checkedConvert(
          'value',
          (v) => CodeName.fromJson(v as Map<String, dynamic>),
        ),
        hadWarning: $checkedConvert('had_warning', (v) => v as bool),
      );
      return val;
    }, fieldKeyMap: const {'hadWarning': 'had_warning'});

Map<String, dynamic> _$EewWarningZoneItemToJson(_EewWarningZoneItem instance) =>
    <String, dynamic>{
      'value': instance.value,
      'had_warning': instance.hadWarning,
    };

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
