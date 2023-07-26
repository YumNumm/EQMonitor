// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew_intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ForecastMaxInt _$$_ForecastMaxIntFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_ForecastMaxInt',
      json,
      ($checkedConvert) {
        final val = _$_ForecastMaxInt(
          from: $checkedConvert(
              'from', (v) => $enumDecode(_$JmaForecastIntensityEnumMap, v)),
          to: $checkedConvert(
              'to', (v) => $enumDecode(_$JmaForecastIntensityOverEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_ForecastMaxIntToJson(_$_ForecastMaxInt instance) =>
    <String, dynamic>{
      'from': _$JmaForecastIntensityEnumMap[instance.from]!,
      'to': _$JmaForecastIntensityOverEnumMap[instance.to]!,
    };

const _$JmaForecastIntensityEnumMap = {
  JmaForecastIntensity.zero: '0',
  JmaForecastIntensity.one: '1',
  JmaForecastIntensity.two: '2',
  JmaForecastIntensity.three: '3',
  JmaForecastIntensity.four: '4',
  JmaForecastIntensity.fiveLower: '5-',
  JmaForecastIntensity.fiveUpper: '5+',
  JmaForecastIntensity.sixLower: '6-',
  JmaForecastIntensity.sixUpper: '6+',
  JmaForecastIntensity.seven: '7',
  JmaForecastIntensity.unknown: '不明',
};

const _$JmaForecastIntensityOverEnumMap = {
  JmaForecastIntensityOver.zero: '0',
  JmaForecastIntensityOver.one: '1',
  JmaForecastIntensityOver.two: '2',
  JmaForecastIntensityOver.three: '3',
  JmaForecastIntensityOver.four: '4',
  JmaForecastIntensityOver.fiveLower: '5-',
  JmaForecastIntensityOver.fiveUpper: '5+',
  JmaForecastIntensityOver.sixLower: '6-',
  JmaForecastIntensityOver.sixUpper: '6+',
  JmaForecastIntensityOver.seven: '7',
  JmaForecastIntensityOver.unknown: '不明',
  JmaForecastIntensityOver.over: 'over',
};

_$_ForecastMaxLgInt _$$_ForecastMaxLgIntFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_ForecastMaxLgInt',
      json,
      ($checkedConvert) {
        final val = _$_ForecastMaxLgInt(
          from: $checkedConvert(
              'from', (v) => $enumDecode(_$JmaForecastLgIntensityEnumMap, v)),
          to: $checkedConvert(
              'to', (v) => $enumDecode(_$JmaForecastLgIntensityOverEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_ForecastMaxLgIntToJson(_$_ForecastMaxLgInt instance) =>
    <String, dynamic>{
      'from': _$JmaForecastLgIntensityEnumMap[instance.from]!,
      'to': _$JmaForecastLgIntensityOverEnumMap[instance.to]!,
    };

const _$JmaForecastLgIntensityEnumMap = {
  JmaForecastLgIntensity.zero: '0',
  JmaForecastLgIntensity.one: '1',
  JmaForecastLgIntensity.two: '2',
  JmaForecastLgIntensity.three: '3',
  JmaForecastLgIntensity.four: '4',
  JmaForecastLgIntensity.unknown: '不明',
};

const _$JmaForecastLgIntensityOverEnumMap = {
  JmaForecastLgIntensityOver.zero: '0',
  JmaForecastLgIntensityOver.one: '1',
  JmaForecastLgIntensityOver.two: '2',
  JmaForecastLgIntensityOver.three: '3',
  JmaForecastLgIntensityOver.four: '4',
  JmaForecastLgIntensityOver.unknown: '不明',
  JmaForecastLgIntensityOver.over: 'over',
};
