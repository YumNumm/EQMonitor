import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

final eewForecastRegionIntensityFilterUpdaterProvider =
    Provider<EewForecastRegionIntensityFilterUpdater>(
      (_) => const EewForecastRegionIntensityFilterUpdater(),
    );

/// EEW震度予報区域レイヤーの震度別 fill layer を管理する。
class EewForecastRegionIntensityFilterUpdater {
  const new();

  static const _areaFilterBuilder = EewAreaFilterBuilder();

  static const List<JmaIntensity> intensityLevels = [
    JmaIntensity.one,
    JmaIntensity.two,
    JmaIntensity.three,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixUnknown,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  String detailLayerId(JmaIntensity intensity) =>
      'eew-details-intensity-fill-${intensity.name}';

  Future<void> update({
    required StyleController styleController,
    required List<EewForecastRegionInfo> regionMaxIntensities,
  }) async {
    await intensityLevels.map((intensity) {
      final codes = regionMaxIntensities
          .where((r) => r.intensity == intensity)
          .map((r) => r.code)
          .toList();
      return styleController.updateFilter(
        id: detailLayerId(intensity),
        filter: _areaFilterBuilder.build(codes),
      );
    }).wait;
  }
}
