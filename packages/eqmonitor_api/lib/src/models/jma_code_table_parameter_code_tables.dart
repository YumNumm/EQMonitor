// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_code_table_area_forecast_local_eew_item.dart';
import 'jma_code_table_item.dart';

part 'jma_code_table_parameter_code_tables.freezed.dart';
part 'jma_code_table_parameter_code_tables.g.dart';

@Freezed()
abstract class JmaCodeTableParameterCodeTables with _$JmaCodeTableParameterCodeTables {
  const factory JmaCodeTableParameterCodeTables({
    @JsonKey(name: 'area_forecast_local_eew')
    required List<JmaCodeTableAreaForecastLocalEewItem> areaForecastLocalEew,
    @JsonKey(name: 'area_information_prefecture_earthquake')
    required List<JmaCodeTableItem> areaInformationPrefectureEarthquake,
    @JsonKey(name: 'area_epicenter')
    required List<JmaCodeTableItem> areaEpicenter,
    @JsonKey(name: 'area_epicenter_abbreviation')
    required List<JmaCodeTableItem> areaEpicenterAbbreviation,
    @JsonKey(name: 'area_epicenter_detail')
    required List<JmaCodeTableItem> areaEpicenterDetail,
  }) = _JmaCodeTableParameterCodeTables;
  
  factory JmaCodeTableParameterCodeTables.fromJson(Map<String, Object?> json) => _$JmaCodeTableParameterCodeTablesFromJson(json);
}
