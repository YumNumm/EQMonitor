// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'lpgm_intensity_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LpgmIntensityTree _$LpgmIntensityTreeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_LpgmIntensityTree', json, ($checkedConvert) {
      final val = _LpgmIntensityTree(
        lpgmIntensity: $checkedConvert(
          'lpgm_intensity',
          (v) => $enumDecode(_$JmaLpgmIntensityEnumMap, v),
        ),
        regions: $checkedConvert(
          'regions',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        stations: $checkedConvert(
          'stations',
          (v) => (v as List<dynamic>)
              .map(
                (e) => IntensityStationItem.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'lpgmIntensity': 'lpgm_intensity'});

Map<String, dynamic> _$LpgmIntensityTreeToJson(_LpgmIntensityTree instance) =>
    <String, dynamic>{
      'lpgm_intensity': instance.lpgmIntensity,
      'regions': instance.regions,
      'stations': instance.stations,
    };

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.value0: '0',
  JmaLpgmIntensity.value1: '1',
  JmaLpgmIntensity.value2: '2',
  JmaLpgmIntensity.value3: '3',
  JmaLpgmIntensity.value4: '4',
};
