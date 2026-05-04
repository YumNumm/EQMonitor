// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_code_table_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JmaCodeTableParameter _$JmaCodeTableParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_JmaCodeTableParameter', json, ($checkedConvert) {
  final val = _JmaCodeTableParameter(
    metadata: $checkedConvert(
      'metadata',
      (v) => ParameterMetadata.fromJson(v as Map<String, dynamic>),
    ),
    codeTables: $checkedConvert(
      'code_tables',
      (v) => JmaCodeTableCodeTables.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
}, fieldKeyMap: const {'codeTables': 'code_tables'});

Map<String, dynamic> _$JmaCodeTableParameterToJson(
  _JmaCodeTableParameter instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'code_tables': instance.codeTables,
};

_JmaCodeTableCodeTables _$JmaCodeTableCodeTablesFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_JmaCodeTableCodeTables',
  json,
  ($checkedConvert) {
    final val = _JmaCodeTableCodeTables(
      areaForecastLocalEew: $checkedConvert(
        'area_forecast_local_eew',
        (v) => (v as List<dynamic>)
            .map((e) => JmaCodeTableItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      areaInformationPrefectureEarthquake: $checkedConvert(
        'area_information_prefecture_earthquake',
        (v) => (v as List<dynamic>)
            .map((e) => JmaCodeTableItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      areaEpicenter: $checkedConvert(
        'area_epicenter',
        (v) => (v as List<dynamic>)
            .map((e) => JmaCodeTableItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      areaEpicenterAbbreviation: $checkedConvert(
        'area_epicenter_abbreviation',
        (v) => (v as List<dynamic>)
            .map((e) => JmaCodeTableItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      areaEpicenterDetail: $checkedConvert(
        'area_epicenter_detail',
        (v) => (v as List<dynamic>)
            .map((e) => JmaCodeTableItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'areaForecastLocalEew': 'area_forecast_local_eew',
    'areaInformationPrefectureEarthquake':
        'area_information_prefecture_earthquake',
    'areaEpicenter': 'area_epicenter',
    'areaEpicenterAbbreviation': 'area_epicenter_abbreviation',
    'areaEpicenterDetail': 'area_epicenter_detail',
  },
);

Map<String, dynamic> _$JmaCodeTableCodeTablesToJson(
  _JmaCodeTableCodeTables instance,
) => <String, dynamic>{
  'area_forecast_local_eew': instance.areaForecastLocalEew,
  'area_information_prefecture_earthquake':
      instance.areaInformationPrefectureEarthquake,
  'area_epicenter': instance.areaEpicenter,
  'area_epicenter_abbreviation': instance.areaEpicenterAbbreviation,
  'area_epicenter_detail': instance.areaEpicenterDetail,
};

_JmaCodeTableItem _$JmaCodeTableItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_JmaCodeTableItem', json, ($checkedConvert) {
      final val = _JmaCodeTableItem(
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert(
          'name',
          (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
        ),
        kana: $checkedConvert('kana', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JmaCodeTableItemToJson(_JmaCodeTableItem instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'kana': instance.kana,
      'description': instance.description,
    };
