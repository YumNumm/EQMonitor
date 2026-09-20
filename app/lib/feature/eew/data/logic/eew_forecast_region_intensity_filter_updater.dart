import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_forecast_region_intensity_filter_updater.g.dart';

@Riverpod(keepAlive: true)
EewForecastRegionIntensityFilterUpdater eewForecastRegionIntensityFilterUpdater(
  Ref ref,
) => const EewForecastRegionIntensityFilterUpdater();

class const EewForecastRegionIntensityFilterUpdater() {
  Future<void> update({
    required StyleController styleController,
    required List<EewForecastRegionInfo> regionMaxIntensities,
  }) async => await JmaIntensity.values
      .map<Future<void>?>((intensity) {
        final codes = regionMaxIntensities
            .where((r) => r.intensity == intensity)
            .map((r) => r.code)
            .toList();
        if (codes.isEmpty) {
          return null;
        }
        return styleController.updateFilter(
          id: 'eew-details-intensity-fill-${intensity.name}',
          filter: <Object>[
            'in',
            ['get', 'code'],
            ['literal', codes],
          ],
        );
      })
      .nonNulls
      .wait;
}
