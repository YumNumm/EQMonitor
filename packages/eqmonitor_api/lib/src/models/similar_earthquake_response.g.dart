// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'similar_earthquake_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimilarEarthquakeResponse _$SimilarEarthquakeResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SimilarEarthquakeResponse', json, ($checkedConvert) {
  final val = _SimilarEarthquakeResponse(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => SimilarEarthquakeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$SimilarEarthquakeResponseToJson(
  _SimilarEarthquakeResponse instance,
) => <String, dynamic>{'items': instance.items};
