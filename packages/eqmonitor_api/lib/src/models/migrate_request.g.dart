// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'migrate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MigrateRequest _$MigrateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MigrateRequest', json, ($checkedConvert) {
      final val = _MigrateRequest(
        oldDeviceId: $checkedConvert('old_device_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'oldDeviceId': 'old_device_id'});

Map<String, dynamic> _$MigrateRequestToJson(_MigrateRequest instance) =>
    <String, dynamic>{'old_device_id': instance.oldDeviceId};
