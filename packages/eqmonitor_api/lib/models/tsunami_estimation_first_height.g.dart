// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_estimation_first_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiEstimationFirstHeight _$TsunamiEstimationFirstHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiEstimationFirstHeight',
  json,
  ($checkedConvert) {
    final val = _TsunamiEstimationFirstHeight(
      isAlreadyArrived: $checkedConvert('is_already_arrived', (v) => v as bool),
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'isAlreadyArrived': 'is_already_arrived',
    'arrivalTime': 'arrival_time',
  },
);

Map<String, dynamic> _$TsunamiEstimationFirstHeightToJson(
  _TsunamiEstimationFirstHeight instance,
) => <String, dynamic>{
  'is_already_arrived': instance.isAlreadyArrived,
  'arrival_time': ?instance.arrivalTime?.toIso8601String(),
};
