// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

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
              'look_up_address', (v) => v as String? ?? 'ntp.nict.jp'),
          timeout: $checkedConvert(
              'timeout',
              (v) => v == null
                  ? const Duration(seconds: 10)
                  : Duration(microseconds: (v as num).toInt())),
          interval: $checkedConvert(
              'interval',
              (v) => v == null
                  ? const Duration(minutes: 30)
                  : Duration(microseconds: (v as num).toInt())),
        );
        return val;
      },
      fieldKeyMap: const {'lookUpAddress': 'look_up_address'},
    );

Map<String, dynamic> _$$NtpConfigModelImplToJson(
        _$NtpConfigModelImpl instance) =>
    <String, dynamic>{
      'look_up_address': instance.lookUpAddress,
      'timeout': instance.timeout.inMicroseconds,
      'interval': instance.interval.inMicroseconds,
    };
