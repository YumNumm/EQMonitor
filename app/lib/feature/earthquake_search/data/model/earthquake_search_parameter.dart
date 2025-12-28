import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:eqmonitor/core/component/chip/status_filter_chip.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_search_parameter.freezed.dart';

/// 検索タイプ
enum EarthquakeSearchType {
  /// 震度細分区域
  region,

  /// 都道府県
  prefecture,

  /// 市区町村
  city,

  /// 観測点
  station,
}

extension EarthquakeSearchTypeEx on EarthquakeSearchType {
  String get label => switch (this) {
    EarthquakeSearchType.region => '細分化地域',
    EarthquakeSearchType.prefecture => '都道府県',
    EarthquakeSearchType.city => '市区町村',
    EarthquakeSearchType.station => '観測点',
  };
}

@freezed
abstract class EarthquakeSearchParameter with _$EarthquakeSearchParameter {
  const factory EarthquakeSearchParameter({
    required EarthquakeSearchType type,
    required String code,
    required String name,
    double? magnitudeLte,
    double? magnitudeGte,
    int? depthLte,
    int? depthGte,
    IntensityValue? intensityLte,
    IntensityValue? intensityGte,
    List<TelegramStatus>? statuses,
  }) = _EarthquakeSearchParameter;
}

extension EarthquakeSearchParameterEx on EarthquakeSearchParameter {
  EarthquakeSearchParameter updateIntensity(
    IntensityValue? min,
    IntensityValue? max,
  ) => copyWith(
    intensityGte: IntensityFilterChip.initialMin == min ? null : min,
    intensityLte: IntensityFilterChip.initialMax == max ? null : max,
  );

  EarthquakeSearchParameter updateMagnitude(double? min, double? max) =>
      copyWith(
        magnitudeGte: MagnitudeFilterChip.initialMin == min ? null : min,
        magnitudeLte: MagnitudeFilterChip.initialMax == max ? null : max,
      );

  EarthquakeSearchParameter updateDepth(int? min, int? max) => copyWith(
    depthGte: DepthFilterChip.initialMin == min ? null : min,
    depthLte: DepthFilterChip.initialMax == max ? null : max,
  );

  EarthquakeSearchParameter updateStatuses(List<TelegramStatus>? statuses) {
    final isDefault =
        statuses == null ||
        const ListEquality<TelegramStatus>().equals(
          statuses,
          StatusFilterChip.initialStatuses,
        );
    return copyWith(statuses: isDefault ? null : statuses);
  }
}
