import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/location/data/jma_map_isolate.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_map_layers.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_map_matcher.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region_selection_map_action.g.dart';

@riverpod
RegionSelectionMapAction regionSelectionMapAction(Ref ref) =>
    const RegionSelectionMapAction();

final class const RegionSelectionMapAction() {
  Future<List<RegionOption>> resolve({
    required WidgetRef ref,
    required MapController controller,
    required Geographic point,
    required RegionKind kind,
    required List<RegionOption> catalog,
    RegionOption? parent,
  }) async {
    const matcher = RegionMapMatcher();
    if (kind == .epicenter) {
      final features = controller.featuresAtPoint(
        controller.toScreenLocation(point),
        layerIds: const [RegionMapLayers.epicenterHit],
      );
      return matcher.epicenters(
        catalog: catalog,
        ids: features
            .map((feature) => feature.properties['id'])
            .whereType<num>(),
      );
    }
    if (kind == .station) {
      return const [];
    }
    final worker = await ref.read(jmaMapIsolateProvider.future);
    final result = await worker.calculateNearestElement(
      latitude: point.lat,
      longitude: point.lon,
      type: switch (kind) {
        .eewRegion => JmaMapType.areaForecastLocalEew,
        .region => JmaMapType.areaForecastLocalE,
        _ => JmaMapType.areaInformationCity,
      },
    );
    final code = result?.property?.code;
    return code == null
        ? const []
        : matcher.administrative(
            catalog: catalog,
            kind: kind,
            code: code,
            parent: parent,
          );
  }
}
