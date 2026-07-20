// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ws_shake_observation_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WsShakeObservationPoint _$WsShakeObservationPointFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsShakeObservationPoint', json, ($checkedConvert) {
  final val = _WsShakeObservationPoint(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    region: $checkedConvert('region', (v) => v as String),
    type: $checkedConvert('type', (v) => v as String),
    location: $checkedConvert(
      'location',
      (v) => WsShakeObservationLocation.fromJson(v as Map<String, dynamic>),
    ),
    intensityDiff: $checkedConvert(
      'intensityDiff',
      (v) => (v as num?)?.toDouble() ?? 0,
      readValue: wsShakeIntensityDiffReadValue,
    ),
    intensity: $checkedConvert('intensity', (v) => (v as num?)?.toDouble()),
  );
  return val;
});

Map<String, dynamic> _$WsShakeObservationPointToJson(
  _WsShakeObservationPoint instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'region': instance.region,
  'type': instance.type,
  'location': instance.location,
  'intensityDiff': instance.intensityDiff,
  'intensity': instance.intensity,
};

_WsShakeObservationLocation _$WsShakeObservationLocationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_WsShakeObservationLocation', json, ($checkedConvert) {
  final val = _WsShakeObservationLocation(
    latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
    longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
  );
  return val;
});

Map<String, dynamic> _$WsShakeObservationLocationToJson(
  _WsShakeObservationLocation instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
