// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegion _$TsunamiRegionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_TsunamiRegion', json, ($checkedConvert) {
      final val = _TsunamiRegion(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        kind: $checkedConvert(
          'kind',
          (v) => TsunamiWarningKind.fromJson(v as Map<String, dynamic>),
        ),
        lastKind: $checkedConvert(
          'last_kind',
          (v) => TsunamiWarningKind.fromJson(v as Map<String, dynamic>),
        ),
        stations: $checkedConvert(
          'stations',
          (v) => (v as List<dynamic>)
              .map(
                (e) => TsunamiRegionStation.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        forecast: $checkedConvert(
          'forecast',
          (v) => v == null
              ? null
              : TsunamiRegionForecast.fromJson(v as Map<String, dynamic>),
        ),
        estimation: $checkedConvert(
          'estimation',
          (v) => v == null
              ? null
              : TsunamiRegionEstimation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'lastKind': 'last_kind'});

Map<String, dynamic> _$TsunamiRegionToJson(_TsunamiRegion instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kind': instance.kind,
      'last_kind': instance.lastKind,
      'stations': instance.stations,
      'forecast': ?instance.forecast,
      'estimation': ?instance.estimation,
    };
