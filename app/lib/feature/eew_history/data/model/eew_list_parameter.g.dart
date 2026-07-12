// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_list_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewListParameter _$EewListParameterFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewListParameter',
      json,
      ($checkedConvert) {
        final val = _EewListParameter(
          magnitudeGte: $checkedConvert(
            'magnitude_gte',
            (v) => (v as num?)?.toDouble(),
          ),
          magnitudeLte: $checkedConvert(
            'magnitude_lte',
            (v) => (v as num?)?.toDouble(),
          ),
          depthGte: $checkedConvert('depth_gte', (v) => (v as num?)?.toInt()),
          depthLte: $checkedConvert('depth_lte', (v) => (v as num?)?.toInt()),
          intensityGte: $checkedConvert(
            'intensity_gte',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          intensityLte: $checkedConvert(
            'intensity_lte',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          originTimeGte: $checkedConvert(
            'origin_time_gte',
            (v) => v == null ? null : Date.fromJson(v),
          ),
          originTimeLte: $checkedConvert(
            'origin_time_lte',
            (v) => v == null ? null : Date.fromJson(v),
          ),
          isWarning: $checkedConvert('is_warning', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'magnitudeGte': 'magnitude_gte',
        'magnitudeLte': 'magnitude_lte',
        'depthGte': 'depth_gte',
        'depthLte': 'depth_lte',
        'intensityGte': 'intensity_gte',
        'intensityLte': 'intensity_lte',
        'originTimeGte': 'origin_time_gte',
        'originTimeLte': 'origin_time_lte',
        'isWarning': 'is_warning',
      },
    );

Map<String, dynamic> _$EewListParameterToJson(_EewListParameter instance) =>
    <String, dynamic>{
      'magnitude_gte': instance.magnitudeGte,
      'magnitude_lte': instance.magnitudeLte,
      'depth_gte': instance.depthGte,
      'depth_lte': instance.depthLte,
      'intensity_gte': _$JmaIntensityEnumMap[instance.intensityGte],
      'intensity_lte': _$JmaIntensityEnumMap[instance.intensityLte],
      'origin_time_gte': instance.originTimeGte,
      'origin_time_lte': instance.originTimeLte,
      'is_warning': instance.isWarning,
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
  JmaIntensity.sixUnknown: 'sixUnknown',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};
