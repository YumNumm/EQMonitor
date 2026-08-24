// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_location_sync_scope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceLocationSyncScope _$DeviceLocationSyncScopeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceLocationSyncScope', json, ($checkedConvert) {
  final val = _DeviceLocationSyncScope(
    apiEndpoint: $checkedConvert('apiEndpoint', (v) => v as String),
    registrationGeneration: $checkedConvert(
      'registrationGeneration',
      (v) => v as String?,
    ),
  );
  return val;
});

Map<String, dynamic> _$DeviceLocationSyncScopeToJson(
  _DeviceLocationSyncScope instance,
) => <String, dynamic>{
  'apiEndpoint': instance.apiEndpoint,
  'registrationGeneration': instance.registrationGeneration,
};
