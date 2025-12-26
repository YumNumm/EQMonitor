// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityItem _$IntensityItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityItem',
      json,
      ($checkedConvert) {
        final val = _IntensityItem(
          value: $checkedConvert(
            'value',
            (v) => CodeName.fromJson(v as Map<String, dynamic>),
          ),
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) => $enumDecodeNullable(_$IntensityValueEnumMap, v),
          ),
          maxLpgmIntensity: $checkedConvert(
            'max_lpgm_intensity',
            (v) => $enumDecodeNullable(_$LpgmIntensityValueEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'maxIntensity': 'max_intensity',
        'maxLpgmIntensity': 'max_lpgm_intensity',
      },
    );

Map<String, dynamic> _$IntensityItemToJson(
  _IntensityItem instance,
) => <String, dynamic>{
  'value': instance.value,
  'max_intensity': _$IntensityValueEnumMap[instance.maxIntensity],
  'max_lpgm_intensity': _$LpgmIntensityValueEnumMap[instance.maxLpgmIntensity],
};

const _$IntensityValueEnumMap = {
  IntensityValue.zero: '0',
  IntensityValue.one: '1',
  IntensityValue.two: '2',
  IntensityValue.three: '3',
  IntensityValue.four: '4',
  IntensityValue.fiveLowerNoInput: '!5-',
  IntensityValue.fiveLower: '5-',
  IntensityValue.fiveUpper: '5+',
  IntensityValue.sixLower: '6-',
  IntensityValue.sixUpper: '6+',
  IntensityValue.seven: '7',
};

const _$LpgmIntensityValueEnumMap = {
  LpgmIntensityValue.zero: '0',
  LpgmIntensityValue.one: '1',
  LpgmIntensityValue.two: '2',
  LpgmIntensityValue.three: '3',
  LpgmIntensityValue.four: '4',
};

_PrePeriod _$PrePeriodFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PrePeriod', json, ($checkedConvert) {
      final val = _PrePeriod(
        band: $checkedConvert('band', (v) => (v as num).toInt()),
        lpgmIntensity: $checkedConvert(
          'lpgm_intensity',
          (v) => $enumDecode(_$LpgmIntensityValueEnumMap, v),
        ),
        sva: $checkedConvert('sva', (v) => (v as num).toDouble()),
      );
      return val;
    }, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$PrePeriodToJson(_PrePeriod instance) =>
    <String, dynamic>{
      'band': instance.band,
      'lpgm_intensity': _$LpgmIntensityValueEnumMap[instance.lpgmIntensity]!,
      'sva': instance.sva,
    };

_IntensityStationItem _$IntensityStationItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityStationItem',
  json,
  ($checkedConvert) {
    final val = _IntensityStationItem(
      value: $checkedConvert(
        'value',
        (v) => CodeName.fromJson(v as Map<String, dynamic>),
      ),
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecodeNullable(_$IntensityValueEnumMap, v),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$LpgmIntensityValueEnumMap, v),
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
    'maxIntensity': 'max_intensity',
    'maxLpgmIntensity': 'max_lpgm_intensity',
    'prePeriods': 'pre_periods',
  },
);

Map<String, dynamic> _$IntensityStationItemToJson(
  _IntensityStationItem instance,
) => <String, dynamic>{
  'value': instance.value,
  'max_intensity': _$IntensityValueEnumMap[instance.maxIntensity],
  'max_lpgm_intensity': _$LpgmIntensityValueEnumMap[instance.maxLpgmIntensity],
  'sva': instance.sva,
  'pre_periods': instance.prePeriods,
};

_Intensity _$IntensityFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Intensity',
  json,
  ($checkedConvert) {
    final val = _Intensity(
      maxIntensity: $checkedConvert(
        'max_intensity',
        (v) => $enumDecode(_$IntensityValueEnumMap, v),
      ),
      maxLpgmIntensity: $checkedConvert(
        'max_lpgm_intensity',
        (v) => $enumDecodeNullable(_$LpgmIntensityValueEnumMap, v),
      ),
      prefectures: $checkedConvert(
        'prefectures',
        (v) => (v as List<dynamic>)
            .map((e) => IntensityItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      regions: $checkedConvert(
        'regions',
        (v) => (v as List<dynamic>)
            .map((e) => IntensityItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      cities: $checkedConvert(
        'cities',
        (v) => (v as List<dynamic>?)
            ?.map((e) => IntensityItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      stations: $checkedConvert(
        'stations',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) => IntensityStationItem.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'maxIntensity': 'max_intensity',
    'maxLpgmIntensity': 'max_lpgm_intensity',
  },
);

Map<String, dynamic> _$IntensityToJson(
  _Intensity instance,
) => <String, dynamic>{
  'max_intensity': _$IntensityValueEnumMap[instance.maxIntensity]!,
  'max_lpgm_intensity': _$LpgmIntensityValueEnumMap[instance.maxLpgmIntensity],
  'prefectures': instance.prefectures,
  'regions': instance.regions,
  'cities': instance.cities,
  'stations': instance.stations,
};

_IntensityPartial _$IntensityPartialFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_IntensityPartial',
      json,
      ($checkedConvert) {
        final val = _IntensityPartial(
          maxIntensity: $checkedConvert(
            'max_intensity',
            (v) => $enumDecode(_$IntensityValueEnumMap, v),
          ),
          maxLpgmIntensity: $checkedConvert(
            'max_lpgm_intensity',
            (v) => $enumDecodeNullable(_$LpgmIntensityValueEnumMap, v),
          ),
          prefectures: $checkedConvert(
            'prefectures',
            (v) => (v as List<dynamic>)
                .map((e) => IntensityItem.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          regions: $checkedConvert(
            'regions',
            (v) => (v as List<dynamic>)
                .map((e) => IntensityItem.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'maxIntensity': 'max_intensity',
        'maxLpgmIntensity': 'max_lpgm_intensity',
      },
    );

Map<String, dynamic> _$IntensityPartialToJson(
  _IntensityPartial instance,
) => <String, dynamic>{
  'max_intensity': _$IntensityValueEnumMap[instance.maxIntensity]!,
  'max_lpgm_intensity': _$LpgmIntensityValueEnumMap[instance.maxLpgmIntensity],
  'prefectures': instance.prefectures,
  'regions': instance.regions,
};
