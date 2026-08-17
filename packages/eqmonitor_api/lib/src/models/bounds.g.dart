// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'bounds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bounds _$BoundsFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Bounds',
  json,
  ($checkedConvert) {
    final val = _Bounds(
      minLongitude: $checkedConvert('min_longitude', (v) => v as num),
      minLatitude: $checkedConvert('min_latitude', (v) => v as num),
      maxLongitude: $checkedConvert('max_longitude', (v) => v as num),
      maxLatitude: $checkedConvert('max_latitude', (v) => v as num),
    );
    return val;
  },
  fieldKeyMap: const {
    'minLongitude': 'min_longitude',
    'minLatitude': 'min_latitude',
    'maxLongitude': 'max_longitude',
    'maxLatitude': 'max_latitude',
  },
);

Map<String, dynamic> _$BoundsToJson(_Bounds instance) => <String, dynamic>{
  'min_longitude': instance.minLongitude,
  'min_latitude': instance.minLatitude,
  'max_longitude': instance.maxLongitude,
  'max_latitude': instance.maxLatitude,
};
