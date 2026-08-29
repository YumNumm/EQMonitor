import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_history_map_bounds_calculator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_map_fit_bounds_action.g.dart';

@riverpod
EarthquakeHistoryMapFitBoundsAction earthquakeHistoryMapFitBoundsAction(
  Ref ref,
) => const EarthquakeHistoryMapFitBoundsAction();

class EarthquakeHistoryMapFitBoundsAction {
  const new();

  Future<void> handle({
    required WidgetRef ref,
    required MapController controller,
    required Earthquake earthquake,
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
    final points = calculator
        .calculate(
          earthquake: earthquake,
          regionMap: regionMap,
          dbTree: dbTree,
        )
        .map(
          (point) => Geographic(
            lon: point.longitude,
            lat: point.latitude,
          ),
        )
        .toList();
    if (points.isEmpty) {
      return;
    }
    await controller.fitBounds(
      bounds: LngLatBounds.fromPoints(points),
      padding: const EdgeInsets.all(48),
      webMaxZoom: 10,
    );
  }
}
