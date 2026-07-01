// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_code_table_area_information_city_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JmaCodeTableAreaInformationCityItem
_$JmaCodeTableAreaInformationCityItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_JmaCodeTableAreaInformationCityItem',
      json,
      ($checkedConvert) {
        final val = _JmaCodeTableAreaInformationCityItem(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert(
            'name',
            (v) => LocalizedName.fromJson(v as Map<String, dynamic>),
          ),
          parentAreaForecastLocalEewCode: $checkedConvert(
            'parent_area_forecast_local_eew_code',
            (v) => v as String,
          ),
          parentAreaInformationPrefectureEarthquakeCode: $checkedConvert(
            'parent_area_information_prefecture_earthquake_code',
            (v) => v as String,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'parentAreaForecastLocalEewCode': 'parent_area_forecast_local_eew_code',
        'parentAreaInformationPrefectureEarthquakeCode':
            'parent_area_information_prefecture_earthquake_code',
      },
    );

Map<String, dynamic> _$JmaCodeTableAreaInformationCityItemToJson(
  _JmaCodeTableAreaInformationCityItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'parent_area_forecast_local_eew_code':
      instance.parentAreaForecastLocalEewCode,
  'parent_area_information_prefecture_earthquake_code':
      instance.parentAreaInformationPrefectureEarthquakeCode,
};
