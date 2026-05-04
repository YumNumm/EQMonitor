// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrefectureIntensityNode _$PrefectureIntensityNodeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PrefectureIntensityNode', json, ($checkedConvert) {
  final val = _PrefectureIntensityNode(
    region: $checkedConvert(
      'region',
      (v) => IntensityRegion.fromJson(v as Map<String, dynamic>),
    ),
    cities: $checkedConvert(
      'cities',
      (v) => (v as List<dynamic>)
          .map((e) => CityIntensityNode.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PrefectureIntensityNodeToJson(
  _PrefectureIntensityNode instance,
) => <String, dynamic>{'region': instance.region, 'cities': instance.cities};

_IntensityRegion _$IntensityRegionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_IntensityRegion', json, ($checkedConvert) {
      final val = _IntensityRegion(
        region: $checkedConvert(
          'region',
          (v) =>
              EarthquakeParameterRegionItem.fromJson(v as Map<String, dynamic>),
        ),
        maxIntensity: $checkedConvert(
          'max_intensity',
          (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
        ),
      );
      return val;
    }, fieldKeyMap: const {'maxIntensity': 'max_intensity'});

Map<String, dynamic> _$IntensityRegionToJson(_IntensityRegion instance) =>
    <String, dynamic>{
      'region': instance.region,
      'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
    };

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};

_CityIntensityNode _$CityIntensityNodeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_CityIntensityNode',
      json,
      ($checkedConvert) {
        final val = _CityIntensityNode(
          city: $checkedConvert(
            'city',
            (v) =>
                EarthquakeParameterCityItem.fromJson(v as Map<String, dynamic>),
          ),
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          stations: $checkedConvert(
            'stations',
            (v) => (v as List<dynamic>)
                .map(
                  (e) =>
                      StationIntensityNode.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          maxLpgmIntensity: $checkedConvert(
            'max_lpgm_intensity',
            (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'maxIntensity': 'max_intensity',
        'maxLpgmIntensity': 'max_lpgm_intensity',
      },
    );

Map<String, dynamic> _$CityIntensityNodeToJson(
  _CityIntensityNode instance,
) => <String, dynamic>{
  'city': instance.city,
  'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
  'stations': instance.stations,
  'max_lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensity],
};

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};

_StationIntensityNode _$StationIntensityNodeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_StationIntensityNode', json, ($checkedConvert) {
  final val = _StationIntensityNode(
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

Map<String, dynamic> _$StationIntensityNodeToJson(
  _StationIntensityNode instance,
) => <String, dynamic>{
  'station': instance.station,
  'intensity': instance.intensity,
};
