// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'lat_lng.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LatLng _$LatLngFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LatLng', json, ($checkedConvert) {
      final val = _LatLng(
        latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
        longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$LatLngToJson(_LatLng instance) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
