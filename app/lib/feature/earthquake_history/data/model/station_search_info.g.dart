// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'station_search_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StationSearchInfo _$StationSearchInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_StationSearchInfo',
      json,
      ($checkedConvert) {
        final val = _StationSearchInfo(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          intensity: $checkedConvert(
            'intensity',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          lpgmIntensity: $checkedConvert(
            'lpgm_intensity',
            (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
          ),
          sva: $checkedConvert('sva', (v) => (v as num?)?.toDouble()),
          prePeriods: $checkedConvert(
            'pre_periods',
            (v) => (v as List<dynamic>?)
                ?.map((e) => PrePeriod.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'lpgmIntensity': 'lpgm_intensity',
        'prePeriods': 'pre_periods',
      },
    );

Map<String, dynamic> _$StationSearchInfoToJson(_StationSearchInfo instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'intensity': _$JmaIntensityEnumMap[instance.intensity],
      'lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.lpgmIntensity],
      'sva': instance.sva,
      'pre_periods': instance.prePeriods,
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
