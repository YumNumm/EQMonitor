// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_region_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityRegionSearchItem _$IntensityRegionSearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityRegionSearchItem', json, ($checkedConvert) {
  final val = _IntensityRegionSearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    region: $checkedConvert(
      'region',
      (v) => IntensityRegionInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityRegionSearchItemToJson(
  _IntensityRegionSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'region': instance.region,
  'earthquake': instance.earthquake,
};
