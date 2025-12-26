// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'coordinate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinateLatLng _$CoordinateLatLngFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CoordinateLatLng', json, ($checkedConvert) {
      final val = CoordinateLatLng(
        latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
        longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$CoordinateLatLngToJson(CoordinateLatLng instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'type': instance.$type,
    };

CoordinateUnknown _$CoordinateUnknownFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CoordinateUnknown', json, ($checkedConvert) {
      final val = CoordinateUnknown(
        condition: $checkedConvert('condition', (v) => v as String),
        $type: $checkedConvert('type', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {r'$type': 'type'});

Map<String, dynamic> _$CoordinateUnknownToJson(CoordinateUnknown instance) =>
    <String, dynamic>{'condition': instance.condition, 'type': instance.$type};
