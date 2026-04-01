// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_station_search_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityStationSearchItem _$IntensityStationSearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityStationSearchItem', json, ($checkedConvert) {
  final val = _IntensityStationSearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    station: $checkedConvert(
      'station',
      (v) => IntensityStationInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityStationSearchItemToJson(
  _IntensityStationSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'station': instance.station,
  'earthquake': instance.earthquake,
};
