// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_city_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityCitySearchItem _$IntensityCitySearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityCitySearchItem', json, ($checkedConvert) {
  final val = _IntensityCitySearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    city: $checkedConvert(
      'city',
      (v) => IntensityRegionInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityCitySearchItemToJson(
  _IntensityCitySearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'city': instance.city,
  'earthquake': instance.earthquake,
};
