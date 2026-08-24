import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';

final MapRenderPhaseId mapSceneBaseLandFillPhaseId = createMapRenderPhaseId(
  value: 'baseLandFill',
);

final MapRenderPhaseId mapSceneUnderlayHazardFillPhaseId =
    createMapRenderPhaseId(value: 'underlayHazardFill');

final MapRenderPhaseId mapSceneUnderlayHazardLinePhaseId =
    createMapRenderPhaseId(value: 'underlayHazardLine');

final MapRenderPhaseId mapSceneBaseAdministrativeLinePhaseId =
    createMapRenderPhaseId(value: 'baseAdministrativeLine');

final MapRenderPhaseId mapSceneOverlayHazardFillPhaseId =
    createMapRenderPhaseId(
      value: 'overlayHazardFill',
    );

final MapRenderPhaseId mapSceneOverlayHazardLinePhaseId =
    createMapRenderPhaseId(
      value: 'overlayHazardLine',
    );

final MapRenderPhaseId mapSceneDynamicWaveFillPhaseId = createMapRenderPhaseId(
  value: 'dynamicWaveFill',
);

final MapRenderPhaseId mapSceneDynamicWaveLinePhaseId = createMapRenderPhaseId(
  value: 'dynamicWaveLine',
);

final MapRenderPhaseId mapSceneLivePointPhaseId = createMapRenderPhaseId(
  value: 'livePoint',
);

final MapRenderPhaseId mapSceneSpritePhaseId = createMapRenderPhaseId(
  value: 'sprite',
);

final MapRenderPhaseId mapSceneForegroundLabelPhaseId =
    MapRenderPhaseId.labelForeground;

/// package-neutralな全描画要素が共有する疎なphase policy。
final MapRenderPhasePolicy mapSceneRenderPhasePolicy =
    createMapRenderPhasePolicy(
      version: 3,
      orderedPhases: [
        mapSceneBaseLandFillPhaseId,
        mapSceneUnderlayHazardFillPhaseId,
        mapSceneUnderlayHazardLinePhaseId,
        mapSceneBaseAdministrativeLinePhaseId,
        mapSceneOverlayHazardFillPhaseId,
        mapSceneOverlayHazardLinePhaseId,
        mapSceneDynamicWaveFillPhaseId,
        mapSceneDynamicWaveLinePhaseId,
        mapSceneLivePointPhaseId,
        mapSceneSpritePhaseId,
        mapSceneForegroundLabelPhaseId,
      ],
      phaseRanks: const [0, 20, 30, 40, 100, 110, 200, 210, 300, 350, 400],
    );

/// phaseごとのFlutter Scene translucent sort priority。
int mapSceneTranslucentSortPriorityFor({required int phase}) {
  if (mapSceneRenderPhasePolicy.containsRank(phase)) {
    return phase;
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
