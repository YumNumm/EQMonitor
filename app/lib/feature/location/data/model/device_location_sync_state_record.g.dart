// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_sync_state_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceLocationSyncStateRecord _$DeviceLocationSyncStateRecordFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceLocationSyncStateRecord', json, ($checkedConvert) {
  final val = _DeviceLocationSyncStateRecord(
    scope: $checkedConvert(
      'scope',
      (v) => DeviceLocationSyncScope.fromJson(v as Map<String, dynamic>),
    ),
    payload: $checkedConvert(
      'payload',
      (v) => DeviceLocationPayload.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$DeviceLocationSyncStateRecordToJson(
  _DeviceLocationSyncStateRecord instance,
) => <String, dynamic>{
  'scope': instance.scope.toJson(),
  'payload': instance.payload.toJson(),
};
