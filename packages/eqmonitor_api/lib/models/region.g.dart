// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Region _$RegionFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Region',
  json,
  ($checkedConvert) {
    final val = _Region(
      topLeft: $checkedConvert(
        'top_left',
        (v) => TopLeft.fromJson(v as Map<String, dynamic>),
      ),
      bottomRight: $checkedConvert(
        'bottom_right',
        (v) => BottomRight.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'topLeft': 'top_left', 'bottomRight': 'bottom_right'},
);

Map<String, dynamic> _$RegionToJson(_Region instance) => <String, dynamic>{
  'top_left': instance.topLeft,
  'bottom_right': instance.bottomRight,
};
