// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_station_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityStationItem _$IntensityStationItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_IntensityStationItem', json, ($checkedConvert) {
  final val = _IntensityStationItem(
    code: $checkedConvert('code', (v) => v as String),
    sva: $checkedConvert('sva', (v) => v as num?),
    prePeriods: $checkedConvert(
      'pre_periods',
      (v) => (v as List<dynamic>?)
          ?.map((e) => PrePeriods.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
}, fieldKeyMap: const {'prePeriods': 'pre_periods'});

Map<String, dynamic> _$IntensityStationItemToJson(
  _IntensityStationItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'sva': ?instance.sva,
  'pre_periods': ?instance.prePeriods,
};
