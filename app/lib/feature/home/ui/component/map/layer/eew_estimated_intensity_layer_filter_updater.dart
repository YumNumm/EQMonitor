import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:maplibre/maplibre.dart';

class EewEstimatedIntensityLayerFilterUpdater {
  const new();

  static const _areaFilterBuilder = EewAreaFilterBuilder();

  Future<void> update({
    required StyleController styleController,
    required List<EewForecastRegionInfo> regionMaxIntensities,
  }) async {
    await JmaIntensity.values
        .where((intensity) => intensity != JmaIntensity.unknown)
        .map((intensity) {
          final codes = regionMaxIntensities
              .where((r) => r.intensity == intensity)
              .map((r) => r.code)
              .toList();
          return styleController.updateFilter(
            id: intensity.layerId,
            filter: _areaFilterBuilder.build(codes),
          );
        })
        .wait;
  }
}

extension EewEstimatedIntensityJmaIntensityLayerId on JmaIntensity {
  String get layerId => 'eew-estimated-intensity-fill-$name';
}
