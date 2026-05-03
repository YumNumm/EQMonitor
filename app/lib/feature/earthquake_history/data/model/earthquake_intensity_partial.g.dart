// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_intensity_partial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeIntensityPartial _$EarthquakeIntensityPartialFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeIntensityPartial',
  json,
  ($checkedConvert) {
    final val = _EarthquakeIntensityPartial(
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
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

Map<String, dynamic> _$EarthquakeIntensityPartialToJson(
  _EarthquakeIntensityPartial instance,
) => <String, dynamic>{
  'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
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
