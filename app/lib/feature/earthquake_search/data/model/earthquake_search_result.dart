import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/station_search_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_search_result.freezed.dart';

/// 検索結果アイテム（各検索タイプで共通のインターフェース）
@freezed
sealed class EarthquakeSearchResultItem with _$EarthquakeSearchResultItem {
  const factory EarthquakeSearchResultItem.region({
    required String eventId,
    required IntensityAreaInfo region,
    required EarthquakePartial earthquake,
  }) = EarthquakeSearchResultItemRegion;

  const factory EarthquakeSearchResultItem.prefecture({
    required String eventId,
    required IntensityAreaInfo prefecture,
    required EarthquakePartial earthquake,
  }) = EarthquakeSearchResultItemPrefecture;

  const factory EarthquakeSearchResultItem.city({
    required String eventId,
    required IntensityAreaInfo city,
    required EarthquakePartial earthquake,
  }) = EarthquakeSearchResultItemCity;

  const factory EarthquakeSearchResultItem.station({
    required String eventId,
    required StationSearchInfo station,
    required EarthquakePartial earthquake,
  }) = EarthquakeSearchResultItemStation;
}

extension EarthquakeSearchResultItemEx on EarthquakeSearchResultItem {
  EarthquakePartial get earthquakePartial => switch (this) {
    EarthquakeSearchResultItemRegion(:final earthquake) => earthquake,
    EarthquakeSearchResultItemPrefecture(:final earthquake) => earthquake,
    EarthquakeSearchResultItemCity(:final earthquake) => earthquake,
    EarthquakeSearchResultItemStation(:final earthquake) => earthquake,
  };

  /// この地域/観測点での震度
  JmaIntensity? get localIntensity => switch (this) {
    EarthquakeSearchResultItemRegion(:final region) => region.intensity,
    EarthquakeSearchResultItemPrefecture(:final prefecture) =>
      prefecture.intensity,
    EarthquakeSearchResultItemCity(:final city) => city.intensity,
    EarthquakeSearchResultItemStation(:final station) => station.intensity,
  };

  /// この地域/観測点での長周期地震動階級
  JmaLpgmIntensity? get localLpgmIntensity => switch (this) {
    EarthquakeSearchResultItemRegion(:final region) => region.lpgmIntensity,
    EarthquakeSearchResultItemPrefecture(:final prefecture) =>
      prefecture.lpgmIntensity,
    EarthquakeSearchResultItemCity(:final city) => city.lpgmIntensity,
    EarthquakeSearchResultItemStation(:final station) => station.lpgmIntensity,
  };
}
