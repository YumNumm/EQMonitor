// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew_accuracy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewAccuracy _$EewAccuracyFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_EewAccuracy',
  json,
  ($checkedConvert) {
    final val = _EewAccuracy(
      epicenters: $checkedConvert(
        'epicenters',
        (v) => (v as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      ),
      depth: $checkedConvert('depth', (v) => (v as num).toInt()),
      magnitudeCalculation: $checkedConvert(
        'magnitude_calculation',
        (v) => (v as num).toInt(),
      ),
      numberOfMagnitudeCalculation: $checkedConvert(
        'number_of_magnitude_calculation',
        (v) => (v as num).toInt(),
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
      'epicenters': instance.epicenters,
      'depth': instance.depth,
      'magnitude_calculation': instance.magnitudeCalculation,
      'number_of_magnitude_calculation': instance.numberOfMagnitudeCalculation,
    };
