import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_sort_key.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:flutter_test/flutter_test.dart';

final class _ObservationBatch implements MapSceneObservationBatch {
  const _ObservationBatch({
    required this.frame,
    required this.phasePolicyVersion,
    required this.phase,
    required this.translucentSortPriority,
  });

  @override
  final MapFrameSnapshot frame;

  @override
  final int phasePolicyVersion;

  @override
  final int phase;

  @override
  final int translucentSortPriority;
}

void main() {
  final frame = captureMapFrameSnapshot(
    clock: SystemMapClock.start(
      domain: createMapClockDomainId(value: 'scene-map-adapter-test'),
    ),
    frameNumber: 11,
    camera: const MapCamera(
      centerLongitude: 139.7,
      centerLatitude: 35.7,
      zoom: 5,
    ),
    viewport: MapViewport(
      logicalSize: const Size(400, 800),
      devicePixelRatio: 2,
    ),
    revisions: const [],
    lifecycle: MapAppLifecycle.active,
    contextGeneration: 0,
  );
  final packedMesh = packBaseMapFillMesh(
    FillMesh(
      positions: Float32List.fromList([0, 0, 1, 0, 0, 1]),
      indices: Uint16List.fromList([0, 1, 2]),
      vertexCount: 3,
    ),
  );

  MapRenderSubmission submission({
    required MapRenderPhasePolicy policy,
    required int phase,
    required String materialKey,
    required String pipelineKey,
  }) {
    final packet = createMapRenderPacket(
      contractVersion: 1,
      sortKey: MapRenderSortKey(
        phasePolicyVersion: policy.version,
        phase: phase,
        declarationOrderWithinPhase: 0,
        sourceOrder: 0,
        overscaledTileOrder: 0,
        featureOrder: 0,
      ),
      batchKey: createMapRenderBatchKey(
        version: 1,
        nodeKey: createMapNodeKey(value: 'test-node'),
        scopeKey: 'test-scope',
        materialKey: materialKey,
        phasePolicyVersion: policy.version,
        phase: phase,
      ),
      pipeline: createMapRenderPipelineKey(version: 1, key: pipelineKey),
      mesh: packedMesh,
      modelTransform: Float64List.fromList([
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
      ]),
      materialParameters: createMapMaterialParameterBlock(
        version: 1,
        bytes: Uint8List(16),
      ),
    );
    return createMapRenderSubmission(
      frame: frame,
      batches: [
        createMapRenderBatch(version: 1, policy: policy, packets: [packet]),
      ],
    );
  }

  MapRenderSubmission baseSubmission() => submission(
    policy: mapSceneRenderPhasePolicy,
    phase: mapSceneRenderPhasePolicy.rankOf(mapSceneBasePhaseId),
    materialKey: 'countriesFill',
    pipelineKey: baseMapFillPipelineKey.key,
  );

  MapRenderSubmission regionSubmission({
    String materialKey = earthquakeAreaFillMaterialKey,
  }) => submission(
    policy: mapSceneRenderPhasePolicy,
    phase: mapSceneRenderPhasePolicy.rankOf(mapSceneEarthquakeRegionPhaseId),
    materialKey: materialKey,
    pipelineKey: earthquakeAreaFillPipelineKey.key,
  );

  MapRenderSubmission citySubmission() => submission(
    policy: mapSceneRenderPhasePolicy,
    phase: mapSceneRenderPhasePolicy.rankOf(mapSceneEarthquakeCityPhaseId),
    materialKey: earthquakeAreaFillMaterialKey,
    pipelineKey: earthquakeAreaFillPipelineKey.key,
  );

  MapRenderSubmission emptySubmission() =>
      createMapRenderSubmission(frame: frame, batches: const []);

  test('builds one canonical base then region plan with phase priorities', () {
    final value = MapSceneFrameSubmission(
      baseMap: baseSubmission(),
      earthquakeFill: regionSubmission(),
      observationBatch: null,
    );

    final plans = buildFlutterSceneMeshBatchPlans(submission: value);

    expect(plans.map((plan) => plan.batch.compatibility.phase), [0, 1]);
    expect(plans.map((plan) => plan.translucentSortPriority), [0, 100]);
  });

  test('assigns city Fill priority 200', () {
    final value = MapSceneFrameSubmission(
      baseMap: baseSubmission(),
      earthquakeFill: citySubmission(),
      observationBatch: null,
    );

    final plans = buildFlutterSceneMeshBatchPlans(submission: value);

    expect(plans.last.translucentSortPriority, 200);
  });

  test('writes the phase priority to an actual Flutter Scene node', () {
    final node = scene.Node();

    applyFlutterSceneTranslucentSortPriority(
      node: node,
      phase: mapSceneRenderPhasePolicy.rankOf(
        mapSceneEarthquakeRegionPhaseId,
      ),
      priority: 100,
    );

    expect(node.translucentSortPriority, 100);
  });

  test('rejects region and city Fill phases in the same frame', () {
    final bothFillPhases = createMapRenderSubmission(
      frame: frame,
      batches: [
        ...regionSubmission().batches,
        ...citySubmission().batches,
      ],
    );

    expect(
      () => MapSceneFrameSubmission(
        baseMap: baseSubmission(),
        earthquakeFill: bothFillPhases,
        observationBatch: null,
      ),
      throwsArgumentError,
    );
  });

  test('rejects a phase not permitted for the base submission', () {
    final foreignPhase = createMapRenderPhaseId(value: 'foreign');
    final foreignPolicy = createMapRenderPhasePolicy(
      version: mapSceneRenderPhasePolicy.version,
      orderedPhases: [
        mapSceneBasePhaseId,
        mapSceneEarthquakeRegionPhaseId,
        mapSceneEarthquakeCityPhaseId,
        mapSceneObservationPointPhaseId,
        foreignPhase,
        MapRenderPhaseId.labelForeground,
      ],
    );
    final invalidBase = submission(
      policy: foreignPolicy,
      phase: foreignPolicy.rankOf(foreignPhase),
      materialKey: 'countriesFill',
      pipelineKey: baseMapFillPipelineKey.key,
    );

    expect(
      () => MapSceneFrameSubmission(
        baseMap: invalidBase,
        earthquakeFill: emptySubmission(),
        observationBatch: null,
      ),
      throwsArgumentError,
    );
  });

  test('rejects an unknown earthquake material before node creation', () {
    expect(
      () => MapSceneFrameSubmission(
        baseMap: baseSubmission(),
        earthquakeFill: regionSubmission(materialKey: 'unknown'),
        observationBatch: null,
      ),
      throwsArgumentError,
    );
  });

  test('rejects an observation batch whose priority disagrees with phase', () {
    final observationPhase = mapSceneRenderPhasePolicy.rankOf(
      mapSceneObservationPointPhaseId,
    );

    expect(
      () => MapSceneFrameSubmission(
        baseMap: baseSubmission(),
        earthquakeFill: emptySubmission(),
        observationBatch: _ObservationBatch(
          frame: frame,
          phasePolicyVersion: mapSceneRenderPhasePolicy.version,
          phase: observationPhase,
          translucentSortPriority: 999,
        ),
      ),
      throwsArgumentError,
    );
  });

  test('fails closed for a non-null observation batch until Task 7', () {
    final observationPhase = mapSceneRenderPhasePolicy.rankOf(
      mapSceneObservationPointPhaseId,
    );
    final value = MapSceneFrameSubmission(
      baseMap: baseSubmission(),
      earthquakeFill: emptySubmission(),
      observationBatch: _ObservationBatch(
        frame: frame,
        phasePolicyVersion: mapSceneRenderPhasePolicy.version,
        phase: observationPhase,
        translucentSortPriority: 300,
      ),
    );

    expect(
      () => buildFlutterSceneMeshBatchPlans(submission: value),
      throwsUnsupportedError,
    );
  });

  test('base builder uses the same phase policy as earthquake fill', () {
    expect(
      baseSubmission().batches.single.compatibility.phasePolicyVersion,
      mapSceneRenderPhasePolicy.version,
    );
    expect(
      regionSubmission().batches.single.compatibility.phasePolicyVersion,
      mapSceneRenderPhasePolicy.version,
    );
  });
}
