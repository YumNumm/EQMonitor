// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ntp_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NtpConfigModel _$NtpConfigModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_NtpConfigModel', json, ($checkedConvert) {
      final val = _NtpConfigModel(
        lookUpAddress: $checkedConvert(
          'look_up_address',
          (v) => v as String? ?? 'ntp.nict.jp',
        ),
        timeout: $checkedConvert(
          'timeout',
          (v) => v == null
              ? const Duration(seconds: 10)
              : Duration(microseconds: (v as num).toInt()),
        ),
        interval: $checkedConvert(
          'interval',
          (v) => v == null
              ? const Duration(minutes: 30)
              : Duration(microseconds: (v as num).toInt()),
        ),
      );
      return val;
    }, fieldKeyMap: const {'lookUpAddress': 'look_up_address'});

Map<String, dynamic> _$NtpConfigModelToJson(_NtpConfigModel instance) =>
    <String, dynamic>{
      'look_up_address': instance.lookUpAddress,
      'timeout': instance.timeout.inMicroseconds,
      'interval': instance.interval.inMicroseconds,
    };
