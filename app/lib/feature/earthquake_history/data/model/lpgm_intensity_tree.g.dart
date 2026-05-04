// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'lpgm_intensity_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrefectureLpgmIntensityNode _$PrefectureLpgmIntensityNodeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_PrefectureLpgmIntensityNode',
  json,
  ($checkedConvert) {
    final val = _PrefectureLpgmIntensityNode(
      region: $checkedConvert(
        'region',
        (v) =>
            EarthquakeParameterRegionItem.fromJson(v as Map<String, dynamic>),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      cities: $checkedConvert(
        'cities',
        (v) => (v as List<dynamic>)
            .map(
              (e) => CityLpgmIntensityNode.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'maxLpgmIntensity': 'max_lpgm_intensity'},
);

Map<String, dynamic> _$PrefectureLpgmIntensityNodeToJson(
  _PrefectureLpgmIntensityNode instance,
) => <String, dynamic>{
  'region': instance.region,
  'max_lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensity],
  'cities': instance.cities,
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};

_LpgmIntensityRegion _$LpgmIntensityRegionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_LpgmIntensityRegion',
      json,
      ($checkedConvert) {
        final val = _LpgmIntensityRegion(
          region: $checkedConvert(
            'region',
            (v) => EarthquakeParameterRegionItem.fromJson(
              v as Map<String, dynamic>,
            ),
          ),
          maxLpgmIntensity: $checkedConvert(
            'max_lpgm_intensity',
            (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'maxLpgmIntensity': 'max_lpgm_intensity'},
    );

Map<String, dynamic> _$LpgmIntensityRegionToJson(
  _LpgmIntensityRegion instance,
) => <String, dynamic>{
  'region': instance.region,
  'max_lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensity],
};

_CityLpgmIntensityNode _$CityLpgmIntensityNodeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CityLpgmIntensityNode',
  json,
  ($checkedConvert) {
    final val = _CityLpgmIntensityNode(
      city: $checkedConvert(
        'city',
        (v) => EarthquakeParameterCityItem.fromJson(v as Map<String, dynamic>),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      stations: $checkedConvert(
        'stations',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  StationLpgmIntensityNode.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'maxLpgmIntensity': 'max_lpgm_intensity'},
);

Map<String, dynamic> _$CityLpgmIntensityNodeToJson(
  _CityLpgmIntensityNode instance,
) => <String, dynamic>{
  'city': instance.city,
  'max_lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensity],
  'stations': instance.stations,
};

_StationLpgmIntensityNode _$StationLpgmIntensityNodeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_StationLpgmIntensityNode', json, ($checkedConvert) {
  final val = _StationLpgmIntensityNode(
    station: $checkedConvert(
      'station',
      (v) => EarthquakeParameterStationItem.fromJson(v as Map<String, dynamic>),
    ),
    intensity: $checkedConvert(
      'intensity',
      (v) => v == null
          ? null
          : IntensityStation.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$StationLpgmIntensityNodeToJson(
  _StationLpgmIntensityNode instance,
) => <String, dynamic>{
  'station': instance.station,
  'intensity': instance.intensity,
};
