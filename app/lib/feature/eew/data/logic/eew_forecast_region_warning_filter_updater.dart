import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

final eewForecastRegionWarningFilterUpdaterProvider =
    Provider<EewForecastRegionWarningFilterUpdater>(
      (_) => const EewForecastRegionWarningFilterUpdater(),
    );

/// EEW詳細画面の警報区域 fill / line layer の filter を更新する。
class EewForecastRegionWarningFilterUpdater {
  const new();

  static const fillLayerId = 'eew-details-warning-fill';
  static const lineLayerId = 'eew-details-warning-line';
  static const _areaFilterBuilder = EewAreaFilterBuilder();

  Future<void> update({
    required StyleController styleController,
    required List<String> warningCodes,
  }) async {
    final filter = _areaFilterBuilder.build(warningCodes);
    for (final id in [fillLayerId, lineLayerId]) {
      await styleController.updateFilter(id: id, filter: filter);
    }
  }
}
