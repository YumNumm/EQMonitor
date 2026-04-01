// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'bottom_right.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BottomRight _$BottomRightFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BottomRight', json, ($checkedConvert) {
      final val = _BottomRight(
        latitude: $checkedConvert('latitude', (v) => v as num),
        longitude: $checkedConvert('longitude', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$BottomRightToJson(_BottomRight instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
