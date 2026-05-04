// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_code_table_parameter_code_tables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JmaCodeTableParameterCodeTables _$JmaCodeTableParameterCodeTablesFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_JmaCodeTableParameterCodeTables',
  json,
  ($checkedConvert) {
    final val = _JmaCodeTableParameterCodeTables(
      areaForecastLocalEew: $checkedConvert(
        'area_forecast_local_eew',
        (v) => (v as List<dynamic>)
            .map(
              (e) => JmaCodeTableAreaForecastLocalEewItem.fromJson(
                e as Map<String, dynamic>,
              ),
            )
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

Map<String, dynamic> _$JmaCodeTableParameterCodeTablesToJson(
  _JmaCodeTableParameterCodeTables instance,
) => <String, dynamic>{
  'area_forecast_local_eew': instance.areaForecastLocalEew,
  'area_information_prefecture_earthquake':
      instance.areaInformationPrefectureEarthquake,
  'area_epicenter': instance.areaEpicenter,
  'area_epicenter_abbreviation': instance.areaEpicenterAbbreviation,
  'area_epicenter_detail': instance.areaEpicenterDetail,
};
