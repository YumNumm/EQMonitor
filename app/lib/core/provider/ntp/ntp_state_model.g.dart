// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'ntp_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NtpStateModel _$NtpStateModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_NtpStateModel', json, ($checkedConvert) {
      final val = _NtpStateModel(
        offset: $checkedConvert('offset', (v) => (v as num?)?.toInt()),
        updatedAt: $checkedConvert(
          'updated_at',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    }, fieldKeyMap: const {'updatedAt': 'updated_at'});

Map<String, dynamic> _$NtpStateModelToJson(_NtpStateModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
