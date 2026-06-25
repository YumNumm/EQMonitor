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
      observedAt: $checkedConvert(
        'observed_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      value: $checkedConvert('value', (v) => v as num?),
      isOver: $checkedConvert('is_over', (v) => v as bool?),
      qualitative: $checkedConvert('qualitative', (v) => v as String?),
      isObserving: $checkedConvert('is_observing', (v) => v as bool?),
      revise: $checkedConvert('revise', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'observedAt': 'observed_at',
    'isOver': 'is_over',
    'isObserving': 'is_observing',
  },
);

Map<String, dynamic> _$MaxHeightToJson(_MaxHeight instance) =>
    <String, dynamic>{
      'observed_at': ?instance.observedAt?.toIso8601String(),
      'value': ?instance.value,
      'is_over': ?instance.isOver,
      'qualitative': ?instance.qualitative,
      'is_observing': ?instance.isObserving,
      'revise': ?instance.revise,
    };
