// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'target_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TargetTime _$TargetTimeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TargetTime', json, ($checkedConvert) {
      final val = _TargetTime(
        start: $checkedConvert('start', (v) => v as String),
        end: $checkedConvert('end', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$TargetTimeToJson(_TargetTime instance) =>
    <String, dynamic>{'start': instance.start, 'end': instance.end};
