import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_map_adapter.dart';
import 'package:eqmonitor_map/src/flutter_scene/map_gpu_probe.dart';
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
import 'package:eqmonitor_map/src/overlay/map_point_sprite_feature.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/overlay/map_zoom_scalar_policy.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch_builder.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch_builder.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:flutter_scene/src/scene_encoder.dart' as scene_encoder;
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math.dart';

final class _TestInstanceBatch implements MapSceneInstanceBatch {
  const _TestInstanceBatch({
    required this.frame,
    required this.batchKey,
    required this.phasePolicyVersion,
    required this.phase,
  });

  @override
  final MapFrameSnapshot frame;

  @override
  final MapSceneBatchKey batchKey;

  @override
  final int phasePolicyVersion;

  @override
  final int phase;
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

final class _TestSpritePreparedFrame
    implements FlutterSceneSpritePreparedSceneFrame {
  _TestSpritePreparedFrame({required this.nodes});

  @override
  final List<FlutterSceneSpritePreparedSceneNode> nodes;

  var _commitCount = 0;
  var _rollbackCount = 0;

  int get commitCount => _commitCount;
  int get rollbackCount => _rollbackCount;

  @override
  void commit() {
    _commitCount++;
  }

  @override
  void rollback() {
    _rollbackCount++;
  }
}

final class _TestSpriteFrameResources
    implements FlutterSceneSpriteFrameResources {
  _TestSpriteFrameResources({this.prepareError});

  final Error? prepareError;
  _TestSpritePreparedFrame? prepared;
  final preparedFrames = <_TestSpritePreparedFrame>[];
  var _retireAllCount = 0;

  int get retireAllCount => _retireAllCount;

  @override
  FlutterSceneSpritePreparedSceneFrame prepareFrame({
    required MapFrameSnapshot frame,
    required List<MapPointSpriteInstanceBatch> batches,
  }) {
    final error = prepareError;
    if (error != null) {
      throw error;
    }
    final value = _TestSpritePreparedFrame(
      nodes: [
        for (final batch in batches)
          FlutterSceneSpritePreparedSceneNode(
            batch: batch,
            node: scene.Node(),
          ),
      ],
    );
    prepared = value;
    preparedFrames.add(value);
    return value;
  }

  @override
  void retireAll() {
    _retireAllCount++;
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
    int packetCount = 1,
  }) {
    return createMapRenderSubmission(
      frame: frame,
      batches: [
        createMapRenderBatch(
          version: 1,
          policy: policy,
          packets: [
            for (var index = 0; index < packetCount; index++)
              createMapRenderPacket(
                contractVersion: 1,
                sortKey: MapRenderSortKey(
                  phasePolicyVersion: policy.version,
                  phase: phase,
                  declarationOrderWithinPhase: 0,
                  sourceOrder: 0,
                  overscaledTileOrder: 0,
                  featureOrder: index,
                ),
                batchKey: createMapRenderBatchKey(
                  version: 1,
                  nodeKey: createMapNodeKey(value: 'test-node'),
                  scopeKey: 'test-scope',
                  materialKey: materialKey,
                  phasePolicyVersion: policy.version,
                  phase: phase,
                ),
                pipeline: createMapRenderPipelineKey(
                  version: 1,
                  key: pipelineKey,
                ),
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
              ),
          ],
        ),
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

  MapOverlayVersionStamp stampOf(int sequence) => createMapOverlayVersionStamp(
    sourceIdentity: createMapSourceIdentity(value: 'event-1'),
    sourceIncarnation: createMapSourceIncarnation(value: 'incarnation-1'),
    dataSequence: sequence,
    dataDigest: 'data-$sequence',
    renderGeneration: sequence,
    renderDigest: 'render-$sequence',
  );

  MapPointSpriteInstanceBatch spriteBatch({
    required MapFrameSnapshot spriteFrame,
  }) {
    final atlas = createMapSpriteAtlas(
      identity: createMapSourceIdentity(value: 'sprite-atlas'),
      width: 4,
      height: 4,
      rgbaBytes: Uint8List(64),
      regions: const [
        MapSpriteRegion(
          id: 'hypocenter',
          normalizedUv: Rect.fromLTRB(0.125, 0.125, 0.375, 0.375),
          logicalSize: Size(24, 24),
        ),
      ],
      limits: const MapSpriteAtlasLimits(
        maxWidth: 4,
        maxHeight: 4,
        maxPixelBytes: 64,
        maxRegions: 1,
      ),
    );
    return buildMapPointSpriteBatches(
      frame: spriteFrame,
      versionStamp: stampOf(1),
      atlas: atlas,
      features: [
        createMapPointSpriteFeature(
          id: 'hypocenter:event-1',
          longitude: 139.7,
          latitude: 35.7,
          spriteRegionId: 'hypocenter',
          sizeScale: createMapZoomLinearRange(
            startZoom: 3,
            startValue: 0.5,
            endZoom: 20,
            endValue: 1.5,
          ),
          opacity: createMapZoomStep(
            thresholdZoom: 5,
            belowValue: 0,
            atOrAboveValue: 1,
          ),
          priority: 1,
        ),
      ],
      maxPolicyBatches: 1,
    ).single;
  }

  MapSceneMeshLayerSubmission meshLayer({
    required MapSceneComponentKey componentKey,
    required MapRenderSubmission submission,
    MapOverlayVersionStamp? overlayVersion,
    MapSceneLogicalSourceKey? logicalSourceKey,
    int orderWithinPhase = 0,
  }) => MapSceneMeshLayerSubmission(
    frame: submission.frame,
    logicalSourceKey: logicalSourceKey ?? mapSceneEarthquakeHistorySourceKey,
    componentKey: componentKey,
    overlayVersion: overlayVersion,
    orderWithinPhase: orderWithinPhase,
    batch: submission.batches.single,
    kind: componentKey == mapSceneBaseComponentKey
        ? MapSceneMeshLayerKind.baseMap
        : MapSceneMeshLayerKind.earthquakeAreaFill,
  );

  MapSceneInstanceLayerSubmission instanceLayer({
    required MapFrameSnapshot layerFrame,
    required MapSceneComponentKey componentKey,
    required MapSceneBatchKey batchKey,
    required MapOverlayVersionStamp overlayVersion,
    required MapSceneInstanceLayerKind kind,
    required int phase,
    int phasePolicyVersion = 3,
    int orderWithinPhase = 0,
  }) => MapSceneInstanceLayerSubmission(
    logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
    componentKey: componentKey,
    overlayVersion: overlayVersion,
    orderWithinPhase: orderWithinPhase,
    kind: kind,
    batch: _TestInstanceBatch(
      frame: layerFrame,
      batchKey: batchKey,
      phasePolicyVersion: phasePolicyVersion,
      phase: phase,
    ),
  );

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
    frame: frame,
    layers: [
      if (batch != null)
        MapSceneInstanceLayerSubmission(
          logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
          componentKey: mapSceneObservationPointComponentKey,
          overlayVersion: batch.versionStamp,
          orderWithinPhase: 0,
          kind: MapSceneInstanceLayerKind.observationPoint,
          batch: batch,
        ),
    ],
    limits: MapSceneFrameLimits(maxNodeCount: 1),
  );

  MapSceneFrameSubmission sceneSubmission({
    MapRenderSubmission? baseMap,
    MapRenderSubmission? earthquakeFill,
    MapSceneComponentKey? earthquakeComponent,
  }) {
    final base = baseMap ?? emptySubmission();
    final earthquake = earthquakeFill ?? emptySubmission();
    return MapSceneFrameSubmission(
      frame: frame,
      layers: [
        for (final batch in base.batches)
          MapSceneMeshLayerSubmission(
            frame: frame,
            logicalSourceKey: mapSceneBaseSourceKey,
            componentKey: mapSceneBaseComponentKey,
            overlayVersion: null,
            orderWithinPhase:
                batch.packets.first.sortKey.declarationOrderWithinPhase,
            batch: batch,
            kind: MapSceneMeshLayerKind.baseMap,
          ),
        for (final batch in earthquake.batches)
          MapSceneMeshLayerSubmission(
            frame: frame,
            logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
            componentKey: earthquakeComponent ?? mapSceneRegionFillComponentKey,
            overlayVersion: stampOf(1),
            orderWithinPhase:
                batch.packets.first.sortKey.declarationOrderWithinPhase,
            batch: batch,
            kind: MapSceneMeshLayerKind.earthquakeAreaFill,
          ),
      ],
      limits: MapSceneFrameLimits(maxNodeCount: 64),
    );
  }

  group('typed Scene layer submission', () {
    final stamp1 = observationSnapshot(dataSequence: 1).versionStamp;
    final stamp2 = observationSnapshot(dataSequence: 2).versionStamp;

    test('rejects blank logical source, component, and batch keys', () {
      expect(
        () => createMapSceneLogicalSourceKey(value: ' '),
        throwsArgumentError,
      );
      expect(() => createMapSceneComponentKey(value: ''), throwsArgumentError);
      expect(() => createMapSceneBatchKey(value: '\n'), throwsArgumentError);
    });

    test('owns an immutable canonical layer list', () {
      final layers = <MapSceneLayerSubmission>[
        instanceLayer(
          layerFrame: frame,
          componentKey: mapSceneHypocenterSpriteComponentKey,
          batchKey: createMapSceneBatchKey(value: 'sprite'),
          overlayVersion: stamp1,
          kind: MapSceneInstanceLayerKind.pointSprite,
          phase: 350,
        ),
        meshLayer(
          componentKey: mapSceneBaseComponentKey,
          submission: baseSubmission(),
          logicalSourceKey: mapSceneBaseSourceKey,
        ),
        instanceLayer(
          layerFrame: frame,
          componentKey: mapSceneObservationPointComponentKey,
          batchKey: createMapSceneBatchKey(value: 'observation'),
          overlayVersion: stamp1,
          kind: MapSceneInstanceLayerKind.observationPoint,
          phase: 300,
        ),
      ];

      final value = MapSceneFrameSubmission(
        frame: frame,
        layers: layers,
        limits: MapSceneFrameLimits(maxNodeCount: 3),
      );
      layers.clear();

      expect(value.layers.map((layer) => layer.phase), [0, 300, 350]);
      expect(value.layers.clear, throwsUnsupportedError);
    });

    test('rejects frame mismatch and negative order', () {
      final otherFrame = observationFrameAt(frameNumber: 99);
      expect(
        () => MapSceneFrameSubmission(
          frame: otherFrame,
          layers: [
            meshLayer(
              componentKey: mapSceneBaseComponentKey,
              submission: baseSubmission(),
              logicalSourceKey: mapSceneBaseSourceKey,
            ),
          ],
          limits: MapSceneFrameLimits(maxNodeCount: 1),
        ),
        throwsArgumentError,
      );
      expect(
        () => meshLayer(
          componentKey: mapSceneBaseComponentKey,
          submission: baseSubmission(),
          logicalSourceKey: mapSceneBaseSourceKey,
          orderWithinPhase: -1,
        ),
        throwsArgumentError,
      );
    });

    test('rejects mixed overlay stamps and duplicate identity tuples', () {
      final observation = instanceLayer(
        layerFrame: frame,
        componentKey: mapSceneObservationPointComponentKey,
        batchKey: createMapSceneBatchKey(value: 'observation'),
        overlayVersion: stamp1,
        kind: MapSceneInstanceLayerKind.observationPoint,
        phase: 300,
      );
      final sprite = instanceLayer(
        layerFrame: frame,
        componentKey: mapSceneHypocenterSpriteComponentKey,
        batchKey: createMapSceneBatchKey(value: 'sprite'),
        overlayVersion: stamp2,
        kind: MapSceneInstanceLayerKind.pointSprite,
        phase: 350,
      );
      expect(
        () => MapSceneFrameSubmission(
          frame: frame,
          layers: [observation, sprite],
          limits: MapSceneFrameLimits(maxNodeCount: 2),
        ),
        throwsArgumentError,
      );
      expect(
        () => MapSceneFrameSubmission(
          frame: frame,
          layers: [observation, observation],
          limits: MapSceneFrameLimits(maxNodeCount: 2),
        ),
        throwsArgumentError,
      );
    });

    test('allows distinct batch keys for one component', () {
      final layers = [
        for (final key in ['policy-a', 'policy-b'])
          instanceLayer(
            layerFrame: frame,
            componentKey: mapSceneHypocenterSpriteComponentKey,
            batchKey: createMapSceneBatchKey(value: key),
            overlayVersion: stamp1,
            kind: MapSceneInstanceLayerKind.pointSprite,
            phase: 350,
          ),
      ];

      expect(
        MapSceneFrameSubmission(
          frame: frame,
          layers: layers,
          limits: MapSceneFrameLimits(maxNodeCount: 2),
        ).layers,
        hasLength(2),
      );
    });

    test(
      'compares phase, order, logical source, component, then batch key',
      () {
        MapSceneInstanceLayerSubmission layer({
          required String source,
          required String component,
          required String batch,
          required int phase,
          required int order,
        }) => MapSceneInstanceLayerSubmission(
          logicalSourceKey: createMapSceneLogicalSourceKey(value: source),
          componentKey: createMapSceneComponentKey(value: component),
          overlayVersion: stamp1,
          orderWithinPhase: order,
          kind: MapSceneInstanceLayerKind.pointSprite,
          batch: _TestInstanceBatch(
            frame: frame,
            batchKey: createMapSceneBatchKey(value: batch),
            phasePolicyVersion: 3,
            phase: phase,
          ),
        );
        final values = [
          layer(source: 'b', component: 'a', batch: 'a', phase: 350, order: 0),
          layer(source: 'a', component: 'b', batch: 'a', phase: 350, order: 0),
          layer(source: 'a', component: 'a', batch: 'b', phase: 350, order: 0),
          layer(source: 'a', component: 'a', batch: 'a', phase: 350, order: 1),
          layer(source: 'a', component: 'a', batch: 'a', phase: 300, order: 9),
          layer(source: 'a', component: 'a', batch: 'a', phase: 350, order: 0),
        ]..sort(compareMapSceneLayerSubmissions);

        expect(
          values.map(
            (value) => (
              value.phase,
              value.orderWithinPhase,
              value.logicalSourceKey.value,
              value.componentKey.value,
              value.batchKey.value,
            ),
          ),
          [
            (300, 9, 'a', 'a', 'a'),
            (350, 0, 'a', 'a', 'a'),
            (350, 0, 'a', 'a', 'b'),
            (350, 0, 'a', 'b', 'a'),
            (350, 0, 'b', 'a', 'a'),
            (350, 1, 'a', 'a', 'a'),
          ],
        );
      },
    );

    test(
      'rejects region and city together, phase mismatch, and node overflow',
      () {
        final region = meshLayer(
          componentKey: mapSceneRegionFillComponentKey,
          submission: regionSubmission(),
          overlayVersion: stamp1,
        );
        final city = meshLayer(
          componentKey: mapSceneCityFillComponentKey,
          submission: citySubmission(),
          overlayVersion: stamp1,
        );
        expect(
          () => MapSceneFrameSubmission(
            frame: frame,
            layers: [region, city],
            limits: MapSceneFrameLimits(maxNodeCount: 2),
          ),
          throwsArgumentError,
        );
        expect(
          () => MapSceneFrameSubmission(
            frame: frame,
            layers: [
              instanceLayer(
                layerFrame: frame,
                componentKey: mapSceneObservationPointComponentKey,
                batchKey: createMapSceneBatchKey(value: 'wrong-phase'),
                overlayVersion: stamp1,
                kind: MapSceneInstanceLayerKind.observationPoint,
                phase: 350,
              ),
            ],
            limits: MapSceneFrameLimits(maxNodeCount: 1),
          ),
          throwsArgumentError,
        );
        expect(
          () => MapSceneFrameSubmission(
            frame: frame,
            layers: [
              instanceLayer(
                layerFrame: frame,
                componentKey: mapSceneObservationPointComponentKey,
                batchKey: createMapSceneBatchKey(value: 'wrong-policy'),
                overlayVersion: stamp1,
                kind: MapSceneInstanceLayerKind.observationPoint,
                phase: 300,
                phasePolicyVersion: 2,
              ),
            ],
            limits: MapSceneFrameLimits(maxNodeCount: 1),
          ),
          throwsArgumentError,
        );
        expect(
          () => MapSceneFrameSubmission(
            frame: frame,
            layers: [
              meshLayer(
                componentKey: mapSceneBaseComponentKey,
                submission: baseSubmission(),
                logicalSourceKey: mapSceneBaseSourceKey,
              ),
              region,
            ],
            limits: MapSceneFrameLimits(maxNodeCount: 1),
          ),
          throwsA(
            isA<MapSceneFrameValidationException>().having(
              (error) => error.reason,
              'reason',
              MapSceneFrameValidationFailureReason.nodeCountExceeded,
            ),
          ),
        );
      },
    );

    test('allows a base-only submission', () {
      final value = MapSceneFrameSubmission(
        frame: frame,
        layers: [
          meshLayer(
            componentKey: mapSceneBaseComponentKey,
            submission: baseSubmission(),
            logicalSourceKey: mapSceneBaseSourceKey,
          ),
        ],
        limits: MapSceneFrameLimits(maxNodeCount: 1),
      );

      expect(value.layers.single.componentKey, mapSceneBaseComponentKey);
    });
  });

  test('builds one canonical base then region mesh plan', () {
    final value = sceneSubmission(
      baseMap: baseSubmission(),
      earthquakeFill: regionSubmission(),
    );

    final plans = buildFlutterSceneMeshBatchPlans(submission: value);

    expect(plans.map((plan) => plan.batch.compatibility.phase), [0, 100]);
  });

  test('assigns city Fill to the overlay hazard mesh plan', () {
    final value = sceneSubmission(
      baseMap: baseSubmission(),
      earthquakeFill: citySubmission(),
      earthquakeComponent: mapSceneCityFillComponentKey,
    );

    final plans = buildFlutterSceneMeshBatchPlans(submission: value);

    expect(plans.last.batch.compatibility.phase, 100);
  });

  test(
    'preserves same-phase multi-packet ranks through the Scene comparator',
    () {
      final first = submission(
        policy: mapSceneRenderPhasePolicy,
        phase: 0,
        materialKey: 'a-fill',
        pipelineKey: baseMapFillPipelineKey.key,
        packetCount: 2,
      );
      final second = submission(
        policy: mapSceneRenderPhasePolicy,
        phase: 0,
        materialKey: 'b-fill',
        pipelineKey: baseMapFillPipelineKey.key,
      );
      final value = sceneSubmission(
        baseMap: createMapRenderSubmission(
          frame: frame,
          batches: [...first.batches, ...second.batches],
        ),
      );

      final plans = buildFlutterSceneNodePlans(submission: value);
      expect(plans.map((plan) => plan.drawRank), [0, 1, 2]);

      final encodedOrder = scene_encoder.sortSceneTranslucentRecordsForTesting(
        [
          for (final index in const [2, 0, 1])
            (
              priority: plans[index].drawRank,
              depth: 42.0,
              id: switch (plans[index]) {
                FlutterSceneMeshNodePlan(:final layer, :final packetIndex) =>
                  '${layer.batch.compatibility.batchKey.materialKey}:'
                      '$packetIndex',
                FlutterSceneObservationNodePlan() => 'observation',
                FlutterSceneSpriteNodePlan() => 'sprite',
              },
            ),
        ],
      );
      expect(encodedOrder.map((record) => record.id), [
        'a-fill:0',
        'a-fill:1',
        'b-fill:0',
      ]);
    },
  );

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
      () => sceneSubmission(baseMap: invalidBase),
      throwsArgumentError,
    );
  });

  test('rejects an unknown earthquake pipeline before node creation', () {
    final unknown = submission(
      policy: mapSceneRenderPhasePolicy,
      phase: mapSceneRenderPhasePolicy.rankOf(
        mapSceneOverlayHazardFillPhaseId,
      ),
      materialKey: earthquakeAreaFillMaterialKey,
      pipelineKey: 'unknown-earthquake-pipeline',
    );
    expect(
      () => sceneSubmission(
        baseMap: baseSubmission(),
        earthquakeFill: unknown,
      ),
      throwsA(isA<MapSceneMeshPipelineMismatch>()),
    );
  });

  test('rejects a non-typed observation batch before Scene mutation', () {
    final observationPhase = mapSceneRenderPhasePolicy.rankOf(
      mapSceneLivePointPhaseId,
    );
    final value = MapSceneFrameSubmission(
      frame: frame,
      layers: [
        MapSceneInstanceLayerSubmission(
          logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
          componentKey: mapSceneObservationPointComponentKey,
          overlayVersion: stampOf(1),
          orderWithinPhase: 0,
          kind: MapSceneInstanceLayerKind.observationPoint,
          batch: _TestInstanceBatch(
            frame: frame,
            batchKey: createMapSceneBatchKey(value: 'untyped-observation'),
            phasePolicyVersion: mapSceneRenderPhasePolicy.version,
            phase: observationPhase,
          ),
        ),
      ],
      limits: MapSceneFrameLimits(maxNodeCount: 1),
    );

    final sceneGraph = _RecordingSceneGraph()..add(scene.Node());
    var materialLookups = 0;
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) {
        materialLookups++;
        return null;
      },
      maxFramesInFlight: 2,
    );

    expect(
      () => adapter.submitFrame(submission: value),
      throwsA(
        isA<FlutterSceneLayerPreflightFailure>().having(
          (error) => error.reason,
          'reason',
          FlutterSceneLayerPreflightFailureReason.instanceBatchTypeMismatch,
        ),
      ),
    );
    expect(materialLookups, 0);
    expect(sceneGraph.children, hasLength(1));
    expect(adapter.uploadedGeometryCount, 0);
    expect(adapter.liveGeometryCount, 0);
  });

  test('rejects a wrong point sprite batch type with a typed failure', () {
    final spritePhase = mapSceneRenderPhasePolicy.rankOf(
      mapSceneSpritePhaseId,
    );
    final value = MapSceneFrameSubmission(
      frame: frame,
      layers: [
        MapSceneInstanceLayerSubmission(
          logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
          componentKey: mapSceneHypocenterSpriteComponentKey,
          overlayVersion: stampOf(1),
          orderWithinPhase: 0,
          kind: MapSceneInstanceLayerKind.pointSprite,
          batch: _TestInstanceBatch(
            frame: frame,
            batchKey: createMapSceneBatchKey(value: 'future-sprite'),
            phasePolicyVersion: mapSceneRenderPhasePolicy.version,
            phase: spritePhase,
          ),
        ),
      ],
      limits: MapSceneFrameLimits(maxNodeCount: 1),
    );

    expect(
      () => buildFlutterSceneNodePlans(submission: value),
      throwsA(
        isA<FlutterSceneLayerPreflightFailure>().having(
          (error) => error.reason,
          'reason',
          FlutterSceneLayerPreflightFailureReason.instanceBatchTypeMismatch,
        ),
      ),
    );
  });

  test('prepares and commits sprite nodes only after Scene replacement', () {
    final batch = spriteBatch(spriteFrame: frame);
    final value = MapSceneFrameSubmission(
      frame: frame,
      layers: [
        MapSceneInstanceLayerSubmission(
          logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
          componentKey: mapSceneHypocenterSpriteComponentKey,
          overlayVersion: batch.versionStamp,
          orderWithinPhase: 0,
          kind: MapSceneInstanceLayerKind.pointSprite,
          batch: batch,
        ),
      ],
      limits: MapSceneFrameLimits(maxNodeCount: 1),
    );
    final sceneGraph = _RecordingSceneGraph()..add(scene.Node());
    final sprites = _TestSpriteFrameResources();
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      maxFramesInFlight: 2,
      spriteResources: sprites,
    );

    adapter.submitFrame(submission: value);

    expect(sceneGraph.children, hasLength(1));
    expect(sceneGraph.children.single.translucentSortPriority, 0);
    expect(sprites.prepared?.commitCount, 1);
    expect(sprites.prepared?.rollbackCount, 0);
  });

  test('sprite prepare failure leaves the current Scene untouched', () {
    final batch = spriteBatch(spriteFrame: frame);
    final value = MapSceneFrameSubmission(
      frame: frame,
      layers: [
        MapSceneInstanceLayerSubmission(
          logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
          componentKey: mapSceneHypocenterSpriteComponentKey,
          overlayVersion: batch.versionStamp,
          orderWithinPhase: 0,
          kind: MapSceneInstanceLayerKind.pointSprite,
          batch: batch,
        ),
      ],
      limits: MapSceneFrameLimits(maxNodeCount: 1),
    );
    final existing = scene.Node();
    final sceneGraph = _RecordingSceneGraph()..add(existing);
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      maxFramesInFlight: 2,
      spriteResources: _TestSpriteFrameResources(
        prepareError: StateError('sprite prepare'),
      ),
    );

    expect(
      () => adapter.submitFrame(submission: value),
      throwsA(isA<StateError>()),
    );
    expect(sceneGraph.children, [same(existing)]);
  });

  test('frame-submit probe rolls back once then allows the next frame', () {
    final batch = spriteBatch(spriteFrame: frame);
    final value = MapSceneFrameSubmission(
      frame: frame,
      layers: [
        MapSceneInstanceLayerSubmission(
          logicalSourceKey: mapSceneEarthquakeHistorySourceKey,
          componentKey: mapSceneHypocenterSpriteComponentKey,
          overlayVersion: batch.versionStamp,
          orderWithinPhase: 0,
          kind: MapSceneInstanceLayerKind.pointSprite,
          batch: batch,
        ),
      ],
      limits: MapSceneFrameLimits(maxNodeCount: 1),
    );
    final existing = scene.Node();
    final sceneGraph = _RecordingSceneGraph()..add(existing);
    final sprites = _TestSpriteFrameResources();
    final adapter = FlutterSceneMapAdapter(
      sceneGraph: sceneGraph,
      materialFor: (_) => null,
      maxFramesInFlight: 2,
      spriteResources: sprites,
      gpuProbeRuntime: MapGpuProbeRuntime(
        configuration: const MapGpuProbeConfiguration(
          faultPoint: MapGpuFaultPoint.frameSubmit,
          atlasFixture: MapSpriteAtlasProbeFixture.production,
        ),
      ),
    );

    expect(
      () => adapter.submitFrame(submission: value),
      throwsA(
        isA<MapGpuProbeFault>().having(
          (fault) => fault.point,
          'point',
          MapGpuFaultPoint.frameSubmit,
        ),
      ),
    );
    expect(sceneGraph.children, [same(existing)]);
    expect(sprites.preparedFrames.first.rollbackCount, 1);
    adapter.submitFrame(submission: value);
    expect(sprites.preparedFrames.last.commitCount, 1);
    expect(sceneGraph.children, hasLength(1));
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

  test('adds exactly one observation geometry and node at draw rank zero', () {
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
    expect(sceneGraph.children.single.translucentSortPriority, 0);
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
        () => sceneSubmission(baseMap: invalidBase),
        throwsA(isA<MapSceneMeshPipelineMismatch>()),
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
      final value = sceneSubmission(baseMap: invalidBase);
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
