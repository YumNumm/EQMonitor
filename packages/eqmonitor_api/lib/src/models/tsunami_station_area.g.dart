// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_station_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationArea _$TsunamiStationAreaFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiStationArea', json, ($checkedConvert) {
      final val = _TsunamiStationArea(
        name: $checkedConvert(
          'name',
          (v) => v == null
              ? null
              : LocalizedName.fromJson(v as Map<String, dynamic>),
        ),
        stations: $checkedConvert(
          'stations',
          (v) => (v as List<dynamic>)
              .map((e) => TsunamiStation.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$TsunamiStationAreaToJson(_TsunamiStationArea instance) =>
    <String, dynamic>{'name': instance.name, 'stations': instance.stations};
