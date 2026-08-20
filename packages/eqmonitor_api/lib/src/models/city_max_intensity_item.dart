// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_intensity.dart';

part 'city_max_intensity_item.freezed.dart';
part 'city_max_intensity_item.g.dart';

@Freezed()
abstract class CityMaxIntensityItem with _$CityMaxIntensityItem {
  const factory CityMaxIntensityItem({
    /// 市区町村コード（気象庁防災情報XMLフォーマット コード表の7桁コード）
    @JsonKey(name: 'city_id')
    required String cityId,
    @JsonKey(name: 'max_intensity')
    required JmaIntensity maxIntensity,
  }) = _CityMaxIntensityItem;
  
  factory CityMaxIntensityItem.fromJson(Map<String, Object?> json) => _$CityMaxIntensityItemFromJson(json);
}
