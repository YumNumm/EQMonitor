import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart'
    show EarthquakeDatasource, EarthquakeTelegramType, TelegramStatus;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_parameter.freezed.dart';
part 'earthquake_history_parameter.g.dart';

/// 地域検索タイプ
enum RegionSearchType {
  /// 都道府県
  prefecture,

  /// 市区町村
  city,
}

@freezed
abstract class EarthquakeHistoryParameter with _$EarthquakeHistoryParameter {
  const factory EarthquakeHistoryParameter({
    // 基本フィルター
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    JmaIntensity? intensityLte,
    JmaIntensity? intensityGte,
    List<TelegramStatus>? statuses,

    // 震央地名フィルター
    int? epicenterCode,
    String? epicenterName,

    // 地域の震度フィルター
    RegionSearchType? regionSearchType,
    String? regionCode,
    String? regionName,
    JmaIntensity? regionIntensityLte,
    JmaIntensity? regionIntensityGte,

    // 地震種別フィルター
    EarthquakeType? earthquakeType,

    // 発生時刻範囲フィルター
    Date? originTimeGte,
    Date? originTimeLte,

    // 長周期地震動階級フィルター
    JmaLpgmIntensity? maxLpgmIntensityGte,
    JmaLpgmIntensity? maxLpgmIntensityLte,

    // データソースフィルター
    EarthquakeDatasource? datasource,

    // 電文種別フィルター
    List<EarthquakeTelegramType>? telegramTypes,

    // 緯度経度範囲フィルター
    double? latitudeGte,
    double? latitudeLte,
    double? longitudeGte,
    double? longitudeLte,

    // ソート
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  }) = _EarthquakeHistoryParameter;

  const EarthquakeHistoryParameter._();

  factory EarthquakeHistoryParameter.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryParameterFromJson(json);
}

extension EarthquakeHistoryParameterEx on EarthquakeHistoryParameter {
  EarthquakeHistoryParameter updateIntensity(
    JmaIntensity? min,
    JmaIntensity? max,
  ) => copyWith(
    intensityGte: IntensityFilterChip.initialMin == min ? null : min,
    intensityLte: IntensityFilterChip.initialMax == max ? null : max,
  );

  EarthquakeHistoryParameter updateMagnitude(double? min, double? max) =>
      copyWith(
        magnitudeGte: MagnitudeFilterChip.initialMin == min ? null : min,
        magnitudeLte: MagnitudeFilterChip.initialMax == max ? null : max,
      );

  EarthquakeHistoryParameter updateDepth(int? min, int? max) => copyWith(
    depthGte: DepthFilterChip.initialMin == min ? null : min,
    depthLte: DepthFilterChip.initialMax == max ? null : max,
  );

  EarthquakeHistoryParameter updateStatuses(List<TelegramStatus>? statuses) {
    final isDefault =
        statuses == null ||
        const ListEquality<TelegramStatus>().equals(
          statuses,
          StatusFilterChip.initialStatuses,
        );
    return copyWith(statuses: isDefault ? null : statuses);
  }

  EarthquakeHistoryParameter updateEarthquakeType(EarthquakeType? type) =>
      copyWith(earthquakeType: type);

  EarthquakeHistoryParameter updateOriginTimeRange(
    Date? gte,
    Date? lte,
  ) => copyWith(originTimeGte: gte, originTimeLte: lte);

  EarthquakeHistoryParameter updateLpgmIntensity(
    JmaLpgmIntensity? min,
    JmaLpgmIntensity? max,
  ) => copyWith(maxLpgmIntensityGte: min, maxLpgmIntensityLte: max);

  EarthquakeHistoryParameter updateSort(
    EarthquakeSortBy? sortBy,
    SortOrder? sortOrder,
  ) => copyWith(sortBy: sortBy, sortOrder: sortOrder);

  EarthquakeHistoryParameter updateDatasource(EarthquakeDatasource? ds) =>
      copyWith(datasource: ds);

  EarthquakeHistoryParameter updateTelegramTypes(
    List<EarthquakeTelegramType>? types,
  ) => copyWith(telegramTypes: types);

  EarthquakeHistoryParameter updateLatLngRange({
    double? latitudeGte,
    double? latitudeLte,
    double? longitudeGte,
    double? longitudeLte,
  }) => copyWith(
    latitudeGte: latitudeGte,
    latitudeLte: latitudeLte,
    longitudeGte: longitudeGte,
    longitudeLte: longitudeLte,
  );

  EarthquakeHistoryParameter updateRegion({
    required RegionSearchType? regionSearchType,
    required String? regionCode,
    required String? regionName,
    JmaIntensity? regionIntensityGte,
    JmaIntensity? regionIntensityLte,
  }) => copyWith(
    regionSearchType: regionSearchType,
    regionCode: regionCode,
    regionName: regionName,
    regionIntensityGte: regionIntensityGte,
    regionIntensityLte: regionIntensityLte,
  );
}
