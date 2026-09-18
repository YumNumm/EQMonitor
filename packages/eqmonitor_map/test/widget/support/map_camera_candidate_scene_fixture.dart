import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';

final class TestMapSceneInstanceBatch implements MapSceneInstanceBatch {
  const TestMapSceneInstanceBatch({
    required this.frame,
    required this.batchKey,
  });

  @override
  final MapFrameSnapshot frame;
  @override
  final MapSceneBatchKey batchKey;
  @override
  int get phasePolicyVersion => mapSceneRenderPhasePolicy.version;
  @override
  int get phase => mapSceneRenderPhasePolicy.rankOf(mapSceneLivePointPhaseId);
}

final class MapCameraCandidateSceneFixture {
  MapCameraCandidateSceneFixture() {
    frame = captureMapFrameSnapshot(
      clock: SystemMapClock.start(
        domain: createMapClockDomainId(value: 'camera-candidate-owner-test'),
      ),
      frameNumber: 0,
      camera: candidate,
      viewport: MapViewport(
        logicalSize: const Size(800, 600),
        devicePixelRatio: 2,
      ),
      revisions: const [],
      lifecycle: MapAppLifecycle.active,
      contextGeneration: 0,
    );
    final version = createMapOverlayVersionStamp(
      sourceIdentity: createMapSourceIdentity(value: 'event-a'),
      sourceIncarnation: createMapSourceIncarnation(value: 'session-a'),
      dataSequence: 1,
      dataDigest: 'data-a',
      renderGeneration: 1,
      renderDigest: 'render-a',
    );
    layers = [
      for (var index = 0; index < 2; index++)
        MapSceneInstanceLayerSubmission(
          logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
          componentKey: mapSceneObservationPointComponentKey,
          overlayVersion: version,
          orderWithinPhase: index,
          kind: MapSceneInstanceLayerKind.observationPoint,
          batch: TestMapSceneInstanceBatch(
            frame: frame,
            batchKey: createMapSceneBatchKey(value: 'observation-$index'),
          ),
        ),
    ];
  }

  static const initial = MapCamera(
    centerLongitude: 139.767,
    centerLatitude: 35.681,
    zoom: 5,
  );
  static const candidate = MapCamera(
    centerLongitude: 141.35,
    centerLatitude: 43.06,
    zoom: 8,
  );

  late final MapFrameSnapshot frame;
  late final List<MapSceneLayerSubmission> layers;

  bool submitOverflow(MapCamera _) {
    MapSceneFrameSubmission(
      frame: frame,
      layers: layers,
      limits: MapSceneFrameLimits(maxNodeCount: 1),
    );
    return true;
  }
}
