import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_search_response.freezed.dart';
part 'earthquake_search_response.g.dart';

/// ページネーション付き検索レスポンス
@Freezed(genericArgumentFactories: true)
abstract class PaginatedResponse<T extends EarthquakePartial>
    with _$PaginatedResponse<T> {
  const factory({
    required List<T> items,
    required String? nextToken,
  }) = _PaginatedSearchResponse<T>;

  factory fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$PaginatedSearchResponseFromJson(json, fromJsonT);
}

/// 地域震度検索アイテム（都道府県・地域・市区町村共通）
@freezed
abstract class IntensityAreaSearchItem with _$IntensityAreaSearchItem {
  const factory({
    required String eventId,
    required IntensityAreaInfo area,
    required EarthquakePartial earthquake,
  }) = _IntensityAreaSearchItem;

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityAreaSearchItemFromJson(json);
}

/// 観測点震度検索アイテム
@freezed
abstract class StationSearchItem with _$StationSearchItem {
  const factory({
    required String eventId,
    required StationSearchInfo station,
    required EarthquakePartial earthquake,
  }) = _StationSearchItem;

  factory fromJson(Map<String, dynamic> json) =>
      _$StationSearchItemFromJson(json);
}

extension IntensityRegionSearchResponseToApp
    on api.IntensityRegionSearchResponse {
  PaginatedResponse<EarthquakePartialRegion> toAppResponse({
    required EarthquakeParameter parameter,
    required String areaCode,
    required LocalizedName areaName,
  }) => PaginatedResponse(
    items: items
        .map(
          (item) => EarthquakePartialRegion(
            earthquake: item.earthquake.toEarthquakePartial(
              parameter: parameter,
            ),
            regionIntensity: item.intensity.toJmaIntensity,
          ),
        )
        .toList(),
    nextToken: nextToken,
  );
}

extension IntensityPrefectureSearchResponseToApp
    on api.IntensityPrefectureSearchResponse {
  PaginatedResponse<EarthquakePartialPrefecture> toAppResponse({
    required EarthquakeParameter parameter,
    required String areaCode,
    required LocalizedName areaName,
  }) => PaginatedResponse(
    items: items
        .map(
          (item) => EarthquakePartialPrefecture(
            earthquake: item.earthquake.toEarthquakePartial(
              parameter: parameter,
            ),
            prefectureIntensity: item.intensity.toJmaIntensity,
          ),
        )
        .toList(),
    nextToken: nextToken,
  );
}

extension IntensityCitySearchResponseToApp on api.IntensityCitySearchResponse {
  PaginatedResponse<EarthquakePartialRegion> toAppResponse({
    required EarthquakeParameterCityItem cityItem,
    required EarthquakeParameter parameter,
  }) => PaginatedResponse(
    items: items
        .map(
          (item) => EarthquakePartialRegion(
            earthquake: item.earthquake.toEarthquakePartial(
              parameter: parameter,
            ),
            regionIntensity: item.intensity.toJmaIntensity,
          ),
        )
        .toList(),
    nextToken: nextToken,
  );
}

extension IntensityStationSearchResponseToApp
    on api.IntensityStationSearchResponse {
  PaginatedResponse<EarthquakePartialStation> toAppResponse({
    required EarthquakeParameter parameter,
    required String stationCode,
    required LocalizedName stationName,
  }) => PaginatedResponse(
    items: items
        .map(
          (item) => EarthquakePartialStation(
            earthquake: item.earthquake.toEarthquakePartial(
              parameter: parameter,
            ),
            stationIntensity: item.intensity.toJmaIntensity,
          ),
        )
        .toList(),
    nextToken: nextToken,
  );
}
