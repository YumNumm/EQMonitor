// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ntp_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NtpState _$NtpStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_NtpState', json, ($checkedConvert) {
      final val = _NtpState(
        offset: $checkedConvert(
          'offset',
          (v) => Duration(microseconds: (v as num).toInt()),
        ),
        updatedAt: $checkedConvert(
          'updated_at',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    }, fieldKeyMap: const {'updatedAt': 'updated_at'});

Map<String, dynamic> _$NtpStateToJson(_NtpState instance) => <String, dynamic>{
  'offset': instance.offset.inMicroseconds,
  'updated_at': instance.updatedAt.toIso8601String(),
};
