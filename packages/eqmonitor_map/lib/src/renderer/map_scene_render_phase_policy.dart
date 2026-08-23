import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';

/// base mapを描画するphase。
final MapRenderPhaseId mapSceneBasePhaseId = createMapRenderPhaseId(
  value: 'base',
);

/// 予報区Fillを描画するphase。
final MapRenderPhaseId mapSceneEarthquakeRegionPhaseId = createMapRenderPhaseId(
  value: 'earthquakeRegion',
);

/// 市区町村Fillを描画するphase。
final MapRenderPhaseId mapSceneEarthquakeCityPhaseId = createMapRenderPhaseId(
  value: 'earthquakeCity',
);

/// 観測点を描画するphase。
final MapRenderPhaseId mapSceneObservationPointPhaseId = createMapRenderPhaseId(
  value: 'observationPoint',
);

/// 1つのSceneへ送る全描画要素が共有するphase policy。
///
/// v1のbase/label専用policyへ地震overlay phaseを追加したためversionを2へ上げる。
final MapRenderPhasePolicy mapSceneRenderPhasePolicy =
    createMapRenderPhasePolicy(
      version: 2,
      orderedPhases: [
        mapSceneBasePhaseId,
        mapSceneEarthquakeRegionPhaseId,
        mapSceneEarthquakeCityPhaseId,
        mapSceneObservationPointPhaseId,
        MapRenderPhaseId.labelForeground,
      ],
    );

/// phaseごとのFlutter Scene translucent sort priority。
int mapSceneTranslucentSortPriorityFor({required int phase}) {
  if (phase == mapSceneRenderPhasePolicy.rankOf(mapSceneBasePhaseId)) {
    return 0;
  }
  if (phase ==
      mapSceneRenderPhasePolicy.rankOf(mapSceneEarthquakeRegionPhaseId)) {
    return 100;
  }
  if (phase ==
      mapSceneRenderPhasePolicy.rankOf(mapSceneEarthquakeCityPhaseId)) {
    return 200;
  }
  if (phase ==
      mapSceneRenderPhasePolicy.rankOf(mapSceneObservationPointPhaseId)) {
    return 300;
  }
  if (phase ==
      mapSceneRenderPhasePolicy.rankOf(MapRenderPhaseId.labelForeground)) {
    return 400;
  }
  throw ArgumentError.value(phase, 'phase', 'is not in the Scene policy');
}

/// [priority]が[phase]に割り当てられた値と一致することを検証する。
void validateMapSceneTranslucentSortPriority({
  required int phase,
  required int priority,
}) {
  final expected = mapSceneTranslucentSortPriorityFor(phase: phase);
  if (priority != expected) {
    throw ArgumentError.value(
      priority,
      'priority',
      'must be $expected for phase $phase',
    );
  }
}
