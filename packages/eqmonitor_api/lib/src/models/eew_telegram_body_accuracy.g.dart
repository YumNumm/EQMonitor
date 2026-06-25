// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_telegram_body_accuracy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewTelegramBodyAccuracy _$EewTelegramBodyAccuracyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewTelegramBodyAccuracy', json, ($checkedConvert) {
  final val = _EewTelegramBodyAccuracy(
    epicenters: $checkedConvert(
      'epicenters',
      (v) => (v as List<dynamic>).map((e) => e as num).toList(),
    ),
    depth: $checkedConvert('depth', (v) => v as num),
    magnitudeCalculation: $checkedConvert(
      'magnitudeCalculation',
      (v) => v as num,
    ),
    numberOfMagnitudeCalculation: $checkedConvert(
      'numberOfMagnitudeCalculation',
      (v) => v as num,
    ),
  );
  return val;
});

Map<String, dynamic> _$EewTelegramBodyAccuracyToJson(
  _EewTelegramBodyAccuracy instance,
) => <String, dynamic>{
  'epicenters': instance.epicenters,
  'depth': instance.depth,
  'magnitudeCalculation': instance.magnitudeCalculation,
  'numberOfMagnitudeCalculation': instance.numberOfMagnitudeCalculation,
};
