// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'accuracy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EewAccuracyImpl _$$EewAccuracyImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EewAccuracyImpl',
      json,
      ($checkedConvert) {
        final val = _$EewAccuracyImpl(
          epicenters: $checkedConvert('epicenters',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          depth: $checkedConvert('depth', (v) => v as String),
          magnitudeCalculation:
              $checkedConvert('magnitude_calculation', (v) => v as String),
          numberOfMagnitudeCalculation: $checkedConvert(
              'number_of_magnitude_calculation', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'magnitudeCalculation': 'magnitude_calculation',
        'numberOfMagnitudeCalculation': 'number_of_magnitude_calculation'
      },
    );

Map<String, dynamic> _$$EewAccuracyImplToJson(_$EewAccuracyImpl instance) =>
    <String, dynamic>{
      'epicenters': instance.epicenters,
      'depth': instance.depth,
      'magnitude_calculation': instance.magnitudeCalculation,
      'number_of_magnitude_calculation': instance.numberOfMagnitudeCalculation,
    };
