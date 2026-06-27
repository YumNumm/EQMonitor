// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'first_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FirstHeight _$FirstHeightFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_FirstHeight',
  json,
  ($checkedConvert) {
    final val = _FirstHeight(
      isAlreadyArrived: $checkedConvert('is_already_arrived', (v) => v as bool),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      revise: $checkedConvert(
        'revise',
        (v) => $enumDecodeNullable(_$ReviseEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'isAlreadyArrived': 'is_already_arrived',
    'arrivalTime': 'arrival_time',
  },
);

Map<String, dynamic> _$FirstHeightToJson(_FirstHeight instance) =>
    <String, dynamic>{
      'is_already_arrived': instance.isAlreadyArrived,
      'arrival_time': ?instance.arrivalTime?.toIso8601String(),
      'revise': ?instance.revise,
    };

const _$ReviseEnumMap = {Revise.addition: 'ADDITION', Revise.update: 'UPDATE'};
