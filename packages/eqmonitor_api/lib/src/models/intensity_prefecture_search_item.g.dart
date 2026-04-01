// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_prefecture_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityPrefectureSearchItem _$IntensityPrefectureSearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityPrefectureSearchItem', json, ($checkedConvert) {
  final val = _IntensityPrefectureSearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    prefecture: $checkedConvert(
      'prefecture',
      (v) => IntensityRegionInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityPrefectureSearchItemToJson(
  _IntensityPrefectureSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'prefecture': instance.prefecture,
  'earthquake': instance.earthquake,
};
