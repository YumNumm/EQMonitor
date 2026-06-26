// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_earthquake_count_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEarthquakeCountValues _$FeedEarthquakeCountValuesFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedEarthquakeCountValues', json, ($checkedConvert) {
  final val = _FeedEarthquakeCountValues(
    all: $checkedConvert('all', (v) => v as String?),
    felt: $checkedConvert('felt', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$FeedEarthquakeCountValuesToJson(
  _FeedEarthquakeCountValues instance,
) => <String, dynamic>{'all': instance.all, 'felt': instance.felt};
