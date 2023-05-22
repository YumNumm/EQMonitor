// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accuracy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EewAccuracy _$$_EewAccuracyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EewAccuracy',
      json,
      ($checkedConvert) {
        final val = _$_EewAccuracy(
          epicenters: $checkedConvert('epicenters',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          depth: $checkedConvert('depth', (v) => v as String),
          magnitudeCalculation:
              $checkedConvert('magnitudeCalculation', (v) => v as String),
          numberOfMagnitudeCalculation: $checkedConvert(
              'numberOfMagnitudeCalculation', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EewAccuracyToJson(_$_EewAccuracy instance) =>
    <String, dynamic>{
      'epicenters': instance.epicenters,
      'depth': instance.depth,
      'magnitudeCalculation': instance.magnitudeCalculation,
      'numberOfMagnitudeCalculation': instance.numberOfMagnitudeCalculation,
    };
