// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'maintenance_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaintenanceInfo _$MaintenanceInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MaintenanceInfo', json, ($checkedConvert) {
      final val = _MaintenanceInfo(
        enabled: $checkedConvert('enabled', (v) => v as bool),
        message: $checkedConvert('message', (v) => v as String?),
        url: $checkedConvert('url', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$MaintenanceInfoToJson(_MaintenanceInfo instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'message': ?instance.message,
      'url': ?instance.url,
    };
