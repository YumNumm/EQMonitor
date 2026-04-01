// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Region _$RegionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Region', json, ($checkedConvert) {
      final val = _Region(
        topLeft: $checkedConvert(
          'topLeft',
          (v) => TopLeft.fromJson(v as Map<String, dynamic>),
        ),
        bottomRight: $checkedConvert(
          'bottomRight',
          (v) => BottomRight.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RegionToJson(_Region instance) => <String, dynamic>{
  'topLeft': instance.topLeft,
  'bottomRight': instance.bottomRight,
};
