// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'maintenance_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MaintenanceMessageImpl _$$MaintenanceMessageImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MaintenanceMessageImpl',
      json,
      ($checkedConvert) {
        final val = _$MaintenanceMessageImpl(
          message: $checkedConvert('message', (v) => v as String?),
          security: $checkedConvert(
              'security',
              (v) => v == null
                  ? null
                  : Security.fromJson(v as Map<String, dynamic>)),
          type: $checkedConvert('type',
              (v) => $enumDecodeNullable(_$MaintenanceMessageTypeEnumMap, v)),
          requestTime: $checkedConvert(
              'request_time', (v) => DateTime.parse(v as String)),
          result: $checkedConvert(
              'result',
              (v) => v == null
                  ? null
                  : Result.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'requestTime': 'request_time'},
    );

Map<String, dynamic> _$$MaintenanceMessageImplToJson(
        _$MaintenanceMessageImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'security': instance.security,
      'type': _$MaintenanceMessageTypeEnumMap[instance.type],
      'request_time': instance.requestTime.toIso8601String(),
      'result': instance.result,
    };

const _$MaintenanceMessageTypeEnumMap = {
  MaintenanceMessageType.non: '0',
  MaintenanceMessageType.small: '1',
  MaintenanceMessageType.highLight: '2',
};
