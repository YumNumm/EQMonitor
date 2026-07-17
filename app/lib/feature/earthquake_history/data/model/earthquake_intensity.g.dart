// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeIntensity _$EarthquakeIntensityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeIntensity',
  json,
  ($checkedConvert) {
    final val = _EarthquakeIntensity(
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
      ),
      regions: $checkedConvert(
        'regions',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaIntensityEnumMap, k),
            (e as List<dynamic>)
                .map((e) => IntensityRegion.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        ),
      ),
      intensityTree: $checkedConvert(
        'intensity_tree',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaIntensityEnumMap, k),
            (e as List<dynamic>)
                .map(
                  (e) => PrefectureIntensityNode.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
        ),
      ),
      lpgmIntensityTree: $checkedConvert(
        'lpgm_intensity_tree',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$JmaLpgmIntensityEnumMap, k),
            (e as List<dynamic>)
                .map(
                  (e) => PrefectureLpgmIntensityNode.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'maxIntensity': 'max_intensity',
    'maxLpgmIntensity': 'max_lpgm_intensity',
    'intensityTree': 'intensity_tree',
    'lpgmIntensityTree': 'lpgm_intensity_tree',
  },
);

Map<String, dynamic> _$EarthquakeIntensityToJson(
  _EarthquakeIntensity instance,
) => <String, dynamic>{
  'max_intensity': _$JmaIntensityEnumMap[instance.maxIntensity]!,
  'max_lpgm_intensity': _$JmaLpgmIntensityEnumMap[instance.maxLpgmIntensity],
  'regions': instance.regions.map(
    (k, e) => MapEntry(_$JmaIntensityEnumMap[k]!, e),
  ),
  'intensity_tree': instance.intensityTree.map(
    (k, e) => MapEntry(_$JmaIntensityEnumMap[k]!, e),
  ),
  'lpgm_intensity_tree': instance.lpgmIntensityTree.map(
    (k, e) => MapEntry(_$JmaLpgmIntensityEnumMap[k]!, e),
  ),
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

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.unknown: 'unknown',
  JmaLpgmIntensity.zero: 'zero',
  JmaLpgmIntensity.one: 'one',
  JmaLpgmIntensity.two: 'two',
  JmaLpgmIntensity.three: 'three',
  JmaLpgmIntensity.four: 'four',
};
