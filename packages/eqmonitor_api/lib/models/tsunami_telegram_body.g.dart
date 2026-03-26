// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_telegram_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiTelegramBody _$TsunamiTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiTelegramBody', json, ($checkedConvert) {
  final val = _TsunamiTelegramBody(
    forecasts: $checkedConvert(
      'forecasts',
      (v) => (v as List<dynamic>?)
          ?.map((e) => TsunamiForecast.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    observations: $checkedConvert(
      'observations',
      (v) => (v as List<dynamic>?)
          ?.map((e) => TsunamiObservation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    estimations: $checkedConvert(
      'estimations',
      (v) => (v as List<dynamic>?)
          ?.map((e) => TsunamiEstimation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    earthquakes: $checkedConvert(
      'earthquakes',
      (v) => (v as List<dynamic>?)
          ?.map((e) => TsunamiEarthquake.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    text: $checkedConvert('text', (v) => v as String?),
    comments: $checkedConvert(
      'comments',
      (v) => v == null
          ? null
          : TsunamiComments.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiTelegramBodyToJson(
  _TsunamiTelegramBody instance,
) => <String, dynamic>{
  'forecasts': ?instance.forecasts,
  'observations': ?instance.observations,
  'estimations': ?instance.estimations,
  'earthquakes': ?instance.earthquakes,
  'text': ?instance.text,
  'comments': ?instance.comments,
};
