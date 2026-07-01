import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'jma_code_table_parameter.freezed.dart';
part 'jma_code_table_parameter.g.dart';

@freezed
abstract class JmaCodeTableParameter with _$JmaCodeTableParameter {
  const factory JmaCodeTableParameter({
    required ParameterMetadata metadata,
    required JmaCodeTableCodeTables codeTables,
  }) = _JmaCodeTableParameter;

  factory JmaCodeTableParameter.fromJson(Map<String, dynamic> json) =>
      _$JmaCodeTableParameterFromJson(json);
}

@freezed
abstract class JmaCodeTableCodeTables with _$JmaCodeTableCodeTables {
  const factory JmaCodeTableCodeTables({
    required List<JmaCodeTableItem> areaForecastLocalEew,
    required List<JmaCodeTableItem> areaInformationPrefectureEarthquake,
    required List<JmaCodeTableCityItem> areaInformationCity,
    required List<JmaCodeTableItem> areaEpicenter,
    required List<JmaCodeTableItem> areaEpicenterAbbreviation,
    required List<JmaCodeTableItem> areaEpicenterDetail,
  }) = _JmaCodeTableCodeTables;

  factory JmaCodeTableCodeTables.fromJson(Map<String, dynamic> json) =>
      _$JmaCodeTableCodeTablesFromJson(json);
}

@freezed
abstract class JmaCodeTableCityItem with _$JmaCodeTableCityItem {
  const factory JmaCodeTableCityItem({
    required String code,
    required LocalizedName name,
    @JsonKey(name: 'parent_area_forecast_local_eew_code')
    required String parentAreaForecastLocalEewCode,
    @JsonKey(name: 'parent_area_information_prefecture_earthquake_code')
    required String parentAreaInformationPrefectureEarthquakeCode,
  }) = _JmaCodeTableCityItem;

  factory JmaCodeTableCityItem.fromJson(Map<String, dynamic> json) =>
      _$JmaCodeTableCityItemFromJson(json);
}

@freezed
abstract class JmaCodeTableItem with _$JmaCodeTableItem {
  const factory JmaCodeTableItem({
    required String code,
    required LocalizedName name,
    required String? kana,
    required String? description,
  }) = _JmaCodeTableItem;

  factory JmaCodeTableItem.fromJson(Map<String, dynamic> json) =>
      _$JmaCodeTableItemFromJson(json);
}
