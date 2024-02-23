// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'region_intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegionIntensityImpl _$$RegionIntensityImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$RegionIntensityImpl',
      json,
      ($checkedConvert) {
        final val = _$RegionIntensityImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          maxInt: $checkedConvert(
              'max_int', (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v)),
          maxLgInt: $checkedConvert('max_lg_int',
              (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'maxInt': 'max_int', 'maxLgInt': 'max_lg_int'},
    );

Map<String, dynamic> _$$RegionIntensityImplToJson(
        _$RegionIntensityImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'max_int': _$JmaIntensityEnumMap[instance.maxInt],
      'max_lg_int': _$JmaLgIntensityEnumMap[instance.maxLgInt],
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

const _$JmaLgIntensityEnumMap = {
  JmaLgIntensity.zero: '0',
  JmaLgIntensity.one: '1',
  JmaLgIntensity.two: '2',
  JmaLgIntensity.three: '3',
  JmaLgIntensity.four: '4',
};
