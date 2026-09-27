import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/map_gpu_probe.dart';
import 'package:eqmonitor_map/src/flutter_scene/map_gpu_probe_overlay.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';
import 'package:eqmonitor_map/src/overlay/map_point_sprite_feature.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:eqmonitor_map/src/overlay/map_zoom_scalar_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final overlay = _overlayFixture();

  test('disabled runtime and production fixture preserve overlay identity', () {
    final disabled = resolveMapGpuProbeOverlay(
      overlay: overlay,
      probeRuntime: null,
    );
    final production = resolveMapGpuProbeOverlay(
      overlay: overlay,
      probeRuntime: MapGpuProbeRuntime(
        configuration: const MapGpuProbeConfiguration(
          faultPoint: null,
          atlasFixture: MapSpriteAtlasProbeFixture.production,
        ),
      ),
    );

    expect(disabled, same(overlay));
    expect(production, same(overlay));
  });

  test('probe fixtures replace texture with literal straight RGBA bytes', () {
    final expectedBytes = <MapSpriteAtlasProbeFixture, List<int>>{
      MapSpriteAtlasProbeFixture.orientation2x2: const [
        255,
        0,
        0,
        255,
        0,
        255,
        0,
        255,
        0,
        0,
        255,
        255,
        255,
        255,
        255,
        255,
      ],
      MapSpriteAtlasProbeFixture.alphaHalf: const [
        255,
        255,
        255,
        128,
        255,
        255,
        255,
        128,
        255,
        255,
        255,
        128,
        255,
        255,
        255,
        128,
      ],
      MapSpriteAtlasProbeFixture.edgeBleed: const [
        0,
        255,
        255,
        255,
        0,
        255,
        255,
        255,
        0,
        255,
        255,
        255,
        0,
        255,
        255,
        255,
      ],
    };

    for (final MapEntry(key: fixture, value: bytes) in expectedBytes.entries) {
      final result = applyMapGpuProbeAtlasFixture(
        overlay: overlay,
        fixture: fixture,
      );

      expect(result.spriteAtlas?.rgbaBytes, bytes, reason: fixture.name);
      expect(
        result.spriteAtlas?.identity.value,
        'atlas-production:gpu-probe-${fixture.name}-v1',
      );
    }
  });

  test('edge fixture extrudes each region and keeps the gap distinct', () {
    final atlas = createMapSpriteAtlas(
      identity: createMapSourceIdentity(value: 'atlas-edge'),
      width: 11,
      height: 5,
      rgbaBytes: Uint8List(11 * 5 * 4),
      regions: const [
        MapSpriteRegion(
          id: 'normal',
          normalizedUv: Rect.fromLTRB(2.5 / 11, 0.5, 2.5 / 11, 0.5),
          logicalSize: Size(1, 1),
        ),
        MapSpriteRegion(
          id: 'low-precision',
          normalizedUv: Rect.fromLTRB(8.5 / 11, 0.5, 8.5 / 11, 0.5),
          logicalSize: Size(1, 1),
        ),
      ],
      limits: const MapSpriteAtlasLimits(
        maxWidth: 11,
        maxHeight: 5,
        maxPixelBytes: 11 * 5 * 4,
        maxRegions: 2,
      ),
    );

    final bytes = createMapGpuProbeAtlasFixtureBytes(
      fixture: MapSpriteAtlasProbeFixture.edgeBleed,
      atlas: atlas,
    );

    expect(_pixel(bytes: bytes, width: 11, x: 0, y: 2), [0, 255, 255, 255]);
    expect(_pixel(bytes: bytes, width: 11, x: 4, y: 2), [0, 255, 255, 255]);
    expect(_pixel(bytes: bytes, width: 11, x: 5, y: 2), [255, 0, 255, 0]);
    expect(_pixel(bytes: bytes, width: 11, x: 6, y: 2), [255, 255, 0, 255]);
    expect(_pixel(bytes: bytes, width: 11, x: 10, y: 2), [255, 255, 0, 255]);
  });

  test('fixture changes only atlas texture identity and bytes', () {
    final result = applyMapGpuProbeAtlasFixture(
      overlay: overlay,
      fixture: MapSpriteAtlasProbeFixture.orientation2x2,
    );
    final sourceAtlas = overlay.spriteAtlas;
    final resultAtlas = result.spriteAtlas;

    expect(result, isNot(same(overlay)));
    expect(result.versionStamp, same(overlay.versionStamp));
    expect(result.regionStyles, same(overlay.regionStyles));
    expect(result.cityStyles, same(overlay.cityStyles));
    expect(result.stations, same(overlay.stations));
    expect(result.sprites, same(overlay.sprites));
    expect(result.regionToCityZoom, overlay.regionToCityZoom);
    expect(result.stationMinZoom, overlay.stationMinZoom);
    expect(result.maxSpritePolicyBatches, overlay.maxSpritePolicyBatches);
    expect(resultAtlas?.width, sourceAtlas?.width);
    expect(resultAtlas?.height, sourceAtlas?.height);
    expect(resultAtlas?.regions, same(sourceAtlas?.regions));
    expect(resultAtlas?.identity, isNot(sourceAtlas?.identity));
    expect(resultAtlas?.rgbaBytes, isNot(sourceAtlas?.rgbaBytes));
  });

  test('fixture change produces a different texture identity', () {
    final orientation = applyMapGpuProbeAtlasFixture(
      overlay: overlay,
      fixture: MapSpriteAtlasProbeFixture.orientation2x2,
    );
    final alpha = applyMapGpuProbeAtlasFixture(
      overlay: overlay,
      fixture: MapSpriteAtlasProbeFixture.alphaHalf,
    );

    expect(
      orientation.spriteAtlas?.identity,
      isNot(alpha.spriteAtlas?.identity),
    );
  });

  test('consumed typed transition permits only the expected atlas change', () {
    if (!mapGpuProbeCompileTimeEnabled) {
      return;
    }
    final runtime = MapGpuProbeRuntime(
      configuration: const MapGpuProbeConfiguration(
        faultPoint: null,
        atlasFixture: MapSpriteAtlasProbeFixture.production,
      ),
    );
    final update = runtime.updateConfiguration(
      const MapGpuProbeConfiguration(
        faultPoint: null,
        atlasFixture: MapSpriteAtlasProbeFixture.orientation2x2,
      ),
    );
    final token = update.atlasTransitionToken;
    if (token == null) {
      fail('probe-enabled update must issue an atlas transition token');
    }
    final transition = runtime.consumeAtlasTransition(token);
    if (transition == null) {
      fail('fresh atlas transition token must be consumable');
    }

    final result = applyMapGpuProbeAtlasFixtureTransition(
      sourceOverlay: overlay,
      currentOverlay: overlay,
      transition: transition,
    );

    expect(result, isNotNull);
    expect(result?.versionStamp, same(overlay.versionStamp));
    expect(result?.regionStyles, same(overlay.regionStyles));
    expect(result?.cityStyles, same(overlay.cityStyles));
    expect(result?.stations, same(overlay.stations));
    expect(result?.sprites, same(overlay.sprites));
    expect(result?.spriteAtlas?.regions, same(overlay.spriteAtlas?.regions));
    expect(
      result?.spriteAtlas?.identity.value,
      'atlas-production:gpu-probe-orientation2x2-v1',
    );
  });

  test('typed transition rejects same-version non-atlas input changes', () {
    if (!mapGpuProbeCompileTimeEnabled) {
      return;
    }
    final runtime = MapGpuProbeRuntime(
      configuration: const MapGpuProbeConfiguration(
        faultPoint: null,
        atlasFixture: MapSpriteAtlasProbeFixture.production,
      ),
    );
    final update = runtime.updateConfiguration(
      const MapGpuProbeConfiguration(
        faultPoint: null,
        atlasFixture: MapSpriteAtlasProbeFixture.alphaHalf,
      ),
    );
    final token = update.atlasTransitionToken;
    if (token == null) {
      fail('probe-enabled update must issue an atlas transition token');
    }
    final transition = runtime.consumeAtlasTransition(token);
    if (transition == null) {
      fail('fresh atlas transition token must be consumable');
    }
    final forged = createEarthquakeMapOverlaySnapshot(
      versionStamp: overlay.versionStamp,
      regionToCityZoom: overlay.regionToCityZoom,
      stationMinZoom: overlay.stationMinZoom,
      regionStyles: overlay.regionStyles,
      cityStyles: overlay.cityStyles,
      stations: const [
        EarthquakeObservationPoint(
          id: 'forged-station',
          longitude: 140,
          latitude: 36,
          color: Color(0xffffffff),
          radiusLogicalPixels: 4,
        ),
      ],
      spriteAtlas: overlay.spriteAtlas,
      sprites: overlay.sprites,
      maxSpritePolicyBatches: overlay.maxSpritePolicyBatches,
    );

    final result = applyMapGpuProbeAtlasFixtureTransition(
      sourceOverlay: overlay,
      currentOverlay: forged,
      transition: transition,
    );

    expect(result, isNull);
  });

  test(
    'frame resolver consumes atlas token once and caches the transition',
    () {
      if (!mapGpuProbeCompileTimeEnabled) {
        return;
      }
      final runtime = MapGpuProbeRuntime(
        configuration: const MapGpuProbeConfiguration(
          faultPoint: null,
          atlasFixture: MapSpriteAtlasProbeFixture.production,
        ),
      );
      final resolver = MapGpuProbeOverlayFrameResolver();
      final initial = resolver.resolve(
        sourceOverlay: overlay,
        currentOverlay: null,
        probeRuntime: runtime,
      );
      final update = runtime.updateConfiguration(
        const MapGpuProbeConfiguration(
          faultPoint: null,
          atlasFixture: MapSpriteAtlasProbeFixture.edgeBleed,
        ),
      );
      final token = update.atlasTransitionToken;
      if (token == null) {
        fail('probe-enabled update must issue an atlas transition token');
      }
      resolver.enqueue(token);

      final transitioned = resolver.resolve(
        sourceOverlay: overlay,
        currentOverlay: initial,
        probeRuntime: runtime,
      );
      final cached = resolver.resolve(
        sourceOverlay: overlay,
        currentOverlay: transitioned,
        probeRuntime: runtime,
      );

      expect(transitioned.versionStamp, same(overlay.versionStamp));
      expect(
        transitioned.spriteAtlas?.identity.value,
        'atlas-production:gpu-probe-edgeBleed-v1',
      );
      expect(cached, same(transitioned));
      expect(runtime.consumeAtlasTransition(token), isNull);
    },
  );
}

List<int> _pixel({
  required Uint8List bytes,
  required int width,
  required int x,
  required int y,
}) {
  final offset = (y * width + x) * MapSpriteAtlas.bytesPerPixel;
  return bytes.sublist(offset, offset + MapSpriteAtlas.bytesPerPixel);
}

EarthquakeMapOverlaySnapshot _overlayFixture() {
  final atlas = createMapSpriteAtlas(
    identity: createMapSourceIdentity(value: 'atlas-production'),
    width: 2,
    height: 2,
    rgbaBytes: Uint8List.fromList(const [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
    ]),
    regions: const [
      MapSpriteRegion(
        id: 'normal',
        normalizedUv: Rect.fromLTRB(0.25, 0.25, 0.75, 0.75),
        logicalSize: Size(2, 2),
      ),
    ],
    limits: const MapSpriteAtlasLimits(
      maxWidth: 2,
      maxHeight: 2,
      maxPixelBytes: 16,
      maxRegions: 1,
    ),
  );
  final sprite = createMapPointSpriteFeature(
    id: 'hypocenter:event-a',
    longitude: 139.7,
    latitude: 35.7,
    spriteRegionId: 'normal',
    sizeScale: createMapZoomLinearRange(
      startZoom: 3,
      startValue: 0.15,
      endZoom: 20,
      endValue: 0.4,
    ),
    opacity: createMapZoomStep(
      thresholdZoom: 8,
      belowValue: 1,
      atOrAboveValue: 0.6,
    ),
    priority: 10,
  );
  return createEarthquakeMapOverlaySnapshot(
    versionStamp: createMapOverlayVersionStamp(
      sourceIdentity: createMapSourceIdentity(value: 'event-a'),
      sourceIncarnation: createMapSourceIncarnation(value: 'incarnation-a'),
      dataSequence: 4,
      dataDigest: 'data-a',
      renderGeneration: 7,
      renderDigest: 'render-a',
    ),
    regionToCityZoom: 6,
    stationMinZoom: 6,
    regionStyles: const [
      EarthquakeAreaStyle(code: '100', color: Color(0xffff0000), opacity: 0.6),
    ],
    cityStyles: const [
      EarthquakeAreaStyle(code: '101', color: Color(0xff00ff00), opacity: 0.7),
    ],
    stations: const [
      EarthquakeObservationPoint(
        id: 'station-a',
        longitude: 139.8,
        latitude: 35.8,
        color: Color(0xff0000ff),
        radiusLogicalPixels: 4,
      ),
    ],
    spriteAtlas: atlas,
    sprites: [sprite],
    maxSpritePolicyBatches: 1,
  );
}
