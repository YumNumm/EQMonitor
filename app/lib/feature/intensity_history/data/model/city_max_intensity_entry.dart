import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_max_intensity_entry.freezed.dart';

/// 1 市区町村の観測史上最大震度。
@freezed
abstract class CityMaxIntensityEntry with _$CityMaxIntensityEntry {
  const factory({
    /// 気象庁防災情報XMLフォーマットの市区町村コード(7桁)。
    required String cityCode,

    /// この市区町村で観測された史上最大震度。
    required JmaIntensity intensity,
  }) = _CityMaxIntensityEntry;
}

extension CityMaxIntensityItemApiExtension on api.CityMaxIntensityItem {
  CityMaxIntensityEntry toAppEntry() => CityMaxIntensityEntry(
    cityCode: cityId,
    intensity: maxIntensity.toJmaIntensity,
  );
}
