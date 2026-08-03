// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'localized_name.dart';

part 'jma_code_table_area_forecast_local_eew_item.freezed.dart';
part 'jma_code_table_area_forecast_local_eew_item.g.dart';

@Freezed()
abstract class JmaCodeTableAreaForecastLocalEewItem with _$JmaCodeTableAreaForecastLocalEewItem {
  const factory JmaCodeTableAreaForecastLocalEewItem({
    required String code,
    required LocalizedName name,
    @JsonKey(includeIfNull: true)
    required String? kana,
    @JsonKey(includeIfNull: true)
    required String? description,
  }) = _JmaCodeTableAreaForecastLocalEewItem;

  factory JmaCodeTableAreaForecastLocalEewItem.fromJson(Map<String, Object?> json) => _$JmaCodeTableAreaForecastLocalEewItemFromJson(json);
}
