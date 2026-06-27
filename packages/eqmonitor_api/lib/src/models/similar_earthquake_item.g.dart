// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'similar_earthquake_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimilarEarthquakeItem _$SimilarEarthquakeItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_SimilarEarthquakeItem',
  json,
  ($checkedConvert) {
    final val = _SimilarEarthquakeItem(
      earthquake: $checkedConvert(
        'earthquake',
        (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
      ),
      score: $checkedConvert('score', (v) => v as num),
      groupedEarthquakes: $checkedConvert(
        'grouped_earthquakes',
        (v) => (v as List<dynamic>)
            .map((e) => EarthquakePartial.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'groupedEarthquakes': 'grouped_earthquakes'},
);

Map<String, dynamic> _$SimilarEarthquakeItemToJson(
  _SimilarEarthquakeItem instance,
) => <String, dynamic>{
  'earthquake': instance.earthquake,
  'score': instance.score,
  'grouped_earthquakes': instance.groupedEarthquakes,
};
