// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityTree _$IntensityTreeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_IntensityTree', json, ($checkedConvert) {
      final val = _IntensityTree(
        intensity: $checkedConvert(
          'intensity',
          (v) => $enumDecode(_$JmaIntensityEnumMap, v),
        ),
        regions: $checkedConvert(
          'regions',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
        stations: $checkedConvert(
          'stations',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$IntensityTreeToJson(_IntensityTree instance) =>
    <String, dynamic>{
      'intensity': instance.intensity,
      'regions': instance.regions,
      'stations': ?instance.stations,
    };

const _$JmaIntensityEnumMap = {
  JmaIntensity.value0: '0',
  JmaIntensity.value1: '1',
  JmaIntensity.value2: '2',
  JmaIntensity.value3: '3',
  JmaIntensity.value4: '4',
  JmaIntensity.value5unknown: '!5-',
  JmaIntensity.value5minus: '5-',
  JmaIntensity.value5plus: '5+',
  JmaIntensity.value6unknown: '!6-',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: '7',
};
