import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/overlay/map_point_sprite_feature.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/overlay/map_zoom_scalar_policy.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch.dart';
import 'package:eqmonitor_map/src/renderer/map_sprite_batch_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final clock = SystemMapClock.start(
    domain: createMapClockDomainId(value: 'sprite-batch-test'),
  );
  final viewport = MapViewport(
    logicalSize: const Size(400, 800),
    devicePixelRatio: 3,
  );
  final atlas = createMapSpriteAtlas(
    identity: createMapSourceIdentity(value: 'sha256:atlas-a'),
    width: 4,
    height: 4,
    rgbaBytes: Uint8List(64),
    regions: const [
      MapSpriteRegion(
        id: 'normal',
        normalizedUv: Rect.fromLTRB(0.125, 0.125, 0.375, 0.375),
        logicalSize: Size(24, 32),
      ),
      MapSpriteRegion(
        id: 'low',
        normalizedUv: Rect.fromLTRB(0.625, 0.125, 0.875, 0.375),
        logicalSize: Size(20, 28),
      ),
    ],
    limits: const MapSpriteAtlasLimits(
      maxWidth: 4,
      maxHeight: 4,
      maxPixelBytes: 64,
      maxRegions: 2,
    ),
  );
  final sizeA = createMapZoomLinearRange(
    startZoom: 3,
    startValue: 0.5,
    endZoom: 20,
    endValue: 1.5,
  );
  final sizeB = createMapZoomLinearRange(
    startZoom: 4,
    startValue: 0.75,
    endZoom: 18,
    endValue: 1.25,
  );
  final opacityA = createMapZoomStep(
    thresholdZoom: 5,
    belowValue: 0,
    atOrAboveValue: 1,
  );
  final opacityB = createMapZoomStep(
    thresholdZoom: 7,
    belowValue: 0.25,
    atOrAboveValue: 0.75,
  );

  MapFrameSnapshot frame({
    int frameNumber = 0,
    double centerLongitude = 139.7,
    double zoom = 6,
  }) => captureMapFrameSnapshot(
    clock: clock,
    frameNumber: frameNumber,
    camera: MapCamera(
      centerLongitude: centerLongitude,
      centerLatitude: 35.7,
      zoom: zoom,
    ),
    viewport: viewport,
    revisions: const [],
    lifecycle: MapAppLifecycle.active,
    contextGeneration: 0,
  );

  MapOverlayVersionStamp versionStamp({int renderGeneration = 1}) =>
      createMapOverlayVersionStamp(
        sourceIdentity: createMapSourceIdentity(value: 'event-a'),
        sourceIncarnation: createMapSourceIncarnation(value: 'incarnation-a'),
        dataSequence: 1,
        dataDigest: 'data-a',
        renderGeneration: renderGeneration,
        renderDigest: 'render-$renderGeneration',
      );

  MapPointSpriteFeature feature({
    required String id,
    required int priority,
    String regionId = 'normal',
    double longitude = 139.6917,
    double latitude = 35.6895,
    MapZoomLinearRange? size,
    MapZoomStep? opacity,
  }) => createMapPointSpriteFeature(
    id: id,
    longitude: longitude,
    latitude: latitude,
    spriteRegionId: regionId,
    sizeScale: size ?? sizeA,
    opacity: opacity ?? opacityA,
    priority: priority,
  );

  test('groups by policy and orders instances by priority then ID', () {
    final batches = buildMapPointSpriteBatches(
      frame: frame(),
      versionStamp: versionStamp(),
      atlas: atlas,
      features: [
        feature(id: 'z', priority: 2),
        feature(id: 'b', priority: 1),
        feature(id: 'a', priority: 1),
        feature(id: 'other', priority: 0, size: sizeB, opacity: opacityB),
      ],
      maxPolicyBatches: 2,
    );

    expect(batches, hasLength(2));
    expect(batches.first.featureIds, ['a', 'b', 'z']);
    expect(batches.last.featureIds, ['other']);
    expect(batches.first.batchKey.value, contains('sha256:atlas-a'));
    expect(
      batches.first.batchKey.value,
      contains('material:$mapSpriteMaterialAbiVersion'),
    );
    expect(batches.first.batchKey, isNot(batches.last.batchKey));
  });

  test('rejects caller policy batch overrun', () {
    expect(
      () => buildMapPointSpriteBatches(
        frame: frame(),
        versionStamp: versionStamp(),
        atlas: atlas,
        features: [
          feature(id: 'a', priority: 0),
          feature(id: 'b', priority: 0, size: sizeB, opacity: opacityB),
        ],
        maxPolicyBatches: 1,
      ),
      throwsArgumentError,
    );
  });

  test('packs exact little-endian 40-byte instance ABI', () {
    final batch = buildMapPointSpriteBatches(
      frame: frame(),
      versionStamp: versionStamp(),
      atlas: atlas,
      features: [feature(id: 'tokyo', priority: 7)],
      maxPolicyBatches: 1,
    ).single;
    final bytes = ByteData.sublistView(batch.instanceData);

    expect(batch.instanceStrideInBytes, 40);
    expect(bytes.lengthInBytes, 40);
    expect(bytes.getFloat32(0, Endian.little), closeTo(0.8880325, 1e-7));
    expect(bytes.getFloat32(4, Endian.little), closeTo(0.39374975, 1e-7));
    expect(bytes.getFloat32(8, Endian.little), 0.125);
    expect(bytes.getFloat32(12, Endian.little), 0.125);
    expect(bytes.getFloat32(16, Endian.little), 0.375);
    expect(bytes.getFloat32(20, Endian.little), 0.375);
    expect(bytes.getFloat32(24, Endian.little), 24);
    expect(bytes.getFloat32(28, Endian.little), 32);
    expect(bytes.getFloat32(32, Endian.little), 1);
    expect(bytes.getFloat32(36, Endian.little), 7);
  });

  test('packs exact 64-byte SpriteFrame uniform', () {
    final uniform = buildMapPointSpriteBatches(
      frame: frame(),
      versionStamp: versionStamp(),
      atlas: atlas,
      features: [feature(id: 'tokyo', priority: 0)],
      maxPolicyBatches: 1,
    ).single.frameUniform;

    expect(uniform.lengthInBytes, 64);
    expect(uniform.getFloat32(0, Endian.little), closeTo(0.88805556, 1e-7));
    expect(uniform.getFloat32(4, Endian.little), closeTo(0.39371383, 1e-7));
    expect(uniform.getFloat32(8, Endian.little), 32768);
    expect(uniform.getFloat32(12, Endian.little), 0);
    expect(uniform.getFloat32(16, Endian.little), 400);
    expect(uniform.getFloat32(20, Endian.little), 800);
    expect(uniform.getFloat32(24, Endian.little), 6);
    expect(uniform.getFloat32(28, Endian.little), 0);
    expect(uniform.getFloat32(32, Endian.little), 3);
    expect(uniform.getFloat32(36, Endian.little), 0.5);
    expect(uniform.getFloat32(40, Endian.little), 20);
    expect(uniform.getFloat32(44, Endian.little), 1.5);
    expect(uniform.getFloat32(48, Endian.little), 5);
    expect(uniform.getFloat32(52, Endian.little), 0);
    expect(uniform.getFloat32(56, Endian.little), 1);
    expect(uniform.getFloat32(60, Endian.little), 0);
  });

  test('uses nearest date-line world and logical pixels without DPR', () {
    expect(
      nearestWrappedMapSpriteWorldDelta(
        normalizedX: 0.999,
        cameraNormalizedX: 0.001,
      ),
      closeTo(-0.002, 1e-12),
    );
    final vertex = mapPointSpriteNdc(
      normalizedX: 0.999,
      normalizedY: 0.5,
      cameraNormalizedX: 0.001,
      cameraNormalizedY: 0.499,
      worldSizeLogicalPixels: 1000,
      viewport: viewport,
      cornerX: 1,
      cornerY: -1,
      logicalWidth: 20,
      logicalHeight: 40,
      sizeScale: 0.5,
    );

    expect(vertex.x, closeTo(0.015, 1e-12));
    expect(vertex.y, closeTo(-0.0275, 1e-12));
  });

  test('matches linear clamp and step equality at shader policy boundary', () {
    expect(evaluateMapSpriteSize(policy: sizeA, zoom: 2), 0.5);
    expect(evaluateMapSpriteSize(policy: sizeA, zoom: 20), 1.5);
    expect(evaluateMapSpriteOpacity(policy: opacityA, zoom: 4.999), 0);
    expect(evaluateMapSpriteOpacity(policy: opacityA, zoom: 5), 1);
  });

  test('returns no batches for zero sprites', () {
    expect(
      buildMapPointSpriteBatches(
        frame: frame(),
        versionStamp: versionStamp(),
        atlas: null,
        features: const [],
        maxPolicyBatches: 1,
      ),
      isEmpty,
    );
  });

  test('same digest reuses instances while camera-only uniform changes', () {
    final first = buildMapPointSpriteBatches(
      frame: frame(),
      versionStamp: versionStamp(),
      atlas: atlas,
      features: [feature(id: 'tokyo', priority: 0)],
      maxPolicyBatches: 1,
    ).single;
    final second = buildMapPointSpriteBatches(
      frame: frame(frameNumber: 1, centerLongitude: 140),
      versionStamp: versionStamp(),
      atlas: atlas,
      features: [feature(id: 'tokyo', priority: 0)],
      maxPolicyBatches: 1,
      previous: [first],
    ).single;

    expect(second.instanceGeneration, same(first.instanceGeneration));
    expect(second.instanceData, same(first.instanceData));
    expect(second.frameUniform, isNot(same(first.frameUniform)));
  });

  test('different digest replaces instances', () {
    final first = buildMapPointSpriteBatches(
      frame: frame(),
      versionStamp: versionStamp(),
      atlas: atlas,
      features: [feature(id: 'tokyo', priority: 0)],
      maxPolicyBatches: 1,
    ).single;
    final second = buildMapPointSpriteBatches(
      frame: frame(frameNumber: 1),
      versionStamp: versionStamp(renderGeneration: 2),
      atlas: atlas,
      features: [feature(id: 'tokyo', priority: 1)],
      maxPolicyBatches: 1,
      previous: [first],
    ).single;

    expect(second.instanceGeneration, isNot(same(first.instanceGeneration)));
    expect(second.instanceData, isNot(same(first.instanceData)));
  });

  test('feature identity participates in the reusable batch digest', () {
    final first = buildMapPointSpriteBatches(
      frame: frame(),
      versionStamp: versionStamp(),
      atlas: atlas,
      features: [feature(id: 'old-id', priority: 0)],
      maxPolicyBatches: 1,
    ).single;
    final second = buildMapPointSpriteBatches(
      frame: frame(frameNumber: 1),
      versionStamp: versionStamp(renderGeneration: 2),
      atlas: atlas,
      features: [feature(id: 'new-id', priority: 0)],
      maxPolicyBatches: 1,
      previous: [first],
    ).single;

    expect(second.instanceGeneration, isNot(same(first.instanceGeneration)));
    expect(second.featureIds, ['new-id']);
  });

  test('premultiplies straight atlas alpha and feature opacity once', () {
    final color = premultiplyMapSpriteSample(
      red: 0.8,
      green: 0.4,
      blue: 0.2,
      sampleAlpha: 0.5,
      featureOpacity: 0.25,
    );

    expect(color.red, closeTo(0.1, 1e-12));
    expect(color.green, closeTo(0.05, 1e-12));
    expect(color.blue, closeTo(0.025, 1e-12));
    expect(color.alpha, 0.125);
  });
}
