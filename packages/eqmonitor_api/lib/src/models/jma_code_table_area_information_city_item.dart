// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'localized_name.dart';

part 'jma_code_table_area_information_city_item.freezed.dart';
part 'jma_code_table_area_information_city_item.g.dart';

@Freezed()
abstract class JmaCodeTableAreaInformationCityItem with _$JmaCodeTableAreaInformationCityItem {
  const factory JmaCodeTableAreaInformationCityItem({
    required String code,
    required LocalizedName name,
    @JsonKey(name: 'parent_area_forecast_local_eew_code')
    required String parentAreaForecastLocalEewCode,
    @JsonKey(name: 'parent_area_information_prefecture_earthquake_code')
    required String parentAreaInformationPrefectureEarthquakeCode,
  }) = _JmaCodeTableAreaInformationCityItem;

  factory JmaCodeTableAreaInformationCityItem.fromJson(Map<String, Object?> json) => _$JmaCodeTableAreaInformationCityItemFromJson(json);
}
