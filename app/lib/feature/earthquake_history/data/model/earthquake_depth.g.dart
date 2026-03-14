// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_depth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakeDepthShallow _$EarthquakeDepthShallowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EarthquakeDepthShallow', json, ($checkedConvert) {
  final val = EarthquakeDepthShallow(
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$EarthquakeDepthShallowToJson(
  EarthquakeDepthShallow instance,
) => <String, dynamic>{'runtimeType': instance.$type};

EarthquakeDepthValue _$EarthquakeDepthValueFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EarthquakeDepthValue', json, ($checkedConvert) {
  final val = EarthquakeDepthValue(
    value: $checkedConvert('value', (v) => (v as num).toInt()),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$EarthquakeDepthValueToJson(
  EarthquakeDepthValue instance,
) => <String, dynamic>{'value': instance.value, 'runtimeType': instance.$type};

EarthquakeDepthOver700km _$EarthquakeDepthOver700kmFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EarthquakeDepthOver700km', json, ($checkedConvert) {
  final val = EarthquakeDepthOver700km(
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$EarthquakeDepthOver700kmToJson(
  EarthquakeDepthOver700km instance,
) => <String, dynamic>{'runtimeType': instance.$type};

EarthquakeDepthUnknown _$EarthquakeDepthUnknownFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EarthquakeDepthUnknown', json, ($checkedConvert) {
  final val = EarthquakeDepthUnknown(
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {r'$type': 'runtimeType'});

Map<String, dynamic> _$EarthquakeDepthUnknownToJson(
  EarthquakeDepthUnknown instance,
) => <String, dynamic>{'runtimeType': instance.$type};
