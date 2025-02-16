// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'earthquake_history_early_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeHistoryEarlyParameterImpl
_$$EarthquakeHistoryEarlyParameterImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$EarthquakeHistoryEarlyParameterImpl',
  json,
  ($checkedConvert) {
    final val = _$EarthquakeHistoryEarlyParameterImpl(
      sort: $checkedConvert(
        'sort',
        (v) => $enumDecode(
          _$EarthquakeEarlySortTypeEnumMap,
          v,
        ),
      ),
      ascending: $checkedConvert(
        'ascending',
        (v) => v as bool,
      ),
      magnitudeLte: $checkedConvert(
        'magnitude_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      magnitudeGte: $checkedConvert(
        'magnitude_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      depthLte: $checkedConvert(
        'depth_lte',
        (v) => (v as num?)?.toDouble(),
      ),
      depthGte: $checkedConvert(
        'depth_gte',
        (v) => (v as num?)?.toDouble(),
      ),
      intensityLte: $checkedConvert(
        'intensity_lte',
        (v) =>
            $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      intensityGte: $checkedConvert(
        'intensity_gte',
        (v) =>
            $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
      originTimeLte: $checkedConvert(
        'origin_time_lte',
        (v) =>
            v == null ? null : DateTime.parse(v as String),
      ),
      originTimeGte: $checkedConvert(
        'origin_time_gte',
        (v) =>
            v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'magnitudeLte': 'magnitude_lte',
    'magnitudeGte': 'magnitude_gte',
    'depthLte': 'depth_lte',
    'depthGte': 'depth_gte',
    'intensityLte': 'intensity_lte',
    'intensityGte': 'intensity_gte',
    'originTimeLte': 'origin_time_lte',
    'originTimeGte': 'origin_time_gte',
  },
);

Map<String, dynamic>
_$$EarthquakeHistoryEarlyParameterImplToJson(
  _$EarthquakeHistoryEarlyParameterImpl instance,
) => <String, dynamic>{
  'sort': _$EarthquakeEarlySortTypeEnumMap[instance.sort]!,
  'ascending': instance.ascending,
  'magnitude_lte': instance.magnitudeLte,
  'magnitude_gte': instance.magnitudeGte,
  'depth_lte': instance.depthLte,
  'depth_gte': instance.depthGte,
  'intensity_lte':
      _$JmaIntensityEnumMap[instance.intensityLte],
  'intensity_gte':
      _$JmaIntensityEnumMap[instance.intensityGte],
  'origin_time_lte':
      instance.originTimeLte?.toIso8601String(),
  'origin_time_gte':
      instance.originTimeGte?.toIso8601String(),
};

const _$EarthquakeEarlySortTypeEnumMap = {
  EarthquakeEarlySortType.origin_time: 'origin_time',
  EarthquakeEarlySortType.magnitude: 'magnitude',
  EarthquakeEarlySortType.depth: 'depth',
  EarthquakeEarlySortType.max_intensity: 'max_intensity',
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.one: '1',
  JmaIntensity.two: '2',
  JmaIntensity.three: '3',
  JmaIntensity.four: '4',
  JmaIntensity.fiveLower: '5-',
  JmaIntensity.fiveUpper: '5+',
  JmaIntensity.sixLower: '6-',
  JmaIntensity.sixUpper: '6+',
  JmaIntensity.seven: '7',
  JmaIntensity.fiveUpperNoInput: '!5-',
};
