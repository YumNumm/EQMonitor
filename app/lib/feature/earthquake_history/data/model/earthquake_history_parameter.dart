import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show TelegramStatus;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_parameter.freezed.dart';

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
  }) = _EarthquakeHistoryParameter;

  const EarthquakeHistoryParameter._();

  /// 震央地名でのフィルタリングが有効かどうか
  bool get hasEpicenterFilter => epicenterCode != null;

  /// 地域の震度でのフィルタリングが有効かどうか
  bool get hasRegionFilter => regionCode != null;

  /// 特殊なエンドポイントが必要かどうか
  /// （震央地名または地域の震度フィルターが有効な場合）
  bool get requiresSpecialEndpoint => hasEpicenterFilter || hasRegionFilter;
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
}
