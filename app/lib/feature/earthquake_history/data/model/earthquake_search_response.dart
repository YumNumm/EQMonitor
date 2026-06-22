import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/station_search_info.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_search_response.freezed.dart';
part 'earthquake_search_response.g.dart';

/// ページネーション付き検索レスポンス
@Freezed(genericArgumentFactories: true)
abstract class PaginatedSearchResponse<T> with _$PaginatedSearchResponse<T> {
  const factory PaginatedSearchResponse({
    required List<T> items,
    required String? nextToken,
  }) = _PaginatedSearchResponse<T>;

  factory PaginatedSearchResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$PaginatedSearchResponseFromJson(json, fromJsonT);
}

/// 地域震度検索アイテム（都道府県・地域・市区町村共通）
@freezed
abstract class IntensityAreaSearchItem with _$IntensityAreaSearchItem {
  const factory IntensityAreaSearchItem({
    required String eventId,
    required IntensityAreaInfo area,
    required EarthquakePartial earthquake,
  }) = _IntensityAreaSearchItem;

  factory IntensityAreaSearchItem.fromJson(Map<String, dynamic> json) =>
      _$IntensityAreaSearchItemFromJson(json);
}

/// 観測点震度検索アイテム
@freezed
abstract class StationSearchItem with _$StationSearchItem {
  const factory StationSearchItem({
    required String eventId,
    required StationSearchInfo station,
    required EarthquakePartial earthquake,
  }) = _StationSearchItem;

  factory StationSearchItem.fromJson(Map<String, dynamic> json) =>
      _$StationSearchItemFromJson(json);
}

// ---------------------------------------------------------------------------
// API → App 変換 extensions
// ---------------------------------------------------------------------------

extension IntensityRegionSearchResponseToApp
    on api.IntensityRegionSearchResponse {
  PaginatedSearchResponse<IntensityAreaSearchItem> toAppResponse({
    required EarthquakeParameter parameter,
    required String areaCode,
    required String areaName,
  }) => PaginatedSearchResponse(
    items: items
        .map(
          (e) => IntensityAreaSearchItem(
            eventId: e.earthquake.eventId,
            area: IntensityAreaInfo(
              code: areaCode,
              name: areaName,
              intensity: e.intensity.toJmaIntensity,
              lpgmIntensity: null,
            ),
            earthquake: e.earthquake.toEarthquakePartial(parameter: parameter),
          ),
        )
        .toList(),
    nextToken: nextToken,
  );
}

extension IntensityPrefectureSearchResponseToApp
    on api.IntensityPrefectureSearchResponse {
  PaginatedSearchResponse<IntensityAreaSearchItem> toAppResponse({
    required EarthquakeParameter parameter,
    required String areaCode,
    required String areaName,
  }) => PaginatedSearchResponse(
    items: items
        .map(
          (e) => IntensityAreaSearchItem(
            eventId: e.earthquake.eventId,
            area: IntensityAreaInfo(
              code: areaCode,
              name: areaName,
              intensity: e.intensity.toJmaIntensity,
              lpgmIntensity: null,
            ),
            earthquake: e.earthquake.toEarthquakePartial(parameter: parameter),
          ),
        )
        .toList(),
    nextToken: nextToken,
  );
}

extension IntensityCitySearchResponseToApp on api.IntensityCitySearchResponse {
  PaginatedSearchResponse<IntensityAreaSearchItem> toAppResponse({
    required EarthquakeParameter parameter,
    required String areaCode,
    required String areaName,
  }) => PaginatedSearchResponse(
    items: items
        .map(
          (e) => IntensityAreaSearchItem(
            eventId: e.earthquake.eventId,
            area: IntensityAreaInfo(
              code: areaCode,
              name: areaName,
              intensity: e.intensity.toJmaIntensity,
              lpgmIntensity: null,
            ),
            earthquake: e.earthquake.toEarthquakePartial(parameter: parameter),
          ),
        )
        .toList(),
    nextToken: nextToken,
  );
}

extension IntensityStationSearchResponseToApp
    on api.IntensityStationSearchResponse {
  PaginatedSearchResponse<StationSearchItem> toAppResponse({
    required EarthquakeParameter parameter,
    required String stationCode,
    required String stationName,
  }) => PaginatedSearchResponse(
    items: items
        .map(
          (e) => StationSearchItem(
            eventId: e.earthquake.eventId,
            station: StationSearchInfo(
              code: stationCode,
              name: stationName,
              intensity: e.intensity.toJmaIntensity,
              lpgmIntensity: null,
              sva: null,
              prePeriods: null,
            ),
            earthquake: e.earthquake.toEarthquakePartial(parameter: parameter),
          ),
        )
        .toList(),
    nextToken: nextToken,
  );
}
