// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_station_intensity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogStationIntensity _$CatalogStationIntensityFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CatalogStationIntensity', json, ($checkedConvert) {
  final val = _CatalogStationIntensity(
    classValue: $checkedConvert(
      'class',
      (v) => $enumDecode(_$CatalogIntensityClassEnumMap, v),
    ),
    instrumental: $checkedConvert('instrumental', (v) => v as num?),
  );
  return val;
}, fieldKeyMap: const {'classValue': 'class'});

Map<String, dynamic> _$CatalogStationIntensityToJson(
  _CatalogStationIntensity instance,
) => <String, dynamic>{
  'class': instance.classValue,
  'instrumental': ?instance.instrumental,
};

const _$CatalogIntensityClassEnumMap = {
  CatalogIntensityClass.value1: '1',
  CatalogIntensityClass.value2: '2',
  CatalogIntensityClass.value3: '3',
  CatalogIntensityClass.value4: '4',
  CatalogIntensityClass.value5: '5',
  CatalogIntensityClass.value6: '6',
  CatalogIntensityClass.value7: '7',
  CatalogIntensityClass.value9: '9',
  CatalogIntensityClass.a: 'A',
  CatalogIntensityClass.b: 'B',
  CatalogIntensityClass.c: 'C',
  CatalogIntensityClass.d: 'D',
  CatalogIntensityClass.l: 'L',
  CatalogIntensityClass.s: 'S',
  CatalogIntensityClass.m: 'M',
  CatalogIntensityClass.r: 'R',
  CatalogIntensityClass.f: 'F',
  CatalogIntensityClass.x: 'X',
};
