// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_early_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarthquakeHistoryEarlyParameterImpl
    _$$EarthquakeHistoryEarlyParameterImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$EarthquakeHistoryEarlyParameterImpl',
          json,
          ($checkedConvert) {
            final val = _$EarthquakeHistoryEarlyParameterImpl(
              sort: $checkedConvert('sort',
                  (v) => $enumDecode(_$EarthquakeEarlySortTypeEnumMap, v)),
              ascending: $checkedConvert('ascending', (v) => v as bool),
              magnitudeLte: $checkedConvert(
                  'magnitudeLte', (v) => (v as num?)?.toDouble()),
              magnitudeGte: $checkedConvert(
                  'magnitudeGte', (v) => (v as num?)?.toDouble()),
              depthLte:
                  $checkedConvert('depthLte', (v) => (v as num?)?.toDouble()),
              depthGte:
                  $checkedConvert('depthGte', (v) => (v as num?)?.toDouble()),
              intensityLte: $checkedConvert('intensityLte',
                  (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
              intensityGte: $checkedConvert('intensityGte',
                  (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
              originTimeLte: $checkedConvert('originTimeLte',
                  (v) => v == null ? null : DateTime.parse(v as String)),
              originTimeGte: $checkedConvert('originTimeGte',
                  (v) => v == null ? null : DateTime.parse(v as String)),
            );
            return val;
          },
        );

Map<String, dynamic> _$$EarthquakeHistoryEarlyParameterImplToJson(
        _$EarthquakeHistoryEarlyParameterImpl instance) =>
    <String, dynamic>{
      'sort': _$EarthquakeEarlySortTypeEnumMap[instance.sort]!,
      'ascending': instance.ascending,
      'magnitudeLte': instance.magnitudeLte,
      'magnitudeGte': instance.magnitudeGte,
      'depthLte': instance.depthLte,
      'depthGte': instance.depthGte,
      'intensityLte': _$JmaIntensityEnumMap[instance.intensityLte],
      'intensityGte': _$JmaIntensityEnumMap[instance.intensityGte],
      'originTimeLte': instance.originTimeLte?.toIso8601String(),
      'originTimeGte': instance.originTimeGte?.toIso8601String(),
    };

const _$EarthquakeEarlySortTypeEnumMap = {
  EarthquakeEarlySortType.originTime: 'originTime',
  EarthquakeEarlySortType.magnitude: 'magnitude',
  EarthquakeEarlySortType.depth: 'depth',
  EarthquakeEarlySortType.maxIntensity: 'maxIntensity',
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
