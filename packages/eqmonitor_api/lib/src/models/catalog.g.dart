// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Catalog _$CatalogFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Catalog',
  json,
  ($checkedConvert) {
    final val = _Catalog(
      hypocenters: $checkedConvert(
        'hypocenters',
        (v) => (v as List<dynamic>)
            .map((e) => CatalogHypocenter.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      stationRecords: $checkedConvert(
        'station_records',
        (v) => (v as List<dynamic>)
            .map(
              (e) => CatalogStationRecord.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      damageScale: $checkedConvert(
        'damage_scale',
        (v) => $enumDecodeNullable(_$CatalogDamageScaleEnumMap, v),
      ),
      tsunamiScale: $checkedConvert(
        'tsunami_scale',
        (v) => $enumDecodeNullable(_$CatalogTsunamiScaleEnumMap, v),
      ),
      link: $checkedConvert(
        'link',
        (v) =>
            v == null ? null : CatalogLink.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'stationRecords': 'station_records',
    'damageScale': 'damage_scale',
    'tsunamiScale': 'tsunami_scale',
  },
);

Map<String, dynamic> _$CatalogToJson(_Catalog instance) => <String, dynamic>{
  'hypocenters': instance.hypocenters,
  'station_records': instance.stationRecords,
  'damage_scale': ?instance.damageScale,
  'tsunami_scale': ?instance.tsunamiScale,
  'link': ?instance.link,
};

const _$CatalogDamageScaleEnumMap = {
  CatalogDamageScale.value1: '1',
  CatalogDamageScale.value2: '2',
  CatalogDamageScale.value3: '3',
  CatalogDamageScale.value4: '4',
  CatalogDamageScale.value5: '5',
  CatalogDamageScale.value6: '6',
  CatalogDamageScale.value7: '7',
  CatalogDamageScale.x: 'X',
  CatalogDamageScale.y: 'Y',
};

const _$CatalogTsunamiScaleEnumMap = {
  CatalogTsunamiScale.value1: '1',
  CatalogTsunamiScale.value2: '2',
  CatalogTsunamiScale.value3: '3',
  CatalogTsunamiScale.value4: '4',
  CatalogTsunamiScale.value5: '5',
  CatalogTsunamiScale.value6: '6',
  CatalogTsunamiScale.t: 'T',
};
