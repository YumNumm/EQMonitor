import 'dart:async';
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
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch_builder.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math.dart';

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

final class _RecordingSceneGraph with scene.SceneGraph {
  final children = <scene.Node>[];

  @override
  void add(scene.Node child) => children.add(child);

  @override
  void addAll(Iterable<scene.Node> children) => this.children.addAll(children);

  @override
  void addMesh(scene.Mesh mesh) => add(scene.Node(mesh: mesh));

  @override
  void remove(scene.Node child) => children.remove(child);

  @override
  void removeAll() => children.clear();
}

final class _TestMaterialBinding implements FlutterSceneMapMaterialBinding {
  _TestMaterialBinding({required this.parameters})
    : material = scene.UnlitMaterial();

  @override
  final scene.Material material;

  @override
  final scene.MaterialParameters parameters;
}

final class _TestObservationMaterialBinding
    implements FlutterSceneObservationMaterialBinding {
  _TestObservationMaterialBinding({this.preflightError})
    : material = scene.ShaderMaterial(isOpaqueOverride: false);

  final Error? preflightError;

  @override
  final scene.ShaderMaterial material;

  var _preflightCount = 0;

  int get preflightCount => _preflightCount;

  @override
  void preflight({required ObservationPointBatch batch}) {
    _preflightCount++;
    final error = preflightError;
    if (error != null) {
      throw error;
    }
  }

  @override
  void setFrameUniform(ByteData bytes) {
    material.setUniformBlock(
      observationFrameUniformBlockName,
      bytes,
      stage: scene.ShaderStage.vertex,
    );
  }
}

ObservationPointBatch _requireObservationPointBatch(
  ObservationPointBatch? batch,
) {
  if (batch == null) {
    fail('Expected a non-null ObservationPointBatch.');
  }
  return batch;
}

scene.StaticInstanceGeometry _requireStaticInstanceGeometry(
  scene.Geometry? geometry,
) {
  if (geometry is! scene.StaticInstanceGeometry) {
    fail('Expected a StaticInstanceGeometry.');
  }
  return geometry;
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
    phase: mapSceneRenderPhasePolicy.rankOf(mapSceneBaseLandFillPhaseId),
    materialKey: 'countriesFill',
    pipelineKey: baseMapFillPipelineKey.key,
  );

  MapRenderSubmission regionSubmission({
    String materialKey = earthquakeAreaFillMaterialKey,
  }) => submission(
    policy: mapSceneRenderPhasePolicy,
    phase: mapSceneRenderPhasePolicy.rankOf(mapSceneOverlayHazardFillPhaseId),
    materialKey: materialKey,
    pipelineKey: earthquakeAreaFillPipelineKey.key,
  );

  MapRenderSubmission citySubmission() => submission(
    policy: mapSceneRenderPhasePolicy,
    phase: mapSceneRenderPhasePolicy.rankOf(mapSceneOverlayHazardFillPhaseId),
    materialKey: earthquakeAreaFillMaterialKey,
    pipelineKey: earthquakeAreaFillPipelineKey.key,
  );

  MapRenderSubmission emptySubmission() =>
      createMapRenderSubmission(frame: frame, batches: const []);

  final observationClock = SystemMapClock.start(
    domain: createMapClockDomainId(value: 'observation-adapter-test'),
  );

  MapFrameSnapshot observationFrameAt({
    required int frameNumber,
    double centerLongitude = 139.7,
    int contextGeneration = 0,
  }) => captureMapFrameSnapshot(
    clock: observationClock,
    frameNumber: frameNumber,
    camera: MapCamera(
      centerLongitude: centerLongitude,
      centerLatitude: 35.7,
      zoom: 6,
    ),
    viewport: MapViewport(
      logicalSize: const Size(400, 800),
      devicePixelRatio: 2,
    ),
    revisions: const [],
    lifecycle: MapAppLifecycle.active,
    contextGeneration: contextGeneration,
  );

  EarthquakeMapOverlaySnapshot observationSnapshot({
    required int dataSequence,
    Color stationColor = const Color(0xFFFF0000),
  }) => createEarthquakeMapOverlaySnapshot(
    versionStamp: createMapOverlayVersionStamp(
      sourceIdentity: createMapSourceIdentity(value: 'event-1'),
      sourceIncarnation: createMapSourceIncarnation(value: 'incarnation-1'),
      dataSequence: dataSequence,
      dataDigest: 'data-$dataSequence',
      renderGeneration: dataSequence,
      renderDigest: 'render-$dataSequence',
    ),
    regionToCityZoom: 6,
    stationMinZoom: 6,
    regionStyles: const [],
    cityStyles: const [],
    stations: [
      EarthquakeObservationPoint(
        id: 'tokyo',
        longitude: 139.6917,
        latitude: 35.6895,
        color: stationColor,
        radiusLogicalPixels: 8,
      ),
    ],
    spriteAtlas: null,
    sprites: const [],
    maxSpritePolicyBatches: 1,
  );

  MapSceneFrameSubmission observationSubmission({
    required MapFrameSnapshot frame,
    required ObservationPointBatch? batch,
  }) => MapSceneFrameSubmission(
    baseMap: createMapRenderSubmission(frame: frame, batches: const []),
    earthquakeFill: createMapRenderSubmission(
      frame: frame,
      batches: const [],
    ),
    observationBatch: batch,
  );

  test('builds one canonical base then region plan with phase priorities', () {
    final value = MapSceneFrameSubmission(
      baseMap: baseSubmission(),
      earthquakeFill: regionSubmission(),
      observationBatch: null,
    );

    final plans = buildFlutterSceneMeshBatchPlans(submission: value);

    expect(plans.map((plan) => plan.batch.compatibility.phase), [0, 100]);
    expect(plans.map((plan) => plan.translucentSortPriority), [0, 100]);
  });

  test('assigns city Fill to the overlay hazard phase', () {
    final value = MapSceneFrameSubmission(
      baseMap: baseSubmission(),
      earthquakeFill: citySubmission(),
      observationBatch: null,
    );

    final plans = buildFlutterSceneMeshBatchPlans(submission: value);

    expect(plans.last.translucentSortPriority, 100);
  });

  test('writes the phase priority to an actual Flutter Scene node', () {
    final node = scene.Node();

    applyFlutterSceneTranslucentSortPriority(
      node: node,
      phase: mapSceneRenderPhasePolicy.rankOf(
        mapSceneOverlayHazardFillPhaseId,
      ),
      priority: 100,
    );

    expect(node.translucentSortPriority, 100);
  });

  test('rejects a phase not permitted for the base submission', () {
    final foreignPhase = createMapRenderPhaseId(value: 'foreign');
    final foreignPolicy = createMapRenderPhasePolicy(
      version: mapSceneRenderPhasePolicy.version,
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
        foreignPhase,
      ],
      phaseRanks: const [0, 20, 30, 40, 100, 110, 200, 210, 300, 350, 400, 500],
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
      mapSceneLivePointPhaseId,
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

  test('rejects a non-typed observation batch before Scene mutation', () {
    final observationPhase = mapSceneRenderPhasePolicy.rankOf(
      mapSceneLivePointPhaseId,
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
      throwsArgumentError,
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

  test('adds exactly one observation geometry and node at priority 300', () {
    final observationFrame = observationFrameAt(frameNumber: 0);
    final batch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: observationFrame,
        snapshot: observationSnapshot(dataSequence: 1),
      ),
    );
    final sceneGraph = _RecordingSceneGraph();
    final observationMaterial = _TestObservationMaterialBinding();
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      observationMaterial: observationMaterial,
      maxFramesInFlight: 2,
    );

    adapter.submitFrame(
      submission: observationSubmission(
        frame: observationFrame,
        batch: batch,
      ),
    );

    expect(sceneGraph.children, hasLength(1));
    expect(sceneGraph.children.single.translucentSortPriority, 300);
    expect(
      sceneGraph.children.single.mesh?.primitives.single.geometry,
      isA<scene.StaticInstanceGeometry>(),
    );
    expect(adapter.uploadedObservationGeometryCount, 1);
    expect(adapter.liveObservationGeometryCount, 1);
    expect(observationMaterial.preflightCount, 1);
  });

  test(
    'same version stamp keeps geometry identity and changes only frame uniform',
    () {
      final firstFrame = observationFrameAt(frameNumber: 0);
      final snapshot = observationSnapshot(dataSequence: 1);
      final firstBatch = _requireObservationPointBatch(
        buildObservationPointBatch(
          frame: firstFrame,
          snapshot: snapshot,
        ),
      );
      final secondFrame = observationFrameAt(
        frameNumber: 1,
        centerLongitude: 140,
      );
      final secondBatch = _requireObservationPointBatch(
        buildObservationPointBatch(
          frame: secondFrame,
          snapshot: snapshot,
          previous: firstBatch,
        ),
      );
      final sceneGraph = _RecordingSceneGraph();
      final observationMaterial = _TestObservationMaterialBinding();
      final adapter = FlutterSceneMapAdapter(
        sceneGraph: sceneGraph,
        materialFor: (_) => null,
        observationMaterial: observationMaterial,
        maxFramesInFlight: 2,
      );

      adapter.submitFrame(
        submission: observationSubmission(frame: firstFrame, batch: firstBatch),
      );
      final firstGeometry =
          sceneGraph.children.single.mesh?.primitives.single.geometry;
      final firstUniform = observationMaterial.material.getUniformBlock(
        observationFrameUniformBlockName,
        stage: scene.ShaderStage.vertex,
      );
      adapter.submitFrame(
        submission: observationSubmission(
          frame: secondFrame,
          batch: secondBatch,
        ),
      );
      final secondGeometry =
          sceneGraph.children.single.mesh?.primitives.single.geometry;
      final secondUniform = observationMaterial.material.getUniformBlock(
        observationFrameUniformBlockName,
        stage: scene.ShaderStage.vertex,
      );

      expect(secondGeometry, same(firstGeometry));
      expect(adapter.uploadedObservationGeometryCount, 1);
      expect(secondUniform, same(secondBatch.frameUniform));
      expect(secondUniform, isNot(same(firstUniform)));
    },
  );

  test('same version stamp with changed color creates new geometry', () {
    final firstFrame = observationFrameAt(frameNumber: 0);
    final firstBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: firstFrame,
        snapshot: observationSnapshot(dataSequence: 1),
      ),
    );
    final secondFrame = observationFrameAt(frameNumber: 1);
    final secondBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: secondFrame,
        snapshot: observationSnapshot(
          dataSequence: 1,
          stationColor: const Color(0xFF0000FF),
        ),
        previous: firstBatch,
      ),
    );
    final sceneGraph = _RecordingSceneGraph();
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      observationMaterial: _TestObservationMaterialBinding(),
      maxFramesInFlight: 2,
    );

    adapter.submitFrame(
      submission: observationSubmission(frame: firstFrame, batch: firstBatch),
    );
    final firstGeometry =
        sceneGraph.children.single.mesh?.primitives.single.geometry;
    adapter.submitFrame(
      submission: observationSubmission(
        frame: secondFrame,
        batch: secondBatch,
      ),
    );

    expect(
      sceneGraph.children.single.mesh?.primitives.single.geometry,
      isNot(same(firstGeometry)),
    );
    expect(adapter.uploadedObservationGeometryCount, 2);
  });

  test(
    'material preflight failure leaves Scene and geometry state untouched',
    () {
      final observationFrame = observationFrameAt(frameNumber: 0);
      final batch = _requireObservationPointBatch(
        buildObservationPointBatch(
          frame: observationFrame,
          snapshot: observationSnapshot(dataSequence: 1),
        ),
      );
      final sceneGraph = _RecordingSceneGraph();
      final existingNode = scene.Node();
      sceneGraph.add(existingNode);
      final adapter = FlutterSceneMapAdapter(
        sceneGraph: sceneGraph,
        materialFor: (_) => null,
        observationMaterial: _TestObservationMaterialBinding(
          preflightError: StateError('ObservationFrame is unavailable'),
        ),
        maxFramesInFlight: 2,
      );

      expect(
        () => adapter.submitFrame(
          submission: observationSubmission(
            frame: observationFrame,
            batch: batch,
          ),
        ),
        throwsStateError,
      );
      expect(sceneGraph.children, [same(existingNode)]);
      expect(adapter.uploadedObservationGeometryCount, 0);
      expect(adapter.retiredObservationGeometryCount, 0);
      expect(adapter.liveObservationGeometryCount, 0);
    },
  );

  test('retires replaced observation geometry after frames in flight', () {
    final firstFrame = observationFrameAt(frameNumber: 0);
    final firstBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: firstFrame,
        snapshot: observationSnapshot(dataSequence: 1),
      ),
    );
    final secondFrame = observationFrameAt(frameNumber: 1);
    final secondBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: secondFrame,
        snapshot: observationSnapshot(dataSequence: 2),
      ),
    );
    final sceneGraph = _RecordingSceneGraph();
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      observationMaterial: _TestObservationMaterialBinding(),
      maxFramesInFlight: 2,
    );

    adapter.submitFrame(
      submission: observationSubmission(frame: firstFrame, batch: firstBatch),
    );
    final firstGeometry = _requireStaticInstanceGeometry(
      sceneGraph.children.single.mesh?.primitives.single.geometry,
    );
    adapter.submitFrame(
      submission: observationSubmission(
        frame: secondFrame,
        batch: secondBatch,
      ),
    );
    adapter.submitFrame(
      submission: observationSubmission(
        frame: observationFrameAt(frameNumber: 2),
        batch: null,
      ),
    );
    adapter.submitFrame(
      submission: observationSubmission(
        frame: observationFrameAt(frameNumber: 3),
        batch: null,
      ),
    );

    expect(firstGeometry.isRetired, isTrue);
    expect(adapter.retiredObservationGeometryCount, 1);
    expect(adapter.liveObservationGeometryCount, 1);
  });

  test(
    'context generation change creates new geometry before retiring old',
    () {
      final firstFrame = observationFrameAt(frameNumber: 0);
      final snapshot = observationSnapshot(dataSequence: 1);
      final firstBatch = _requireObservationPointBatch(
        buildObservationPointBatch(
          frame: firstFrame,
          snapshot: snapshot,
        ),
      );
      final nextContextFrame = observationFrameAt(
        frameNumber: 1,
        contextGeneration: 1,
      );
      final nextContextBatch = _requireObservationPointBatch(
        buildObservationPointBatch(
          frame: nextContextFrame,
          snapshot: snapshot,
          previous: firstBatch,
        ),
      );
      final sceneGraph = _RecordingSceneGraph();
      final adapter = FlutterSceneMapAdapter(
        sceneGraph: sceneGraph,
        materialFor: (_) => null,
        observationMaterial: _TestObservationMaterialBinding(),
        maxFramesInFlight: 2,
      );

      adapter.submitFrame(
        submission: observationSubmission(frame: firstFrame, batch: firstBatch),
      );
      final firstGeometry = _requireStaticInstanceGeometry(
        sceneGraph.children.single.mesh?.primitives.single.geometry,
      );
      adapter.submitFrame(
        submission: observationSubmission(
          frame: nextContextFrame,
          batch: nextContextBatch,
        ),
      );
      final nextGeometry =
          sceneGraph.children.single.mesh?.primitives.single.geometry;

      expect(nextGeometry, isNot(same(firstGeometry)));
      expect(firstGeometry.isRetired, isFalse);
      expect(adapter.uploadedObservationGeometryCount, 2);
      adapter.submitFrame(
        submission: observationSubmission(
          frame: observationFrameAt(frameNumber: 2, contextGeneration: 1),
          batch: null,
        ),
      );
      adapter.submitFrame(
        submission: observationSubmission(
          frame: observationFrameAt(frameNumber: 3, contextGeneration: 1),
          batch: null,
        ),
      );
      expect(firstGeometry.isRetired, isTrue);
    },
  );

  test('context generation change forbids reuse if an old id reappears', () {
    final firstFrame = observationFrameAt(frameNumber: 0);
    final snapshot = observationSnapshot(dataSequence: 1);
    final firstBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: firstFrame,
        snapshot: snapshot,
      ),
    );
    final sceneGraph = _RecordingSceneGraph();
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      observationMaterial: _TestObservationMaterialBinding(),
      maxFramesInFlight: 2,
    );

    adapter.submitFrame(
      submission: observationSubmission(frame: firstFrame, batch: firstBatch),
    );
    final firstGeometry =
        sceneGraph.children.single.mesh?.primitives.single.geometry;
    for (final (frameNumber, contextGeneration) in const [(1, 1), (2, 0)]) {
      final nextFrame = observationFrameAt(
        frameNumber: frameNumber,
        contextGeneration: contextGeneration,
      );
      adapter.submitFrame(
        submission: observationSubmission(
          frame: nextFrame,
          batch: _requireObservationPointBatch(
            buildObservationPointBatch(
              frame: nextFrame,
              snapshot: snapshot,
              previous: firstBatch,
            ),
          ),
        ),
      );
    }

    expect(
      sceneGraph.children.single.mesh?.primitives.single.geometry,
      isNot(same(firstGeometry)),
    );
    expect(adapter.uploadedObservationGeometryCount, 3);
  });

  test(
    'retire-all waits for captured GPU completion without another submit',
    () async {
      final firstFrame = observationFrameAt(frameNumber: 0);
      final firstBatch = _requireObservationPointBatch(
        buildObservationPointBatch(
          frame: firstFrame,
          snapshot: observationSnapshot(dataSequence: 1),
        ),
      );
      final sceneGraph = _RecordingSceneGraph();
      final completion = Completer<void>();
      late scene.StaticInstanceGeometry geometry;

      void submitThenDisposeAdapter() {
        final adapter = FlutterSceneMapAdapter(
          sceneGraph: sceneGraph,
          materialFor: (_) => null,
          observationMaterial: _TestObservationMaterialBinding(),
          waitForGpuCompletion: () {
            expect(sceneGraph.children, isEmpty);
            return completion.future;
          },
          maxFramesInFlight: 2,
        );
        adapter.submitFrame(
          submission: observationSubmission(
            frame: firstFrame,
            batch: firstBatch,
          ),
        );
        geometry = _requireStaticInstanceGeometry(
          sceneGraph.children.single.mesh?.primitives.single.geometry,
        );
        adapter.retireAllGpuResources();
      }

      submitThenDisposeAdapter();
      expect(geometry.isRetired, isFalse);

      completion.complete();
      await Future<void>.delayed(Duration.zero);
      expect(geometry.isRetired, isTrue);
    },
  );

  test('repeated retire-all requests retire each geometry once', () async {
    final firstFrame = observationFrameAt(frameNumber: 0);
    final firstBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: firstFrame,
        snapshot: observationSnapshot(dataSequence: 1),
      ),
    );
    final sceneGraph = _RecordingSceneGraph();
    final completion = Completer<void>();
    var barrierCount = 0;
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      observationMaterial: _TestObservationMaterialBinding(),
      waitForGpuCompletion: () {
        barrierCount++;
        return completion.future;
      },
      maxFramesInFlight: 2,
    );

    adapter.submitFrame(
      submission: observationSubmission(frame: firstFrame, batch: firstBatch),
    );
    final firstGeometry = _requireStaticInstanceGeometry(
      sceneGraph.children.single.mesh?.primitives.single.geometry,
    );
    adapter.retireAllGpuResources();
    adapter.retireAllGpuResources();

    expect(firstGeometry.isRetired, isFalse);
    expect(barrierCount, 1);
    completion.complete();
    await Future<void>.delayed(Duration.zero);

    expect(firstGeometry.isRetired, isTrue);
    expect(adapter.retiredObservationGeometryCount, 1);
  });

  test('GPU completion error still retires after context loss', () async {
    final firstFrame = observationFrameAt(frameNumber: 0);
    final firstBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: firstFrame,
        snapshot: observationSnapshot(dataSequence: 1),
      ),
    );
    final sceneGraph = _RecordingSceneGraph();
    final completion = Completer<void>();
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      observationMaterial: _TestObservationMaterialBinding(),
      waitForGpuCompletion: () => completion.future,
      maxFramesInFlight: 2,
    );

    adapter.submitFrame(
      submission: observationSubmission(frame: firstFrame, batch: firstBatch),
    );
    final geometry = _requireStaticInstanceGeometry(
      sceneGraph.children.single.mesh?.primitives.single.geometry,
    );
    adapter.retireAllGpuResources();
    completion.completeError(StateError('GPU context lost'));
    await Future<void>.delayed(Duration.zero);

    expect(geometry.isRetired, isTrue);
    expect(adapter.retiredObservationGeometryCount, 1);
  });

  test('fails closed when a live cached geometry was already retired', () {
    final firstFrame = observationFrameAt(frameNumber: 0);
    final snapshot = observationSnapshot(dataSequence: 1);
    final firstBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: firstFrame,
        snapshot: snapshot,
      ),
    );
    final secondFrame = observationFrameAt(frameNumber: 1);
    final secondBatch = _requireObservationPointBatch(
      buildObservationPointBatch(
        frame: secondFrame,
        snapshot: snapshot,
        previous: firstBatch,
      ),
    );
    final sceneGraph = _RecordingSceneGraph();
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      observationMaterial: _TestObservationMaterialBinding(),
      maxFramesInFlight: 2,
    );

    adapter.submitFrame(
      submission: observationSubmission(frame: firstFrame, batch: firstBatch),
    );
    final geometry = _requireStaticInstanceGeometry(
      sceneGraph.children.single.mesh?.primitives.single.geometry,
    );
    geometry.retire();

    expect(
      () => adapter.submitFrame(
        submission: observationSubmission(
          frame: secondFrame,
          batch: secondBatch,
        ),
      ),
      throwsStateError,
    );
  });

  test(
    'unknown later base pipeline leaves material Scene and GPU state intact',
    () {
      final invalidBase = createMapRenderSubmission(
        frame: frame,
        batches: [
          ...baseSubmission().batches,
          ...submission(
            policy: mapSceneRenderPhasePolicy,
            phase: mapSceneRenderPhasePolicy.rankOf(
              mapSceneBaseLandFillPhaseId,
            ),
            materialKey: 'unknownPipeline',
            pipelineKey: 'unknown-base-pipeline',
          ).batches,
        ],
      );
      final value = MapSceneFrameSubmission(
        baseMap: invalidBase,
        earthquakeFill: emptySubmission(),
        observationBatch: null,
      );
      final sceneGraph = _RecordingSceneGraph();
      final existingNode = scene.Node();
      sceneGraph.add(existingNode);
      var materialLookups = 0;
      var existingMaterialParameter = const Color(0xFF123456);
      final adapter = FlutterSceneMapAdapter(
        sceneGraph: sceneGraph,
        materialFor: (_) {
          materialLookups++;
          existingMaterialParameter = const Color(0xFFABCDEF);
          return null;
        },
        maxFramesInFlight: 2,
      );

      expect(
        () => adapter.submitFrame(submission: value),
        throwsArgumentError,
      );
      expect(materialLookups, 0);
      expect(existingMaterialParameter, const Color(0xFF123456));
      expect(sceneGraph.children, [same(existingNode)]);
      expect(adapter.uploadedGeometryCount, 0);
      expect(adapter.retiredGeometryCount, 0);
      expect(adapter.liveGeometryCount, 0);
    },
  );

  test(
    'wrong typed later material leaves all material Scene and GPU state intact',
    () {
      scene.MaterialParameters fillParameters({required scene.FmatType type}) =>
          scene.MaterialParameters.withLayout(
            blockName: 'MaterialParams',
            blockSizeBytes: 16,
            parameters: {
              'fill_color': (
                type: type,
                offset: 0,
                sourceColor: false,
              ),
            },
          );

      final validParameters = fillParameters(type: scene.FmatType.vec4)
        ..setColor('fill_color', const Color(0xFF123456));
      final wrongTypedParameters = fillParameters(type: scene.FmatType.vec2)
        ..setVec2('fill_color', Vector2(0.25, 0.75));
      final validBinding = _TestMaterialBinding(
        parameters: validParameters,
      );
      final wrongTypedBinding = _TestMaterialBinding(
        parameters: wrongTypedParameters,
      );
      final invalidBase = createMapRenderSubmission(
        frame: frame,
        batches: [
          ...baseSubmission().batches,
          ...submission(
            policy: mapSceneRenderPhasePolicy,
            phase: mapSceneRenderPhasePolicy.rankOf(
              mapSceneBaseLandFillPhaseId,
            ),
            materialKey: 'wrongTypedFill',
            pipelineKey: baseMapFillPipelineKey.key,
          ).batches,
        ],
      );
      final value = MapSceneFrameSubmission(
        baseMap: invalidBase,
        earthquakeFill: emptySubmission(),
        observationBatch: null,
      );
      final sceneGraph = _RecordingSceneGraph();
      final existingNode = scene.Node();
      sceneGraph.add(existingNode);
      final adapter = FlutterSceneMapAdapter(
        sceneGraph: sceneGraph,
        materialFor: (batch) =>
            switch (batch.compatibility.batchKey.materialKey) {
              'countriesFill' => validBinding,
              'wrongTypedFill' => wrongTypedBinding,
              _ => null,
            },
        maxFramesInFlight: 2,
      );

      expect(
        () => adapter.submitFrame(submission: value),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('fill_color'),
          ),
        ),
      );
      expect(
        validParameters.assignedValues['fill_color'],
        const Color(0xFF123456),
      );
      expect(
        wrongTypedParameters.assignedValues['fill_color'],
        Vector2(0.25, 0.75),
      );
      expect(sceneGraph.children, [same(existingNode)]);
      expect(adapter.uploadedGeometryCount, 0);
      expect(adapter.retiredGeometryCount, 0);
      expect(adapter.liveGeometryCount, 0);
    },
  );
}
