// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_color_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityColorEntry _$IntensityColorEntryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_IntensityColorEntry', json, ($checkedConvert) {
      final val = _IntensityColorEntry(
        background: $checkedConvert(
          'background',
          (v) => const ColorJsonConverter().fromJson(v as String),
        ),
        foreground: $checkedConvert(
          'foreground',
          (v) => IntensityTextColor.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$IntensityColorEntryToJson(
  _IntensityColorEntry instance,
) => <String, dynamic>{
  'background': const ColorJsonConverter().toJson(instance.background),
  'foreground': instance.foreground,
};
