import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/earthquake_overlay_material_owner.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage_owner.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/renderer/base_map_overlay_frame_builder.dart';
import 'package:eqmonitor_map/src/renderer/base_map_overlay_frame_owner.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_packed_mesh_cache.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_resources.dart';
import 'package:eqmonitor_map/src/renderer/earthquake_area_render_submission_builder.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_frame_submission.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/earthquake_area_tile_geometry.dart';
import 'package:eqmonitor_map/src/tile/earthquake_overlay_exact_tile_resolver.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:flutter_test/flutter_test.dart';

final class _TestMaterialBinding implements FlutterSceneMapMaterialBinding {
  _TestMaterialBinding({scene.FmatType fillColorType = scene.FmatType.vec4})
    : material = scene.UnlitMaterial(),
      parameters = scene.MaterialParameters.withLayout(
        blockName: 'MaterialParams',
        blockSizeBytes: 16,
        parameters: {
          'fill_color': (
            type: fillColorType,
            offset: 0,
            sourceColor: false,
          ),
        },
      );

  @override
  final scene.Material material;

  @override
  final scene.MaterialParameters parameters;
}

final class _TestObservationMaterialBinding
    implements FlutterSceneObservationMaterialBinding {
  _TestObservationMaterialBinding()
    : material = scene.ShaderMaterial(isOpaqueOverride: false);

  @override
  final scene.ShaderMaterial material;

  @override
  void preflight({required ObservationPointBatch batch}) {}

  @override
  void setFrameUniform(ByteData bytes) {
    material.setUniformBlock(
      observationFrameUniformBlockName,
      bytes,
      stage: scene.ShaderStage.vertex,
    );
  }
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

ObservationPointBatch _requireObservationPointBatch(
  MapSceneObservationBatch? batch,
) {
  if (batch is! ObservationPointBatch) {
    fail('Expected an ObservationPointBatch.');
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

EarthquakeOverlayMaterialStage _requireMaterialStage(
  EarthquakeOverlayMaterialPreparation result,
) {
  if (result is! EarthquakeOverlayMaterialPreparationReady) {
    fail('Expected a ready earthquake material stage.');
  }
  return result.stage;
}

void main() {
  final clock = SystemMapClock.start(
    domain: createMapClockDomainId(value: 'base-map-overlay-frame-test'),
  );
  final viewport = MapViewport(
    logicalSize: const Size(400, 800),
    devicePixelRatio: 2,
  );
  final cover = [
    OverscaledTileId(
      overscaledZ: 6,
      wrap: 0,
      canonical: const CanonicalTileId(z: 6, x: 56, y: 25),
    ),
  ];

  MapFrameSnapshot frameAt(
    double zoom, {
    int frameNumber = 0,
    MapAppLifecycle lifecycle = MapAppLifecycle.active,
  }) => captureMapFrameSnapshot(
    clock: clock,
    frameNumber: frameNumber,
    camera: MapCamera(
      centerLongitude: 139.7,
      centerLatitude: 35.7,
      zoom: zoom,
    ),
    viewport: viewport,
    revisions: const [],
    lifecycle: lifecycle,
    contextGeneration: 0,
  );

  MapOverlayVersionStamp versionStamp({
    String sourceIdentity = 'event-a',
    String sourceIncarnation = 'incarnation-a',
    int dataSequence = 8,
    String dataDigest = 'data-a',
    int renderGeneration = 8,
    String renderDigest = 'render-a',
  }) => createMapOverlayVersionStamp(
    sourceIdentity: createMapSourceIdentity(value: sourceIdentity),
    sourceIncarnation: createMapSourceIncarnation(value: sourceIncarnation),
    dataSequence: dataSequence,
    dataDigest: dataDigest,
    renderGeneration: renderGeneration,
    renderDigest: renderDigest,
  );

  EarthquakeMapOverlaySnapshot snapshot({
    String sourceIdentity = 'event-a',
    String sourceIncarnation = 'incarnation-a',
    int dataSequence = 8,
    String dataDigest = 'data-a',
    int renderGeneration = 8,
    String renderDigest = 'render-a',
    String regionCode = '130',
    String cityCode = '13101',
    Color color = const Color(0xFFFF0000),
  }) => createEarthquakeMapOverlaySnapshot(
    versionStamp: versionStamp(
      sourceIdentity: sourceIdentity,
      sourceIncarnation: sourceIncarnation,
      dataSequence: dataSequence,
      dataDigest: dataDigest,
      renderGeneration: renderGeneration,
      renderDigest: renderDigest,
    ),
    regionToCityZoom: 6,
    stationMinZoom: 6,
    regionStyles: [
      EarthquakeAreaStyle(code: regionCode, color: color, opacity: 0.6),
    ],
    cityStyles: [
      EarthquakeAreaStyle(code: cityCode, color: color, opacity: 0.6),
    ],
    stations: const [
      EarthquakeObservationPoint(
        id: 'tokyo',
        longitude: 139.6917,
        latitude: 35.6895,
        color: Color(0xFFFF0000),
        radiusLogicalPixels: 6.7,
      ),
    ],
    spriteAtlas: null,
    sprites: const [],
    maxSpritePolicyBatches: 1,
  );

  FillMesh mesh() => FillMesh(
    positions: Float32List.fromList([0, 0, 4096, 0, 0, 4096]),
    indices: Uint16List.fromList([0, 1, 2]),
    vertexCount: 3,
  );

  BaseMapTileGeometry geometry({
    int? regionExtent = 4096,
    int? cityExtent = 4096,
    int regionInvalidCodes = 0,
    int cityInvalidCodes = 0,
  }) => BaseMapTileGeometry(
    layers: const [],
    earthquakeAreas: EarthquakeAreaTileGeometry(
      forecastRegions: EarthquakeAreaTileLayerGeometry(
        extent: regionExtent,
        missingOrInvalidCodeCount: regionInvalidCodes,
        features: [
          CodedFillGeometry(code: '130', meshes: [mesh()]),
          CodedFillGeometry(code: '999', meshes: [mesh()]),
        ],
      ),
      cities: EarthquakeAreaTileLayerGeometry(
        extent: cityExtent,
        missingOrInvalidCodeCount: cityInvalidCodes,
        features: [
          CodedFillGeometry(code: '13101', meshes: [mesh()]),
          CodedFillGeometry(code: '99999', meshes: [mesh()]),
        ],
      ),
    ),
  );

  BaseMapTileCache cacheWith(BaseMapTileGeometry value) {
    final cache = BaseMapTileCache(
      maxEntries: 8,
      maxParentFallbackSteps: 4,
    );
    cache.put(
      sourceInstanceId: 'archive-a',
      tileId: cover.single.canonical,
      geometry: value,
      token: cache.beginDecode(),
    );
    return cache;
  }

  BaseMapOverlayFrameResult build({
    required MapFrameSnapshot frame,
    required EarthquakeMapOverlaySnapshot? requested,
    EarthquakeMapOverlaySnapshot? current,
    ObservationPointBatch? previousObservation,
    BaseMapTileCache? cache,
    EarthquakeAreaRenderStyleCache? styleCache,
  }) {
    final baseMap = createMapRenderSubmission(frame: frame, batches: const []);
    final packed = EarthquakeAreaPackedMeshCache(maxEntries: 8);
    return buildBaseMapOverlayFrame(
      frame: frame,
      baseMap: baseMap,
      currentOverlay: current,
      requestedOverlay: requested,
      previousObservationBatch: previousObservation,
      requestedCover: cover,
      tileSourceInstanceId: 'archive-a',
      tileCache: cache ?? cacheWith(geometry()),
      packedMeshFor: packed.resolve,
      styleCache: styleCache ?? EarthquakeAreaRenderStyleCache(),
    );
  }

  test('zoom 5.999 submits region Fill without stations', () {
    final result = build(frame: frameAt(5.999), requested: snapshot());

    expect(result.submission, isNotNull);
    expect(result.submission?.earthquakeFill.batches, hasLength(1));
    expect(result.submission?.observationBatch, isNull);
    expect(
      result.coverage,
      const EarthquakeOverlayCoverage.complete(requestedTileCount: 1),
    );
  });

  test('zoom 6 submits city Fill and one station batch', () {
    final result = build(frame: frameAt(6), requested: snapshot());

    expect(result.submission?.earthquakeFill.batches, hasLength(1));
    expect(result.submission?.observationBatch, isA<ObservationPointBatch>());
  });

  test('null snapshot atomically hides the previous overlay', () {
    final result = build(
      frame: frameAt(6),
      current: snapshot(),
      requested: null,
    );

    expect(result.overlay, isNull);
    expect(result.submission?.earthquakeFill.batches, isEmpty);
    expect(result.submission?.observationBatch, isNull);
    expect(result.coverage, const EarthquakeOverlayCoverage.hidden());
  });

  test('same-source data sequence regression keeps the current snapshot', () {
    final current = snapshot();
    final stale = snapshot(
      dataSequence: 7,
      color: const Color(0xFF0000FF),
    );

    final result = build(
      frame: frameAt(5),
      current: current,
      requested: stale,
    );

    expect(result.overlay, same(current));
    final bytes = result
        .submission
        ?.earthquakeFill
        .batches
        .single
        .compatibility
        .materialParameters
        .bytes;
    expect(ByteData.sublistView(bytes!).getFloat32(0, Endian.little), 1);
  });

  test('another source atomically replaces Fill and station inputs', () {
    final replacement = snapshot(
      sourceIdentity: 'event-b',
      dataSequence: 0,
      renderGeneration: 0,
      regionCode: '999',
      cityCode: '99999',
      color: const Color(0xFF0000FF),
    );

    final result = build(
      frame: frameAt(6),
      current: snapshot(dataSequence: 100, renderGeneration: 100),
      requested: replacement,
    );

    expect(result.overlay, same(replacement));
    expect(result.submission?.earthquakeFill.batches, hasLength(1));
    expect(result.submission?.observationBatch, isA<ObservationPointBatch>());
    final bytes = result
        .submission
        ?.earthquakeFill
        .batches
        .single
        .compatibility
        .materialParameters
        .bytes;
    expect(ByteData.sublistView(bytes!).getFloat32(8, Endian.little), 1);
  });

  test('background schedules retirement without a Scene submission', () {
    final result = build(
      frame: frameAt(6, lifecycle: MapAppLifecycle.background),
      requested: snapshot(),
    );

    expect(result.submission, isNull);
    expect(result.shouldRetireGpuResources, isTrue);
    expect(result.coverage, const EarthquakeOverlayCoverage.hidden());
  });

  test('exact miss, source layer absence, and invalid code are incomplete', () {
    final missing = build(
      frame: frameAt(6),
      requested: snapshot(),
      cache: BaseMapTileCache(maxEntries: 8, maxParentFallbackSteps: 4),
    );
    final noLayer = build(
      frame: frameAt(6),
      requested: snapshot(),
      cache: cacheWith(geometry(cityExtent: null)),
    );
    final invalidCode = build(
      frame: frameAt(6),
      requested: snapshot(),
      cache: cacheWith(geometry(cityInvalidCodes: 2)),
    );

    expect(
      missing.coverage,
      const EarthquakeOverlayCoverage.incomplete(
        requestedTileCount: 1,
        readyTileCount: 0,
        missingOrInvalidCodeCount: 0,
      ),
    );
    expect(
      noLayer.coverage,
      const EarthquakeOverlayCoverage.incomplete(
        requestedTileCount: 1,
        readyTileCount: 0,
        missingOrInvalidCodeCount: 0,
      ),
    );
    expect(
      invalidCode.coverage,
      const EarthquakeOverlayCoverage.incomplete(
        requestedTileCount: 1,
        readyTileCount: 1,
        missingOrInvalidCodeCount: 2,
      ),
    );
  });

  test('camera-only frames reuse station geometry and style parameters', () {
    final value = snapshot();
    final styles = EarthquakeAreaRenderStyleCache();
    final first = build(
      frame: frameAt(6),
      requested: value,
      styleCache: styles,
    );
    final second = build(
      frame: frameAt(6, frameNumber: 1),
      current: first.overlay,
      requested: value,
      previousObservation: first.observationBatchForReuse,
      styleCache: styles,
    );

    final firstObservation = _requireObservationPointBatch(
      first.submission?.observationBatch,
    );
    final secondObservation = _requireObservationPointBatch(
      second.submission?.observationBatch,
    );
    expect(
      secondObservation.instanceGeneration,
      same(firstObservation.instanceGeneration),
    );
    expect(
      second
          .submission
          ?.earthquakeFill
          .batches
          .single
          .compatibility
          .materialParameters,
      same(
        first
            .submission
            ?.earthquakeFill
            .batches
            .single
            .compatibility
            .materialParameters,
      ),
    );
  });

  test('coverage owner calls back only when the value changes', () {
    final values = <EarthquakeOverlayCoverageSnapshot>[];
    final owner = EarthquakeOverlayCoverageOwner(onChanged: values.add);
    final value = snapshot();
    const incomplete = EarthquakeOverlayCoverage.incomplete(
      requestedTileCount: 1,
      readyTileCount: 0,
      missingOrInvalidCodeCount: 0,
    );

    owner.publish(overlay: value, coverage: incomplete);
    owner.publish(overlay: value, coverage: incomplete);
    owner.publish(
      overlay: value,
      coverage: const EarthquakeOverlayCoverage.complete(
        requestedTileCount: 1,
      ),
    );
    owner.hide(overlay: value);

    expect(values, [
      EarthquakeOverlayCoverageSnapshot(
        versionStamp: value.versionStamp,
        coverage: incomplete,
      ),
      EarthquakeOverlayCoverageSnapshot(
        versionStamp: value.versionStamp,
        coverage: const EarthquakeOverlayCoverage.complete(
          requestedTileCount: 1,
        ),
      ),
      EarthquakeOverlayCoverageSnapshot(
        versionStamp: value.versionStamp,
        coverage: const EarthquakeOverlayCoverage.hidden(),
      ),
    ]);
  });

  test('same-source data regression publishes committed provenance', () {
    final values = <EarthquakeOverlayCoverageSnapshot>[];
    final frames = BaseMapOverlayFrameOwner(onCoverageChanged: values.add);
    final current = snapshot();
    final first = build(frame: frameAt(6), requested: current);
    final firstFallback = build(
      frame: frameAt(6),
      current: current,
      requested: null,
    );
    frames.commit(
      candidate: first,
      baseOnlySubmission: firstFallback.submission!,
      resources: null,
      submitFrame: (_) {},
      retireAllGpuResources: () {},
      failClosedResources: () {},
    );
    values.clear();

    final stale = snapshot(dataSequence: 7);
    final candidate = build(
      frame: frameAt(6, frameNumber: 1),
      current: frames.overlay,
      requested: stale,
      cache: BaseMapTileCache(maxEntries: 8, maxParentFallbackSteps: 4),
    );
    frames.commit(
      candidate: candidate,
      baseOnlySubmission: firstFallback.submission!,
      resources: null,
      submitFrame: (_) {},
      retireAllGpuResources: () {},
      failClosedResources: () {},
    );

    expect(candidate.overlay, same(current));
    expect(values.single.versionStamp, current.versionStamp);
    expect(values.single.coverage, isA<EarthquakeOverlayIncomplete>());
  });

  test('material preparation中の旧coverageは旧snapshot identityで通知する', () {
    final values = <EarthquakeOverlayCoverageSnapshot>[];
    final frames = BaseMapOverlayFrameOwner(onCoverageChanged: values.add);
    final eventA = snapshot();
    final first = build(frame: frameAt(6), requested: eventA);
    final fallback = build(
      frame: frameAt(6),
      current: eventA,
      requested: null,
    );
    frames.commit(
      candidate: first,
      baseOnlySubmission: fallback.submission!,
      resources: null,
      submitFrame: (_) {},
      retireAllGpuResources: () {},
      failClosedResources: () {},
    );
    values.clear();

    final delayedCallbackValues = <EarthquakeOverlayCoverageSnapshot>[];
    frames.updateCoverageCallback(delayedCallbackValues.add);
    final oldFrameWhileEventBPrepares = build(
      frame: frameAt(6, frameNumber: 1),
      current: frames.overlay,
      requested: frames.overlay,
      cache: BaseMapTileCache(maxEntries: 8, maxParentFallbackSteps: 4),
    );
    frames.commit(
      candidate: oldFrameWhileEventBPrepares,
      baseOnlySubmission: fallback.submission!,
      resources: null,
      submitFrame: (_) {},
      retireAllGpuResources: () {},
      failClosedResources: () {},
    );

    expect(delayedCallbackValues.single.versionStamp, eventA.versionStamp);
    expect(
      delayedCallbackValues.single.coverage,
      isA<EarthquakeOverlayIncomplete>(),
    );
  });

  test(
    'material owner loads each parameter value once and resolves its batch',
    () async {
      var loadCount = 0;
      final bindings = <_TestMaterialBinding>[];
      final owner = EarthquakeOverlayMaterialOwner(
        loadMaterial: () async {
          loadCount++;
          final binding = _TestMaterialBinding();
          bindings.add(binding);
          return binding;
        },
      );
      final value = snapshot();
      final styles = EarthquakeAreaRenderStyleCache();
      final region = styles.resolve(
        snapshot: value,
        layerMode: EarthquakeAreaLayerMode.region,
        parametersFor: earthquakeAreaMaterialParametersFor,
      );
      final city = styles.resolve(
        snapshot: value,
        layerMode: EarthquakeAreaLayerMode.city,
        parametersFor: earthquakeAreaMaterialParametersFor,
      );

      final firstStage = _requireMaterialStage(
        await owner.prepare(resources: [region, city]),
      )..beginSubmission();
      firstStage.commit();
      final secondStage = _requireMaterialStage(
        await owner.prepare(resources: [region, city]),
      )..beginSubmission();
      secondStage.commit();
      expect(loadCount, 1);

      final result = build(
        frame: frameAt(6),
        requested: value,
        styleCache: styles,
      );
      final batch = result.submission?.earthquakeFill.batches.single;
      expect(owner.materialFor(batch!), same(bindings.single));
    },
  );

  test(
    'material load failure during a source switch resolves and commits '
    'base-only',
    () async {
      var rejectsLoad = false;
      final material = _TestMaterialBinding();
      final materials = EarthquakeOverlayMaterialOwner(
        loadMaterial: () async {
          if (rejectsLoad) {
            throw StateError('material load failed');
          }
          return material;
        },
      );
      final coverages = <EarthquakeOverlayCoverageSnapshot>[];
      final frames = BaseMapOverlayFrameOwner(
        onCoverageChanged: coverages.add,
      );
      final eventA = snapshot();
      final eventAStyles = EarthquakeAreaRenderStyleCache();
      final eventAStage = _requireMaterialStage(
        await materials.prepare(
          resources: earthquakeAreaRenderStyleResourcesForSnapshot(
            cache: eventAStyles,
            snapshot: eventA,
            parametersFor: earthquakeAreaMaterialParametersFor,
          ),
        ),
      );
      final first = build(
        frame: frameAt(6),
        requested: eventA,
        styleCache: eventAStyles,
      );
      final firstFallback = build(
        frame: frameAt(6),
        current: eventA,
        requested: null,
      );

      expect(
        frames.commit(
          candidate: first,
          baseOnlySubmission: firstFallback.submission!,
          resources: eventAStage,
          submitFrame: (_) {},
          retireAllGpuResources: () {},
          failClosedResources: materials.clear,
        ),
        isA<BaseMapOverlayFrameCommitSucceeded>(),
      );

      rejectsLoad = true;
      final eventB = snapshot(
        sourceIdentity: 'event-b',
        dataSequence: 0,
        renderGeneration: 0,
        color: const Color(0xFF0000FF),
      );
      final failedPreparation = await materials.prepare(
        resources: earthquakeAreaRenderStyleResourcesForSnapshot(
          cache: EarthquakeAreaRenderStyleCache(),
          snapshot: eventB,
          parametersFor: earthquakeAreaMaterialParametersFor,
        ),
      );

      expect(
        failedPreparation,
        isA<EarthquakeOverlayMaterialPreparationFailed>(),
      );
      final hidden = build(
        frame: frameAt(6, frameNumber: 1),
        current: frames.overlay,
        requested: null,
      );
      final submitted = <MapSceneFrameSubmission>[];
      final result = frames.commit(
        candidate: hidden,
        baseOnlySubmission: hidden.submission!,
        resources: materials.stageClear(),
        submitFrame: submitted.add,
        retireAllGpuResources: () {},
        failClosedResources: materials.clear,
      );

      expect(result, isA<BaseMapOverlayFrameCommitSucceeded>());
      expect(submitted, hasLength(1));
      expect(frames.overlay, isNull);
      expect(frames.previousObservationBatch, isNull);
      expect(frames.coverage, const EarthquakeOverlayCoverage.hidden());
      expect(coverages, [
        EarthquakeOverlayCoverageSnapshot(
          versionStamp: eventA.versionStamp,
          coverage: const EarthquakeOverlayCoverage.complete(
            requestedTileCount: 1,
          ),
        ),
        const EarthquakeOverlayCoverageSnapshot.hidden(),
      ]);
    },
  );

  test(
    'reflection failure during a source switch fails closed atomically',
    () async {
      var materialLoadCount = 0;
      final materials = EarthquakeOverlayMaterialOwner(
        loadMaterial: () async => _TestMaterialBinding(
          fillColorType: materialLoadCount++ == 0
              ? scene.FmatType.vec4
              : scene.FmatType.vec2,
        ),
      );
      final coverages = <EarthquakeOverlayCoverageSnapshot>[];
      final frames = BaseMapOverlayFrameOwner(
        onCoverageChanged: coverages.add,
      );
      final eventA = snapshot();
      final eventAStyles = EarthquakeAreaRenderStyleCache();
      final eventAStage = _requireMaterialStage(
        await materials.prepare(
          resources: earthquakeAreaRenderStyleResourcesForSnapshot(
            cache: eventAStyles,
            snapshot: eventA,
            parametersFor: earthquakeAreaMaterialParametersFor,
          ),
        ),
      );
      final first = build(
        frame: frameAt(6),
        requested: eventA,
        styleCache: eventAStyles,
      );
      final firstFallback = build(
        frame: frameAt(6),
        current: eventA,
        requested: null,
      );
      frames.commit(
        candidate: first,
        baseOnlySubmission: firstFallback.submission!,
        resources: eventAStage,
        submitFrame: (_) {},
        retireAllGpuResources: () {},
        failClosedResources: materials.clear,
      );

      final eventB = snapshot(
        sourceIdentity: 'event-b',
        dataSequence: 0,
        renderGeneration: 0,
        regionCode: '999',
        cityCode: '99999',
        color: const Color(0xFF0000FF),
      );
      final eventBStyles = EarthquakeAreaRenderStyleCache();
      final eventBStage = _requireMaterialStage(
        await materials.prepare(
          resources: earthquakeAreaRenderStyleResourcesForSnapshot(
            cache: eventBStyles,
            snapshot: eventB,
            parametersFor: earthquakeAreaMaterialParametersFor,
          ),
        ),
      );
      final nextFrame = frameAt(6, frameNumber: 1);
      final candidate = build(
        frame: nextFrame,
        current: frames.overlay,
        requested: eventB,
        previousObservation: frames.previousObservationBatch,
        styleCache: eventBStyles,
      );
      final fallback = build(
        frame: nextFrame,
        current: frames.overlay,
        requested: null,
      );
      final submitted = <MapSceneFrameSubmission>[];
      final sceneGraph = _RecordingSceneGraph();
      final oldSceneNode = scene.Node();
      sceneGraph.add(oldSceneNode);
      final adapter = FlutterSceneMapAdapter(
        sceneGraph: sceneGraph,
        materialFor: materials.materialFor,
        maxFramesInFlight: 2,
      );
      var retireCount = 0;

      final result = frames.commit(
        candidate: candidate,
        baseOnlySubmission: fallback.submission!,
        resources: eventBStage,
        submitFrame: (submission) {
          submitted.add(submission);
          try {
            expect(frames.overlay, same(eventA));
            expect(coverages, hasLength(1));
            adapter.submitFrame(submission: submission);
          } on Object catch (error) {
            expect(error, isA<StateError>());
            expect(submission, same(candidate.submission));
            expect(sceneGraph.children, [same(oldSceneNode)]);
            rethrow;
          }
        },
        retireAllGpuResources: () {
          retireCount++;
          adapter.retireAllGpuResources();
        },
        failClosedResources: materials.clear,
      );

      expect(result, isA<BaseMapOverlayFrameCommitFailed>());
      expect(submitted, [candidate.submission, fallback.submission]);
      expect(retireCount, 0);
      expect(sceneGraph.children, isEmpty);
      expect(frames.overlay, isNull);
      expect(frames.previousObservationBatch, isNull);
      expect(frames.coverage, const EarthquakeOverlayCoverage.hidden());
      expect(coverages, [
        EarthquakeOverlayCoverageSnapshot(
          versionStamp: eventA.versionStamp,
          coverage: const EarthquakeOverlayCoverage.complete(
            requestedTileCount: 1,
          ),
        ),
        const EarthquakeOverlayCoverageSnapshot.hidden(),
      ]);
    },
  );

  test(
    'failed base-only fallback schedules observation retirement behind fence',
    () async {
      var materialLoadCount = 0;
      final materials = EarthquakeOverlayMaterialOwner(
        loadMaterial: () async => _TestMaterialBinding(
          fillColorType: materialLoadCount++ == 0
              ? scene.FmatType.vec4
              : scene.FmatType.vec2,
        ),
      );
      final frames = BaseMapOverlayFrameOwner();
      final eventA = snapshot();
      final eventAStyles = EarthquakeAreaRenderStyleCache();
      final eventAStage = _requireMaterialStage(
        await materials.prepare(
          resources: earthquakeAreaRenderStyleResourcesForSnapshot(
            cache: eventAStyles,
            snapshot: eventA,
            parametersFor: earthquakeAreaMaterialParametersFor,
          ),
        ),
      );
      final sceneGraph = _RecordingSceneGraph();
      final gpuCompletion = Completer<void>();
      final adapter = FlutterSceneMapAdapter(
        sceneGraph: sceneGraph,
        materialFor: materials.materialFor,
        observationMaterial: _TestObservationMaterialBinding(),
        waitForGpuCompletion: () => gpuCompletion.future,
        maxFramesInFlight: 2,
      );
      final first = build(
        frame: frameAt(6),
        requested: eventA,
        styleCache: eventAStyles,
      );
      final initialSubmission = MapSceneFrameSubmission(
        baseMap: createMapRenderSubmission(
          frame: first.submission!.frame,
          batches: const [],
        ),
        earthquakeFill: createMapRenderSubmission(
          frame: first.submission!.frame,
          batches: const [],
        ),
        observationBatch: first.submission!.observationBatch,
      );
      final initialCandidate = BaseMapOverlayFrameResult(
        overlay: first.overlay,
        submission: initialSubmission,
        coverage: first.coverage,
        observationBatchForReuse: first.observationBatchForReuse,
        shouldRetireGpuResources: false,
      );
      final firstFallback = build(
        frame: frameAt(6),
        current: eventA,
        requested: null,
      );
      final initialCommit = frames.commit(
        candidate: initialCandidate,
        baseOnlySubmission: firstFallback.submission!,
        resources: eventAStage,
        submitFrame: (submission) => adapter.submitFrame(
          submission: submission,
        ),
        retireAllGpuResources: adapter.retireAllGpuResources,
        failClosedResources: materials.clear,
      );
      if (initialCommit case BaseMapOverlayFrameCommitFailed(
        :final error,
        :final fallbackError,
      )) {
        fail('Initial Scene submit failed: $error; fallback=$fallbackError');
      }
      final geometry = _requireStaticInstanceGeometry(
        sceneGraph.children.last.mesh?.primitives.single.geometry,
      );

      final eventB = snapshot(
        sourceIdentity: 'event-b',
        dataSequence: 0,
        renderGeneration: 0,
        color: const Color(0xFF0000FF),
      );
      final eventBStyles = EarthquakeAreaRenderStyleCache();
      final eventBStage = _requireMaterialStage(
        await materials.prepare(
          resources: earthquakeAreaRenderStyleResourcesForSnapshot(
            cache: eventBStyles,
            snapshot: eventB,
            parametersFor: earthquakeAreaMaterialParametersFor,
          ),
        ),
      );
      final nextFrame = frameAt(6, frameNumber: 1);
      final candidate = build(
        frame: nextFrame,
        current: frames.overlay,
        requested: eventB,
        previousObservation: frames.previousObservationBatch,
        styleCache: eventBStyles,
      );
      final fallback = build(
        frame: nextFrame,
        current: frames.overlay,
        requested: null,
      );
      var submitCount = 0;
      var retireCount = 0;

      final result = frames.commit(
        candidate: candidate,
        baseOnlySubmission: fallback.submission!,
        resources: eventBStage,
        submitFrame: (submission) {
          submitCount++;
          if (identical(submission, fallback.submission)) {
            throw StateError('base-only fallback failed');
          }
          adapter.submitFrame(submission: submission);
        },
        retireAllGpuResources: () {
          retireCount++;
          adapter.retireAllGpuResources();
        },
        failClosedResources: materials.clear,
      );

      expect(result, isA<BaseMapOverlayFrameCommitFailed>());
      final failed = result as BaseMapOverlayFrameCommitFailed;
      expect(failed.fallbackError, isA<StateError>());
      expect(submitCount, 2);
      expect(retireCount, 1);
      expect(sceneGraph.children, isEmpty);
      expect(geometry.isRetired, isFalse);
      expect(frames.overlay, isNull);
      expect(frames.previousObservationBatch, isNull);
      expect(frames.coverage, const EarthquakeOverlayCoverage.hidden());

      gpuCompletion.complete();
      await Future<void>.delayed(Duration.zero);
      expect(geometry.isRetired, isTrue);
      expect(adapter.retiredObservationGeometryCount, 1);
    },
  );
}
