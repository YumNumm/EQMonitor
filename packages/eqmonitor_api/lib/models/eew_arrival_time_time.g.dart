// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_arrival_time_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewArrivalTimeTime _$EewArrivalTimeTimeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EewArrivalTimeTime', json, ($checkedConvert) {
      final val = _EewArrivalTimeTime(
        type: $checkedConvert('type', (v) => v),
        value: $checkedConvert('value', (v) => DateTime.parse(v as String)),
      );
      return val;
    });

Map<String, dynamic> _$EewArrivalTimeTimeToJson(_EewArrivalTimeTime instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value.toIso8601String(),
    };
