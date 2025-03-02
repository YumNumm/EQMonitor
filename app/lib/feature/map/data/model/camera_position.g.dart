// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'camera_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapCameraPositionImpl _$$MapCameraPositionImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$MapCameraPositionImpl', json, ($checkedConvert) {
  final val = _$MapCameraPositionImpl(
    target: $checkedConvert(
      'target',
      (v) => LatLng.fromJson(v as Map<String, dynamic>),
    ),
    zoom: $checkedConvert('zoom', (v) => (v as num?)?.toDouble() ?? 5.0),
    tilt: $checkedConvert('tilt', (v) => (v as num?)?.toDouble() ?? 0.0),
    bearing: $checkedConvert('bearing', (v) => (v as num?)?.toDouble() ?? 0.0),
  );
  return val;
});

Map<String, dynamic> _$$MapCameraPositionImplToJson(
  _$MapCameraPositionImpl instance,
) => <String, dynamic>{
  'target': instance.target,
  'zoom': instance.zoom,
  'tilt': instance.tilt,
  'bearing': instance.bearing,
};
