// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeInfo _$EarthquakeInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeInfo', json, ($checkedConvert) {
      final val = _EarthquakeInfo(
        text: $checkedConvert('text', (v) => v as String),
        kind: $checkedConvert(
          'kind',
          (v) => v == null ? null : Kind.fromJson(v as Map<String, dynamic>),
        ),
        appendix: $checkedConvert('appendix', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeInfoToJson(_EarthquakeInfo instance) =>
    <String, dynamic>{
      'text': instance.text,
      'kind': ?instance.kind,
      'appendix': ?instance.appendix,
    };
