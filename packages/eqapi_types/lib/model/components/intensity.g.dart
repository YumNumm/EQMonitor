// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntensityImpl _$$IntensityImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$IntensityImpl',
      json,
      ($checkedConvert) {
        final val = _$IntensityImpl(
          maxInt: $checkedConvert(
              'maxInt', (v) => $enumDecode(_$JmaIntensityEnumMap, v)),
          maxLgInt: $checkedConvert('maxLgInt',
              (v) => $enumDecodeNullable(_$JmaLgIntensityEnumMap, v) ?? null),
          lgCategory: $checkedConvert('lgCategory',
              (v) => $enumDecodeNullable(_$LgTypeEnumMap, v) ?? null),
          prefectures: $checkedConvert(
              'prefectures',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      RegionIntensity.fromJson(e as Map<String, dynamic>))
                  .toList()),
          regions: $checkedConvert(
              'regions',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      RegionIntensity.fromJson(e as Map<String, dynamic>))
                  .toList()),
          cities: $checkedConvert(
              'cities',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      RegionIntensity.fromJson(e as Map<String, dynamic>))
                  .toList()),
          stations: $checkedConvert(
              'stations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      RegionIntensity.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$IntensityImplToJson(_$IntensityImpl instance) =>
    <String, dynamic>{
      'maxInt': _$JmaIntensityEnumMap[instance.maxInt]!,
      'maxLgInt': _$JmaLgIntensityEnumMap[instance.maxLgInt],
      'lgCategory': _$LgTypeEnumMap[instance.lgCategory],
      'prefectures': instance.prefectures,
      'regions': instance.regions,
      'cities': instance.cities,
      'stations': instance.stations,
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

const _$LgTypeEnumMap = {
  LgType.one: '1',
  LgType.two: '2',
  LgType.three: '3',
  LgType.four: '4',
};
