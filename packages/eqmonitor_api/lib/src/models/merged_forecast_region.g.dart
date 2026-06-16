// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'merged_forecast_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MergedForecastRegion _$MergedForecastRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_MergedForecastRegion',
  json,
  ($checkedConvert) {
    final val = _MergedForecastRegion(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      kind: $checkedConvert(
        'kind',
        (v) => $enumDecode(_$TsunamiWarningKindEnumMap, v),
      ),
      kindCode: $checkedConvert('kind_code', (v) => v as String?),
      lastKind: $checkedConvert(
        'last_kind',
        (v) => $enumDecodeNullable(_$TsunamiWarningKindEnumMap, v),
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
      observation: $checkedConvert(
        'observation',
        (v) =>
            v == null ? null : Observation.fromJson(v as Map<String, dynamic>),
      ),
      estimation: $checkedConvert(
        'estimation',
        (v) =>
            v == null ? null : Estimation.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'kindCode': 'kind_code',
    'lastKind': 'last_kind',
    'firstHeight': 'first_height',
    'maxHeight': 'max_height',
  },
);

Map<String, dynamic> _$MergedForecastRegionToJson(
  _MergedForecastRegion instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'kind': instance.kind,
  'kind_code': ?instance.kindCode,
  'last_kind': ?instance.lastKind,
  'first_height': ?instance.firstHeight,
  'max_height': ?instance.maxHeight,
  'stations': ?instance.stations,
  'observation': ?instance.observation,
  'estimation': ?instance.estimation,
};

const _$TsunamiWarningKindEnumMap = {
  TsunamiWarningKind.majorWarning: 'MAJOR_WARNING',
  TsunamiWarningKind.warning: 'WARNING',
  TsunamiWarningKind.advisory: 'ADVISORY',
  TsunamiWarningKind.forecast: 'FORECAST',
  TsunamiWarningKind.none: 'NONE',
};
