// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'catalog_hypocenter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogHypocenter _$CatalogHypocenterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CatalogHypocenter',
  json,
  ($checkedConvert) {
    final val = _CatalogHypocenter(
      seq: $checkedConvert('seq', (v) => (v as num).toInt()),
      recordType: $checkedConvert(
        'record_type',
        (v) => $enumDecode(_$CatalogHypocenterRecordTypeEnumMap, v),
      ),
      originTime: $checkedConvert(
        'origin_time',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      latitude: $checkedConvert('latitude', (v) => v as num?),
      longitude: $checkedConvert('longitude', (v) => v as num?),
      depthKm: $checkedConvert('depth_km', (v) => v as num?),
      depthIsFree: $checkedConvert('depth_is_free', (v) => v as bool),
      magnitude1: $checkedConvert('magnitude1', (v) => v as num?),
      magnitude1Type: $checkedConvert('magnitude1_type', (v) => v as String?),
      magnitude2: $checkedConvert('magnitude2', (v) => v as num?),
      magnitude2Type: $checkedConvert('magnitude2_type', (v) => v as String?),
      maxIntensityRaw: $checkedConvert(
        'max_intensity_raw',
        (v) => v as String?,
      ),
      damageScale: $checkedConvert('damage_scale', (v) => v as String?),
      tsunamiScale: $checkedConvert('tsunami_scale', (v) => v as String?),
      determinationFlag: $checkedConvert(
        'determination_flag',
        (v) => v as String?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'recordType': 'record_type',
    'originTime': 'origin_time',
    'depthKm': 'depth_km',
    'depthIsFree': 'depth_is_free',
    'magnitude1Type': 'magnitude1_type',
    'magnitude2Type': 'magnitude2_type',
    'maxIntensityRaw': 'max_intensity_raw',
    'damageScale': 'damage_scale',
    'tsunamiScale': 'tsunami_scale',
    'determinationFlag': 'determination_flag',
  },
);

Map<String, dynamic> _$CatalogHypocenterToJson(_CatalogHypocenter instance) =>
    <String, dynamic>{
      'seq': instance.seq,
      'record_type': instance.recordType,
      'origin_time': instance.originTime?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'depth_km': instance.depthKm,
      'depth_is_free': instance.depthIsFree,
      'magnitude1': instance.magnitude1,
      'magnitude1_type': instance.magnitude1Type,
      'magnitude2': instance.magnitude2,
      'magnitude2_type': instance.magnitude2Type,
      'max_intensity_raw': instance.maxIntensityRaw,
      'damage_scale': instance.damageScale,
      'tsunami_scale': instance.tsunamiScale,
      'determination_flag': instance.determinationFlag,
    };

const _$CatalogHypocenterRecordTypeEnumMap = {
  CatalogHypocenterRecordType.a: 'A',
  CatalogHypocenterRecordType.b: 'B',
  CatalogHypocenterRecordType.d: 'D',
};
