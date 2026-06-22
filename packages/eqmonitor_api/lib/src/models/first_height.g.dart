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
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      isAlreadyArrived: $checkedConvert('is_already_arrived', (v) => v),
      revise: $checkedConvert(
        'revise',
        (v) => v == null ? null : Revise.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'arrivalTime': 'arrival_time',
    'isAlreadyArrived': 'is_already_arrived',
  },
);

Map<String, dynamic> _$FirstHeightToJson(_FirstHeight instance) =>
    <String, dynamic>{
      'arrival_time': ?instance.arrivalTime?.toIso8601String(),
      'is_already_arrived': ?instance.isAlreadyArrived,
      'revise': ?instance.revise,
    };
