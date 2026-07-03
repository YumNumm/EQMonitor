// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_estimation_first_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionEstimationFirstHeight
_$TsunamiRegionEstimationFirstHeightFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_TsunamiRegionEstimationFirstHeight',
      json,
      ($checkedConvert) {
        final val = _TsunamiRegionEstimationFirstHeight(
          arrivalTime: $checkedConvert(
            'arrival_time',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          isAlreadyArrived: $checkedConvert(
            'is_already_arrived',
            (v) => v as bool?,
          ),
          revise: $checkedConvert(
            'revise',
            (v) => $enumDecodeNullable(_$ReviseEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'arrivalTime': 'arrival_time',
        'isAlreadyArrived': 'is_already_arrived',
      },
    );

Map<String, dynamic> _$TsunamiRegionEstimationFirstHeightToJson(
  _TsunamiRegionEstimationFirstHeight instance,
) => <String, dynamic>{
  'arrival_time': ?instance.arrivalTime?.toIso8601String(),
  'is_already_arrived': ?instance.isAlreadyArrived,
  'revise': ?instance.revise,
};

const _$ReviseEnumMap = {Revise.addition: 'ADDITION', Revise.update: 'UPDATE'};
