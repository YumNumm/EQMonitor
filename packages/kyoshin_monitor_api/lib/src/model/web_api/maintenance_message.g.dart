// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'maintenance_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaintenanceMessage _$MaintenanceMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MaintenanceMessage', json, ($checkedConvert) {
      final val = _MaintenanceMessage(
        message: $checkedConvert('message', (v) => v as String?),
        security: $checkedConvert(
          'security',
          (v) =>
              v == null ? null : Security.fromJson(v as Map<String, dynamic>),
        ),
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$MaintenanceMessageTypeEnumMap, v),
        ),
        requestTime: $checkedConvert(
          'request_time',
          (v) => dateTimeFromString(v as String),
        ),
        result: $checkedConvert(
          'result',
          (v) => v == null ? null : Result.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'requestTime': 'request_time'});

Map<String, dynamic> _$MaintenanceMessageToJson(_MaintenanceMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'security': instance.security,
      'type': _$MaintenanceMessageTypeEnumMap[instance.type],
      'request_time': dateTimeToString(instance.requestTime),
      'result': instance.result,
    };

const _$MaintenanceMessageTypeEnumMap = {
  MaintenanceMessageType.non: '0',
  MaintenanceMessageType.small: '1',
  MaintenanceMessageType.highLight: '2',
};
