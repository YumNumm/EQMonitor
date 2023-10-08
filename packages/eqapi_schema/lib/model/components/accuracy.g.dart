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
              $checkedConvert('magnitudeCalculation', (v) => v as String),
          numberOfMagnitudeCalculation: $checkedConvert(
              'numberOfMagnitudeCalculation', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EewAccuracyImplToJson(_$EewAccuracyImpl instance) =>
    <String, dynamic>{
      'epicenters': instance.epicenters,
      'depth': instance.depth,
      'magnitudeCalculation': instance.magnitudeCalculation,
      'numberOfMagnitudeCalculation': instance.numberOfMagnitudeCalculation,
    };
