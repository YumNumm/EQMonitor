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

const MapRenderPhaseId mapSceneForegroundLabelPhaseId =
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
