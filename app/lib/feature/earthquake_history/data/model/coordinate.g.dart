// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'coordinate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinateUnknown _$CoordinateUnknownFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CoordinateUnknown', json, ($checkedConvert) {
      final val = CoordinateUnknown(
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$CoordinateUnknownToJson(CoordinateUnknown instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

CoordinateLatLng _$CoordinateLatLngFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CoordinateLatLng', json, ($checkedConvert) {
      final val = CoordinateLatLng(
        latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
        longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        $type: $checkedConvert('runtimeType', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$CoordinateLatLngToJson(CoordinateLatLng instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'runtimeType': instance.$type,
    };
