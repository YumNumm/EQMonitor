// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityStation _$IntensityStationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityStation',
      json,
      ($checkedConvert) {
        final val = _IntensityStation(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          sva: $checkedConvert('sva', (v) => (v as num).toDouble()),
          prePeriods: $checkedConvert(
            'pre_periods',
            (v) => (v as List<dynamic>)
                .map((e) => PrePeriod.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          maxLpgmIntensity: $checkedConvert(
            'max_lpgm_intensity',
            (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'prePeriods': 'pre_periods',
        'maxIntensity': 'max_intensity',
        'maxLpgmIntensity': 'max_lpgm_intensity',
      },
    );

Map<String, dynamic> _$IntensityStationToJson(
  _IntensityStation instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'sva': instance.sva,
  'pre_periods': instance.prePeriods,
  'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity],
  'max_lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensity],
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

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};

_PrePeriod _$PrePeriodFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PrePeriod', json, ($checkedConvert) {
      final val = _PrePeriod(
        band: $checkedConvert('band', (v) => (v as num).toDouble()),
        lpgmIntensity: $checkedConvert(
          'lpgm_intensity',
          (v) => $enumDecode(_$JmaLpgmIntensityEnumMap, v),
        ),
        sva: $checkedConvert('sva', (v) => (v as num).toDouble()),
      );
      return val;
    }, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$PrePeriodToJson(_PrePeriod instance) =>
    <String, dynamic>{
      'band': instance.band,
      'lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.lpgmIntensity]!,
      'sva': instance.sva,
    };
