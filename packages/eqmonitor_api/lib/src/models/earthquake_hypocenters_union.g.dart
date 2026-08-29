// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_hypocenters_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakeHypocentersUnionVariant1 _$EarthquakeHypocentersUnionVariant1FromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'EarthquakeHypocentersUnionVariant1',
  json,
  ($checkedConvert) {
    final val = EarthquakeHypocentersUnionVariant1(
      datasource: $checkedConvert('datasource', (v) => v as String),
      reportedAt: $checkedConvert(
        'reported_at',
        (v) => DateTime.parse(v as String),
      ),
      sourceTelegramId: $checkedConvert(
        'source_telegram_id',
        (v) => v as String?,
      ),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => Hypocenter.fromJson(v as Map<String, dynamic>),
      ),
      $type: $checkedConvert('runtimeType', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'reportedAt': 'reported_at',
    'sourceTelegramId': 'source_telegram_id',
    r'$type': 'runtimeType',
  },
);

Map<String, dynamic> _$EarthquakeHypocentersUnionVariant1ToJson(
  EarthquakeHypocentersUnionVariant1 instance,
) => <String, dynamic>{
  'datasource': instance.datasource,
  'reported_at': instance.reportedAt.toIso8601String(),
  'source_telegram_id': instance.sourceTelegramId,
  'hypocenter': instance.hypocenter,
  'runtimeType': instance.$type,
};

EarthquakeHypocentersUnionVariant2 _$EarthquakeHypocentersUnionVariant2FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EarthquakeHypocentersUnionVariant2', json, (
  $checkedConvert,
) {
  final val = EarthquakeHypocentersUnionVariant2(
    datasource: $checkedConvert('datasource', (v) => v as String),
    seq: $checkedConvert('seq', (v) => (v as num).toInt()),
    recordType: $checkedConvert(
      'record_type',
      (v) => $enumDecode(_$CatalogHypocenterRecordTypeEnumMap, v),
    ),
    hypocenter: $checkedConvert(
      'hypocenter',
      (v) => Hypocenter.fromJson(v as Map<String, dynamic>),
    ),
    catalog: $checkedConvert(
      'catalog',
      (v) => CatalogHypocenter.fromJson(v as Map<String, dynamic>),
    ),
    $type: $checkedConvert('runtimeType', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'recordType': 'record_type', r'$type': 'runtimeType'});

Map<String, dynamic> _$EarthquakeHypocentersUnionVariant2ToJson(
  EarthquakeHypocentersUnionVariant2 instance,
) => <String, dynamic>{
  'datasource': instance.datasource,
  'seq': instance.seq,
  'record_type': instance.recordType,
  'hypocenter': instance.hypocenter,
  'catalog': instance.catalog,
  'runtimeType': instance.$type,
};

const _$CatalogHypocenterRecordTypeEnumMap = {
  CatalogHypocenterRecordType.a: 'A',
  CatalogHypocenterRecordType.b: 'B',
  CatalogHypocenterRecordType.d: 'D',
};
