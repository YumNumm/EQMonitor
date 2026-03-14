// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_magnitude.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakeMagnitudeValue _$EarthquakeMagnitudeValueFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EarthquakeMagnitudeValue', json, ($checkedConvert) {
  final val = EarthquakeMagnitudeValue(
    value: $checkedConvert('value', (v) => (v as num).toDouble()),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$EarthquakeMagnitudeValueToJson(
  EarthquakeMagnitudeValue instance,
) => <String, dynamic>{'value': instance.value, 'runtimeType': instance.$type};

EarthquakeMagnitudeUnknown _$EarthquakeMagnitudeUnknownFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EarthquakeMagnitudeUnknown', json, ($checkedConvert) {
  final val = EarthquakeMagnitudeUnknown(
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$EarthquakeMagnitudeUnknownToJson(
  EarthquakeMagnitudeUnknown instance,
) => <String, dynamic>{'runtimeType': instance.$type};

EarthquakeMagnitudeOverM8 _$EarthquakeMagnitudeOverM8FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EarthquakeMagnitudeOverM8', json, ($checkedConvert) {
  final val = EarthquakeMagnitudeOverM8(
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$EarthquakeMagnitudeOverM8ToJson(
  EarthquakeMagnitudeOverM8 instance,
) => <String, dynamic>{'runtimeType': instance.$type};
