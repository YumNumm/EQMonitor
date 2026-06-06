// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_explanation_telegram_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeExplanationTelegramBody _$EarthquakeExplanationTelegramBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeExplanationTelegramBody', json, (
  $checkedConvert,
) {
  final val = _EarthquakeExplanationTelegramBody(
    type: $checkedConvert('type', (v) => v),
    text: $checkedConvert('text', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeExplanationTelegramBodyToJson(
  _EarthquakeExplanationTelegramBody instance,
) => <String, dynamic>{'type': instance.type, 'text': instance.text};
