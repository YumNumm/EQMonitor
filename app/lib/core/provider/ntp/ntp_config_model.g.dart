// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'ntp_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NtpConfigModelImpl _$$NtpConfigModelImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$NtpConfigModelImpl',
      json,
      ($checkedConvert) {
        final val = _$NtpConfigModelImpl(
          lookUpAddress: $checkedConvert(
              'lookUpAddress', (v) => v as String? ?? 'ntp.nict.jp'),
          timeout: $checkedConvert(
              'timeout',
              (v) => v == null
                  ? const Duration(seconds: 10)
                  : Duration(microseconds: (v as num).toInt())),
          interval: $checkedConvert(
              'interval',
              (v) => v == null
                  ? const Duration(minutes: 1)
                  : Duration(microseconds: (v as num).toInt())),
        );
        return val;
      },
    );

Map<String, dynamic> _$$NtpConfigModelImplToJson(
        _$NtpConfigModelImpl instance) =>
    <String, dynamic>{
      'lookUpAddress': instance.lookUpAddress,
      'timeout': instance.timeout.inMicroseconds,
      'interval': instance.interval.inMicroseconds,
    };
