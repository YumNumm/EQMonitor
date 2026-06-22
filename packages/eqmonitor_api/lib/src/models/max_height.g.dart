// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'max_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaxHeight _$MaxHeightFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_MaxHeight',
  json,
  ($checkedConvert) {
    final val = _MaxHeight(
      dateTime: $checkedConvert(
        'date_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      value: $checkedConvert('value', (v) => v as num?),
      isOver: $checkedConvert('is_over', (v) => v),
      qualitative: $checkedConvert(
        'qualitative',
        (v) => v == null
            ? null
            : QualitativeHeight.fromJson(v as Map<String, dynamic>),
      ),
      isObserving: $checkedConvert('is_observing', (v) => v),
      revise: $checkedConvert(
        'revise',
        (v) => v == null ? null : Revise.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'dateTime': 'date_time',
    'isOver': 'is_over',
    'isObserving': 'is_observing',
  },
);

Map<String, dynamic> _$MaxHeightToJson(_MaxHeight instance) =>
    <String, dynamic>{
      'date_time': ?instance.dateTime?.toIso8601String(),
      'value': ?instance.value,
      'is_over': ?instance.isOver,
      'qualitative': ?instance.qualitative,
      'is_observing': ?instance.isObserving,
      'revise': ?instance.revise,
    };
