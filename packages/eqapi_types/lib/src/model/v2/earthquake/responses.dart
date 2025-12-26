import 'package:eqapi_types/src/model/v2/earthquake/earthquake.dart';
import 'package:eqapi_types/src/model/v2/enum/intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'responses.freezed.dart';
part 'responses.g.dart';

/// 地震一覧レスポンス
@freezed
abstract class EarthquakeListResponse with _$EarthquakeListResponse {
  const factory EarthquakeListResponse({
    required List<EarthquakePartial> items,
    String? nextToken,
    String? nextPooling,
  }) = _EarthquakeListResponse;

  factory EarthquakeListResponse.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeListResponseFromJson(json);
}

/// 地震詳細レスポンス
@freezed
abstract class EarthquakeDetailResponse with _$EarthquakeDetailResponse {
  const factory EarthquakeDetailResponse({
    required Earthquake earthquake,
  }) = _EarthquakeDetailResponse;

  factory EarthquakeDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeDetailResponseFromJson(json);
}

/// 震度検索用の地域情報
@freezed
abstract class IntensityRegionInfo with _$IntensityRegionInfo {
  const factory IntensityRegionInfo({
    required String code,
    required String name,
    IntensityValue? intensity,
    LpgmIntensityValue? lpgmIntensity,
  }) = _IntensityRegionInfo;

  factory IntensityRegionInfo.fromJson(Map<String, dynamic> json) =>
      _$IntensityRegionInfoFromJson(json);
}

/// 震度検索用の観測点情報
@freezed
abstract class IntensityStationInfo with _$IntensityStationInfo {
  const factory IntensityStationInfo({
    required String code,
    required String name,
    IntensityValue? intensity,
    LpgmIntensityValue? lpgmIntensity,
    double? sva,
    List<IntensityStationPrePeriod>? prePeriods,
  }) = _IntensityStationInfo;

  factory IntensityStationInfo.fromJson(Map<String, dynamic> json) =>
      _$IntensityStationInfoFromJson(json);
}

/// 観測点の周期帯情報（検索用）
@freezed
abstract class IntensityStationPrePeriod with _$IntensityStationPrePeriod {
  const factory IntensityStationPrePeriod({
    required int band,
    required String lpgmIntensity,
    required double sva,
  }) = _IntensityStationPrePeriod;

  factory IntensityStationPrePeriod.fromJson(Map<String, dynamic> json) =>
      _$IntensityStationPrePeriodFromJson(json);
}

/// 震度細分区域検索レスポンスの項目
@freezed
abstract class IntensityRegionSearchItem with _$IntensityRegionSearchItem {
  const factory IntensityRegionSearchItem({
    required String eventId,
    required IntensityRegionInfo region,
    required EarthquakePartial earthquake,
  }) = _IntensityRegionSearchItem;

  factory IntensityRegionSearchItem.fromJson(Map<String, dynamic> json) =>
      _$IntensityRegionSearchItemFromJson(json);
}

/// 都道府県検索レスポンスの項目
@freezed
abstract class IntensityPrefectureSearchItem
    with _$IntensityPrefectureSearchItem {
  const factory IntensityPrefectureSearchItem({
    required String eventId,
    required IntensityRegionInfo prefecture,
    required EarthquakePartial earthquake,
  }) = _IntensityPrefectureSearchItem;

  factory IntensityPrefectureSearchItem.fromJson(Map<String, dynamic> json) =>
      _$IntensityPrefectureSearchItemFromJson(json);
}

/// 市区町村検索レスポンスの項目
@freezed
abstract class IntensityCitySearchItem with _$IntensityCitySearchItem {
  const factory IntensityCitySearchItem({
    required String eventId,
    required IntensityRegionInfo city,
    required EarthquakePartial earthquake,
  }) = _IntensityCitySearchItem;

  factory IntensityCitySearchItem.fromJson(Map<String, dynamic> json) =>
      _$IntensityCitySearchItemFromJson(json);
}

/// 観測点検索レスポンスの項目
@freezed
abstract class IntensityStationSearchItem with _$IntensityStationSearchItem {
  const factory IntensityStationSearchItem({
    required String eventId,
    required IntensityStationInfo station,
    required EarthquakePartial earthquake,
  }) = _IntensityStationSearchItem;

  factory IntensityStationSearchItem.fromJson(Map<String, dynamic> json) =>
      _$IntensityStationSearchItemFromJson(json);
}

/// 震度細分区域検索レスポンス
@freezed
abstract class IntensityRegionSearchResponse
    with _$IntensityRegionSearchResponse {
  const factory IntensityRegionSearchResponse({
    required List<IntensityRegionSearchItem> items,
    String? nextToken,
    String? nextPooling,
  }) = _IntensityRegionSearchResponse;

  factory IntensityRegionSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$IntensityRegionSearchResponseFromJson(json);
}

/// 都道府県検索レスポンス
@freezed
abstract class IntensityPrefectureSearchResponse
    with _$IntensityPrefectureSearchResponse {
  const factory IntensityPrefectureSearchResponse({
    required List<IntensityPrefectureSearchItem> items,
    String? nextToken,
    String? nextPooling,
  }) = _IntensityPrefectureSearchResponse;

  factory IntensityPrefectureSearchResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$IntensityPrefectureSearchResponseFromJson(json);
}

/// 市区町村検索レスポンス
@freezed
abstract class IntensityCitySearchResponse with _$IntensityCitySearchResponse {
  const factory IntensityCitySearchResponse({
    required List<IntensityCitySearchItem> items,
    String? nextToken,
    String? nextPooling,
  }) = _IntensityCitySearchResponse;

  factory IntensityCitySearchResponse.fromJson(Map<String, dynamic> json) =>
      _$IntensityCitySearchResponseFromJson(json);
}

/// 観測点検索レスポンス
@freezed
abstract class IntensityStationSearchResponse
    with _$IntensityStationSearchResponse {
  const factory IntensityStationSearchResponse({
    required List<IntensityStationSearchItem> items,
    String? nextToken,
    String? nextPooling,
  }) = _IntensityStationSearchResponse;

  factory IntensityStationSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$IntensityStationSearchResponseFromJson(json);
}
