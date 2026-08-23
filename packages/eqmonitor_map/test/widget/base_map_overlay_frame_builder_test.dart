import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/earthquake_overlay_material_owner.dart';
import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage_owner.dart';
import 'package:eqmonitor_map/src/renderer/base_map_overlay_frame_builder.dart';
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
  @override
  scene.Material get material => throw UnimplementedError();

  @override
  scene.MaterialParameters get parameters => throw UnimplementedError();
}

ObservationPointBatch _requireObservationPointBatch(
  MapSceneObservationBatch? batch,
) {
  if (batch is! ObservationPointBatch) {
    fail('Expected an ObservationPointBatch.');
  }
  return batch;
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

  EarthquakeMapOverlaySnapshot snapshot({
    String sourceId = 'event-a',
    int revision = 8,
    String regionCode = '130',
    String cityCode = '13101',
    Color color = const Color(0xFFFF0000),
  }) => createEarthquakeMapOverlaySnapshot(
    sourceId: sourceId,
    revision: revision,
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

  test('same-source revision regression keeps the current full snapshot', () {
    final current = snapshot();
    final stale = snapshot(revision: 7, color: const Color(0xFF0000FF));

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
      sourceId: 'event-b',
      revision: 0,
      regionCode: '999',
      cityCode: '99999',
      color: const Color(0xFF0000FF),
    );

    final result = build(
      frame: frameAt(6),
      current: snapshot(revision: 100),
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
    final values = <EarthquakeOverlayCoverage>[];
    final owner = EarthquakeOverlayCoverageOwner(onChanged: values.add);
    const incomplete = EarthquakeOverlayCoverage.incomplete(
      requestedTileCount: 1,
      readyTileCount: 0,
      missingOrInvalidCodeCount: 0,
    );

    owner.publish(incomplete);
    owner.publish(incomplete);
    owner.publish(
      const EarthquakeOverlayCoverage.complete(requestedTileCount: 1),
    );
    owner.hide();

    expect(values, [
      incomplete,
      const EarthquakeOverlayCoverage.complete(requestedTileCount: 1),
      const EarthquakeOverlayCoverage.hidden(),
    ]);
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

      expect(await owner.prepare(resources: [region, city]), isTrue);
      expect(await owner.prepare(resources: [region, city]), isTrue);
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
}
