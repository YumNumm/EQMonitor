// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'real_time_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RealTimeData _$RealTimeDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_RealTimeData',
      json,
      ($checkedConvert) {
        final val = _RealTimeData(
          dateTime: $checkedConvert(
            'date_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          packetType: $checkedConvert('packet_type', (v) => v as String?),
          kyoshinType: $checkedConvert('kyoshin_type', (v) => v as String?),
          baseData: $checkedConvert('base_data', (v) => v as String?),
          baseSerialNo: $checkedConvert('base_serial_no', (v) => v as String?),
          items: $checkedConvert(
            'items',
            (v) => (v as List<dynamic>?)
                ?.map((e) => (e as num?)?.toDouble())
                .toList(),
          ),
          result: $checkedConvert(
            'result',
            (v) =>
                v == null ? null : Result.fromJson(v as Map<String, dynamic>),
          ),
          security: $checkedConvert(
            'security',
            (v) =>
                v == null ? null : Security.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'dateTime': 'date_time',
        'packetType': 'packet_type',
        'kyoshinType': 'kyoshin_type',
        'baseData': 'base_data',
        'baseSerialNo': 'base_serial_no',
      },
    );

Map<String, dynamic> _$RealTimeDataToJson(_RealTimeData instance) =>
    <String, dynamic>{
      'date_time': instance.dateTime?.toIso8601String(),
      'packet_type': instance.packetType,
      'kyoshin_type': instance.kyoshinType,
      'base_data': instance.baseData,
      'base_serial_no': instance.baseSerialNo,
      'items': instance.items,
      'result': instance.result,
      'security': instance.security,
    };
