// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'data_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataTimeImpl _$$DataTimeImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$DataTimeImpl',
      json,
      ($checkedConvert) {
        final val = _$DataTimeImpl(
          security: $checkedConvert(
              'security',
              (v) => v == null
                  ? null
                  : Security.fromJson(v as Map<String, dynamic>)),
          result: $checkedConvert(
              'result',
              (v) => v == null
                  ? null
                  : Result.fromJson(v as Map<String, dynamic>)),
          latestTime: $checkedConvert(
              'latest_time', (v) => DateTime.parse(v as String)),
          requestTime: $checkedConvert(
              'request_time', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'latestTime': 'latest_time',
        'requestTime': 'request_time'
      },
    );

Map<String, dynamic> _$$DataTimeImplToJson(_$DataTimeImpl instance) =>
    <String, dynamic>{
      'security': instance.security,
      'result': instance.result,
      'latest_time': instance.latestTime.toIso8601String(),
      'request_time': instance.requestTime.toIso8601String(),
    };
