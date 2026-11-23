import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_history_map_bounds_calculator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_hypocenter_point.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_camera.dart';
import 'package:eqmonitor/feature/map/data/model/map_camera_bounds.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_map_fit_bounds_action.g.dart';

@riverpod
EarthquakeHistoryMapFitBoundsAction earthquakeHistoryMapFitBoundsAction(
  Ref ref,
) => const EarthquakeHistoryMapFitBoundsAction();

class const EarthquakeHistoryMapFitBoundsAction() {
  Future<MapCameraBounds?> handle({
    required WidgetRef ref,
    required MapController controller,
    required Earthquake earthquake,
    required List<EarthquakeHistoryHypocenterPoint> hypocenterPoints,
    required ShindoDbIntensityTree? dbTree,
  }) async {
    final calculator = ref.read(earthquakeHistoryMapBoundsCalculatorProvider);
    final regionMap =
        calculator.requiresRegionMap(
          earthquake: earthquake,
          dbTree: dbTree,
        )
        ? (await ref.read(jmaMapProvider.future)).areaForecastLocalE
        : null;
    final bounds = const EarthquakeHistoryMapCamera().boundsOf(
      calculator.calculate(
        earthquake: earthquake,
        regionMap: regionMap,
        hypocenterPoints: hypocenterPoints,
        dbTree: dbTree,
      ),
    );
    if (bounds == null) {
      return null;
    }
    await controller.animateCamera(
      CameraUpdate.bounds(
        GeoBox(
          west: bounds.west,
          south: bounds.south,
          east: bounds.east,
          north: bounds.north,
        ),
        padding: const EdgeInsets.all(48),
      ),
    );
    return bounds;
  }
}
