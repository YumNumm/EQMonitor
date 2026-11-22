import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:maplibre/maplibre.dart';

class const EewEstimatedIntensityLayerFilterUpdater() {
  static const _areaFilterBuilder = EewAreaFilterBuilder();

  Future<void> update({
    required StyleController styleController,
    required List<EewForecastRegionInfo> regionMaxIntensities,
  }) async {
    for (final intensity in JmaIntensity.values) {
      if (intensity == JmaIntensity.unknown) {
        continue;
      }
      final codes = regionMaxIntensities
          .where((r) => r.intensity == intensity)
          .map((r) => r.code)
          .toList();
      styleController.layers[intensity.layerId]?.filter = .raw(
        _areaFilterBuilder.build(codes),
      );
    }
  }
}

extension EewEstimatedIntensityJmaIntensityLayerId on JmaIntensity {
  String get layerId => 'eew-estimated-intensity-fill-$name';
}
