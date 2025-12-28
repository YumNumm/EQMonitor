import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_search_result.freezed.dart';

/// 検索結果アイテム（各検索タイプで共通のインターフェース）
@freezed
sealed class EarthquakeSearchResultItem with _$EarthquakeSearchResultItem {
  const factory EarthquakeSearchResultItem.region({
    required String eventId,
    required IntensityRegionInfo region,
    required EarthquakePartial earthquake,
  }) = EarthquakeSearchResultItemRegion;

  const factory EarthquakeSearchResultItem.prefecture({
    required String eventId,
    required IntensityRegionInfo prefecture,
    required EarthquakePartial earthquake,
  }) = EarthquakeSearchResultItemPrefecture;

  const factory EarthquakeSearchResultItem.city({
    required String eventId,
    required IntensityRegionInfo city,
    required EarthquakePartial earthquake,
  }) = EarthquakeSearchResultItemCity;

  const factory EarthquakeSearchResultItem.station({
    required String eventId,
    required IntensityStationInfo station,
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
  IntensityValue? get localIntensity => switch (this) {
    EarthquakeSearchResultItemRegion(:final region) => region.intensity,
    EarthquakeSearchResultItemPrefecture(:final prefecture) =>
      prefecture.intensity,
    EarthquakeSearchResultItemCity(:final city) => city.intensity,
    EarthquakeSearchResultItemStation(:final station) => station.intensity,
  };

  /// この地域/観測点での長周期地震動階級
  LpgmIntensityValue? get localLpgmIntensity => switch (this) {
    EarthquakeSearchResultItemRegion(:final region) => region.lpgmIntensity,
    EarthquakeSearchResultItemPrefecture(:final prefecture) =>
      prefecture.lpgmIntensity,
    EarthquakeSearchResultItemCity(:final city) => city.lpgmIntensity,
    EarthquakeSearchResultItemStation(:final station) => station.lpgmIntensity,
  };
}
