import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_telegram_body_intensity_region_model.freezed.dart';

/// 震度地域（都道府県 / 市区町村）1件分のドメインモデル
@freezed
abstract class EarthquakeTelegramBodyIntensityRegionModel
    with _$EarthquakeTelegramBodyIntensityRegionModel {
  const factory EarthquakeTelegramBodyIntensityRegionModel({
    required String code,
    required String name,
    JmaIntensity? intensity,
  }) = _EarthquakeTelegramBodyIntensityRegionModel;
}

extension EarthquakeTelegramBodyIntensityRegionApiExtension
    on api.EarthquakeTelegramBodyIntensityRegion {
  EarthquakeTelegramBodyIntensityRegionModel
  toEarthquakeTelegramBodyIntensityRegionModel() =>
      EarthquakeTelegramBodyIntensityRegionModel(
        code: code,
        name: name,
        intensity: intensity?.toJmaIntensity,
      );
}
