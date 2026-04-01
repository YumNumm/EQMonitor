// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiForecast _$TsunamiForecastFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiForecast',
  json,
  ($checkedConvert) {
    final val = _TsunamiForecast(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      kind: $checkedConvert(
        'kind',
        (v) => $enumDecode(_$TsunamiWarningKindEnumMap, v),
      ),
      lastKind: $checkedConvert(
        'last_kind',
        (v) => $enumDecode(_$TsunamiWarningKindEnumMap, v),
      ),
      firstHeight: $checkedConvert(
        'first_height',
        (v) => v == null
            ? null
            : TsunamiForecastFirstHeight.fromJson(v as Map<String, dynamic>),
      ),
      maxHeight: $checkedConvert(
        'max_height',
        (v) => v == null
            ? null
            : TsunamiForecastMaxHeight.fromJson(v as Map<String, dynamic>),
      ),
      stations: $checkedConvert(
        'stations',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => TsunamiForecastStation.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'lastKind': 'last_kind',
    'firstHeight': 'first_height',
    'maxHeight': 'max_height',
  },
);

Map<String, dynamic> _$TsunamiForecastToJson(_TsunamiForecast instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kind': instance.kind,
      'last_kind': instance.lastKind,
      'first_height': ?instance.firstHeight,
      'max_height': ?instance.maxHeight,
      'stations': ?instance.stations,
    };

const _$TsunamiWarningKindEnumMap = {
  TsunamiWarningKind.majorWarning: 'MAJOR_WARNING',
  TsunamiWarningKind.warning: 'WARNING',
  TsunamiWarningKind.advisory: 'ADVISORY',
  TsunamiWarningKind.forecast: 'FORECAST',
  TsunamiWarningKind.none: 'NONE',
};
