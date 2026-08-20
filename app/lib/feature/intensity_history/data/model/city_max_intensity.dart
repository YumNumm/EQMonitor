import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/city_max_intensity_entry.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_max_intensity.freezed.dart';

/// 全国の市区町村ごとの観測史上最大震度の集計結果。
///
/// バックエンドが Materialized View に事前集計したものをそのまま受け取る。
/// 観測実績のない市区町村は [items] に含まれない(震度 0 で埋められない)。
@freezed
abstract class CityMaxIntensity with _$CityMaxIntensity {
  const factory({
    /// 集計を最後に更新した時刻。取得できなかった場合は `null`([items] は返る)。
    required DateTime? responseAt,
    required List<CityMaxIntensityEntry> items,
  }) = _CityMaxIntensity;

  const new _();

  /// [cityCode] の観測史上最大震度。観測実績がなければ `null`。
  JmaIntensity? intensityOfCity(String cityCode) =>
      items.where((entry) => entry.cityCode == cityCode).firstOrNull?.intensity;
}

extension CityMaxIntensityResponseApiExtension on api.CityMaxIntensityResponse {
  CityMaxIntensity toAppModel() => CityMaxIntensity(
    responseAt: responseAt,
    items: items.map((item) => item.toAppEntry()).toList(),
  );
}
