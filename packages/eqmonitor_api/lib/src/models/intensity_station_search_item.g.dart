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
    intensity: $checkedConvert(
      'intensity',
      (v) => $enumDecode(_$JmaIntensityEnumMap, v),
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
  'intensity': instance.intensity,
  'earthquake': instance.earthquake,
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.value0: '0',
  JmaIntensity.value1: '1',
  JmaIntensity.value2: '2',
  JmaIntensity.value3: '3',
  JmaIntensity.value4: '4',
  JmaIntensity.value5unknown: '!5-',
  JmaIntensity.value5minus: '5-',
  JmaIntensity.value5plus: '5+',
  JmaIntensity.undefined1: '!6-',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: '7',
};
