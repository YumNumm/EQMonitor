// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_colors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapColors _$MapColorsFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_MapColors',
  json,
  ($checkedConvert) {
    final val = _MapColors(
      background: $checkedConvert(
        'background',
        (v) => const ColorJsonConverter().fromJson(v as String),
      ),
      worldLand: $checkedConvert(
        'world_land',
        (v) => const ColorJsonConverter().fromJson(v as String),
      ),
      worldLine: $checkedConvert(
        'world_line',
        (v) => const ColorJsonConverter().fromJson(v as String),
      ),
      japanLand: $checkedConvert(
        'japan_land',
        (v) => const ColorJsonConverter().fromJson(v as String),
      ),
      japanLine: $checkedConvert(
        'japan_line',
        (v) => const ColorJsonConverter().fromJson(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'worldLand': 'world_land',
    'worldLine': 'world_line',
    'japanLand': 'japan_land',
    'japanLine': 'japan_line',
  },
);

Map<String, dynamic> _$MapColorsToJson(_MapColors instance) =>
    <String, dynamic>{
      'background': const ColorJsonConverter().toJson(instance.background),
      'world_land': const ColorJsonConverter().toJson(instance.worldLand),
      'world_line': const ColorJsonConverter().toJson(instance.worldLine),
      'japan_land': const ColorJsonConverter().toJson(instance.japanLand),
      'japan_line': const ColorJsonConverter().toJson(instance.japanLine),
    };
