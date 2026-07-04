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
      damageScale: $checkedConvert('damage_scale', (v) => v as String?),
      tsunamiScale: $checkedConvert('tsunami_scale', (v) => v as String?),
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
  'damage_scale': instance.damageScale,
  'tsunami_scale': instance.tsunamiScale,
  'link': ?instance.link,
};
