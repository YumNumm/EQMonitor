// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_accuracy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewAccuracy _$EewAccuracyFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_EewAccuracy',
  json,
  ($checkedConvert) {
    final val = _EewAccuracy(
      epicenter: $checkedConvert('epicenter', (v) => v as num),
      hypocenter: $checkedConvert('hypocenter', (v) => v as num),
      depth: $checkedConvert('depth', (v) => v as num),
      magnitudeCalculation: $checkedConvert(
        'magnitude_calculation',
        (v) => v as num,
      ),
      numberOfMagnitudeCalculation: $checkedConvert(
        'number_of_magnitude_calculation',
        (v) => v as num,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'magnitudeCalculation': 'magnitude_calculation',
    'numberOfMagnitudeCalculation': 'number_of_magnitude_calculation',
  },
);

Map<String, dynamic> _$EewAccuracyToJson(_EewAccuracy instance) =>
    <String, dynamic>{
      'epicenter': instance.epicenter,
      'hypocenter': instance.hypocenter,
      'depth': instance.depth,
      'magnitude_calculation': instance.magnitudeCalculation,
      'number_of_magnitude_calculation': instance.numberOfMagnitudeCalculation,
    };
