// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_code_table_area_forecast_local_eew_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JmaCodeTableAreaForecastLocalEewItem
_$JmaCodeTableAreaForecastLocalEewItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_JmaCodeTableAreaForecastLocalEewItem', json, (
      $checkedConvert,
    ) {
      final val = _JmaCodeTableAreaForecastLocalEewItem(
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

Map<String, dynamic> _$JmaCodeTableAreaForecastLocalEewItemToJson(
  _JmaCodeTableAreaForecastLocalEewItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'kana': instance.kana,
  'description': instance.description,
};
