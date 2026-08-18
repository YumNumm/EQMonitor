// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ntp_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NtpConfigModel _$NtpConfigModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_NtpConfigModel',
      json,
      ($checkedConvert) {
        final val = _NtpConfigModel(
          lookUpAddress: $checkedConvert(
            'look_up_address',
            (v) => v as String? ?? 'ntp.nict.jp',
          ),
          fallbackAddresses: $checkedConvert(
            'fallback_addresses',
            (v) =>
                (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                const ['time.google.com', 'time.cloudflare.com'],
          ),
          timeout: $checkedConvert(
            'timeout',
            (v) => v == null
                ? const Duration(seconds: 3)
                : Duration(microseconds: (v as num).toInt()),
          ),
          interval: $checkedConvert(
            'interval',
            (v) => v == null
                ? const Duration(minutes: 10)
                : Duration(microseconds: (v as num).toInt()),
          ),
          maxAttemptsPerAddress: $checkedConvert(
            'max_attempts_per_address',
            (v) => (v as num?)?.toInt() ?? 2,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'lookUpAddress': 'look_up_address',
        'fallbackAddresses': 'fallback_addresses',
        'maxAttemptsPerAddress': 'max_attempts_per_address',
      },
    );

Map<String, dynamic> _$NtpConfigModelToJson(_NtpConfigModel instance) =>
    <String, dynamic>{
      'look_up_address': instance.lookUpAddress,
      'fallback_addresses': instance.fallbackAddresses,
      'timeout': instance.timeout.inMicroseconds,
      'interval': instance.interval.inMicroseconds,
      'max_attempts_per_address': instance.maxAttemptsPerAddress,
    };
