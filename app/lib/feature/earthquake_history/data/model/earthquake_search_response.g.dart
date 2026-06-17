// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedSearchResponse<T> _$PaginatedSearchResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate('_PaginatedSearchResponse', json, ($checkedConvert) {
  final val = _PaginatedSearchResponse<T>(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>).map(fromJsonT).toList(),
    ),
    nextToken: $checkedConvert('next_token', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'nextToken': 'next_token'});

Map<String, dynamic> _$PaginatedSearchResponseToJson<T>(
  _PaginatedSearchResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'next_token': instance.nextToken,
};

_IntensityAreaSearchItem _$IntensityAreaSearchItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityAreaSearchItem', json, ($checkedConvert) {
  final val = _IntensityAreaSearchItem(
    eventId: $checkedConvert('event_id', (v) => v as String),
    area: $checkedConvert(
      'area',
      (v) => IntensityAreaInfo.fromJson(v as Map<String, dynamic>),
    ),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$IntensityAreaSearchItemToJson(
  _IntensityAreaSearchItem instance,
) => <String, dynamic>{
  'event_id': instance.eventId,
  'area': instance.area,
  'earthquake': instance.earthquake,
};

_StationSearchItem _$StationSearchItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StationSearchItem', json, ($checkedConvert) {
      final val = _StationSearchItem(
        eventId: $checkedConvert('event_id', (v) => v as String),
        station: $checkedConvert(
          'station',
          (v) => StationSearchInfo.fromJson(v as Map<String, dynamic>),
        ),
        earthquake: $checkedConvert(
          'earthquake',
          (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'eventId': 'event_id'});

Map<String, dynamic> _$StationSearchItemToJson(_StationSearchItem instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'station': instance.station,
      'earthquake': instance.earthquake,
    };
