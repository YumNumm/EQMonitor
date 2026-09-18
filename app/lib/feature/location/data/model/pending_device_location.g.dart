// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'pending_device_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendingDeviceLocation _$PendingDeviceLocationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_PendingDeviceLocation',
  json,
  ($checkedConvert) {
    final val = _PendingDeviceLocation(
      updateId: $checkedConvert('update_id', (v) => v as String),
      latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
      longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
      accuracy: $checkedConvert('accuracy', (v) => (v as num).toDouble()),
      timestampMillis: $checkedConvert(
        'timestamp_millis',
        (v) => (v as num).toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'updateId': 'update_id',
    'timestampMillis': 'timestamp_millis',
  },
);

Map<String, dynamic> _$PendingDeviceLocationToJson(
  _PendingDeviceLocation instance,
) => <String, dynamic>{
  'update_id': instance.updateId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'accuracy': instance.accuracy,
  'timestamp_millis': instance.timestampMillis,
};
