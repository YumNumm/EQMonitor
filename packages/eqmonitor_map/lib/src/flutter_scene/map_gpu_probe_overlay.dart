import 'package:eqmonitor_map/src/flutter_scene/map_gpu_probe.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/map_sprite_atlas.dart';
import 'package:flutter/foundation.dart';

EarthquakeMapOverlaySnapshot? resolveMapGpuProbeOverlay({
  required EarthquakeMapOverlaySnapshot? overlay,
  required MapGpuProbeRuntime? probeRuntime,
}) {
  if (overlay == null || probeRuntime == null) {
    return overlay;
  }
  return applyMapGpuProbeAtlasFixture(
    overlay: overlay,
    fixture: probeRuntime.atlasFixture,
  );
}

final class MapGpuProbeOverlayFrameResolver {
  EarthquakeMapOverlaySnapshot? _cachedSourceOverlay;
  EarthquakeMapOverlaySnapshot? _cachedResolvedOverlay;
  final _pendingTokens = <MapGpuProbeAtlasTransitionToken>[];

  void enqueue(MapGpuProbeAtlasTransitionToken token) {
    _pendingTokens.add(token);
    _cachedSourceOverlay = null;
  }

  void invalidateSource() {
    _cachedSourceOverlay = null;
    _cachedResolvedOverlay = null;
  }

  EarthquakeMapOverlaySnapshot resolve({
    required EarthquakeMapOverlaySnapshot sourceOverlay,
    required EarthquakeMapOverlaySnapshot? currentOverlay,
    required MapGpuProbeRuntime? probeRuntime,
  }) {
    if (identical(_cachedSourceOverlay, sourceOverlay) &&
        _pendingTokens.isEmpty) {
      return _cachedResolvedOverlay ?? sourceOverlay;
    }
    var resolved = currentOverlay;
    final canApplySameVersionTransition =
        resolved != null &&
        resolved.versionStamp == sourceOverlay.versionStamp &&
        probeRuntime != null;
    if (canApplySameVersionTransition) {
      for (final token in _pendingTokens) {
        final transition = probeRuntime.consumeAtlasTransition(token);
        if (transition == null) {
          continue;
        }
        final transitionCurrent = resolved;
        if (transitionCurrent == null) {
          break;
        }
        final next = applyMapGpuProbeAtlasFixtureTransition(
          sourceOverlay: sourceOverlay,
          currentOverlay: transitionCurrent,
          transition: transition,
        );
        if (next == null) {
          break;
        }
        resolved = next;
      }
    } else {
      if (probeRuntime != null) {
        _pendingTokens.forEach(probeRuntime.consumeAtlasTransition);
      }
      resolved = resolveMapGpuProbeOverlay(
        overlay: sourceOverlay,
        probeRuntime: probeRuntime,
      );
    }
    _pendingTokens.clear();
    _cachedSourceOverlay = sourceOverlay;
    _cachedResolvedOverlay = resolved ?? sourceOverlay;
    return _cachedResolvedOverlay ?? sourceOverlay;
  }
}

EarthquakeMapOverlaySnapshot applyMapGpuProbeAtlasFixture({
  required EarthquakeMapOverlaySnapshot overlay,
  required MapSpriteAtlasProbeFixture fixture,
}) {
  final atlas = overlay.spriteAtlas;
  if (fixture == MapSpriteAtlasProbeFixture.production || atlas == null) {
    return overlay;
  }
  final fixtureAtlas = replaceMapSpriteAtlasTexture(
    atlas: atlas,
    identity: createMapSourceIdentity(
      value: '${atlas.identity.value}:gpu-probe-${fixture.name}-v1',
    ),
    rgbaBytes: createMapGpuProbeAtlasFixtureBytes(
      fixture: fixture,
      atlas: atlas,
    ),
  );
  return replaceEarthquakeMapOverlaySpriteAtlas(
    snapshot: overlay,
    spriteAtlas: fixtureAtlas,
  );
}

EarthquakeMapOverlaySnapshot? applyMapGpuProbeAtlasFixtureTransition({
  required EarthquakeMapOverlaySnapshot sourceOverlay,
  required EarthquakeMapOverlaySnapshot currentOverlay,
  required MapGpuProbeAtlasFixtureTransition transition,
}) {
  if (!mapGpuProbeCompileTimeEnabled) {
    return null;
  }
  final expectedCurrent = applyMapGpuProbeAtlasFixture(
    overlay: sourceOverlay,
    fixture: transition.previous,
  );
  if (!mapGpuProbeOverlayMatchesExpected(
    candidate: currentOverlay,
    expected: expectedCurrent,
  )) {
    return null;
  }
  return applyMapGpuProbeAtlasFixture(
    overlay: sourceOverlay,
    fixture: transition.next,
  );
}

bool mapGpuProbeOverlayMatchesExpected({
  required EarthquakeMapOverlaySnapshot candidate,
  required EarthquakeMapOverlaySnapshot expected,
}) {
  if (candidate.versionStamp != expected.versionStamp ||
      candidate.regionToCityZoom != expected.regionToCityZoom ||
      candidate.stationMinZoom != expected.stationMinZoom ||
      candidate.maxSpritePolicyBatches != expected.maxSpritePolicyBatches ||
      !identical(candidate.regionStyles, expected.regionStyles) ||
      !identical(candidate.cityStyles, expected.cityStyles) ||
      !identical(candidate.stations, expected.stations) ||
      !identical(candidate.sprites, expected.sprites)) {
    return false;
  }
  final candidateAtlas = candidate.spriteAtlas;
  final expectedAtlas = expected.spriteAtlas;
  if (candidateAtlas == null || expectedAtlas == null) {
    return candidateAtlas == null && expectedAtlas == null;
  }
  return candidateAtlas.identity == expectedAtlas.identity &&
      candidateAtlas.width == expectedAtlas.width &&
      candidateAtlas.height == expectedAtlas.height &&
      identical(candidateAtlas.regions, expectedAtlas.regions) &&
      listEquals(candidateAtlas.rgbaBytes, expectedAtlas.rgbaBytes);
}

Uint8List createMapGpuProbeAtlasFixtureBytes({
  required MapSpriteAtlasProbeFixture fixture,
  required MapSpriteAtlas atlas,
}) {
  final bytes = Uint8List(atlas.rgbaBytes.length);
  if (fixture == MapSpriteAtlasProbeFixture.edgeBleed) {
    for (
      var offset = 0;
      offset < bytes.length;
      offset += MapSpriteAtlas.bytesPerPixel
    ) {
      bytes.setRange(
        offset,
        offset + MapSpriteAtlas.bytesPerPixel,
        const [255, 0, 255, 0],
      );
    }
  }
  for (var regionIndex = 0; regionIndex < atlas.regions.length; regionIndex++) {
    final region = atlas.regions[regionIndex];
    final contentLeft = (region.normalizedUv.left * atlas.width - 0.5).round();
    final contentTop = (region.normalizedUv.top * atlas.height - 0.5).round();
    final contentRight = (region.normalizedUv.right * atlas.width - 0.5)
        .round();
    final contentBottom = (region.normalizedUv.bottom * atlas.height - 0.5)
        .round();
    final cellLeft = (contentLeft - MapSpriteAtlas.regionExtrusionPixels).clamp(
      0,
      atlas.width - 1,
    );
    final cellTop = (contentTop - MapSpriteAtlas.regionExtrusionPixels).clamp(
      0,
      atlas.height - 1,
    );
    final cellRight = (contentRight + MapSpriteAtlas.regionExtrusionPixels)
        .clamp(0, atlas.width - 1);
    final cellBottom = (contentBottom + MapSpriteAtlas.regionExtrusionPixels)
        .clamp(0, atlas.height - 1);
    for (var y = cellTop; y <= cellBottom; y++) {
      final sourceY = y < contentTop
          ? 0
          : y > contentBottom
          ? contentBottom - contentTop
          : y - contentTop;
      for (var x = cellLeft; x <= cellRight; x++) {
        final sourceX = x < contentLeft
            ? 0
            : x > contentRight
            ? contentRight - contentLeft
            : x - contentLeft;
        final rgba = switch (fixture) {
          MapSpriteAtlasProbeFixture.production => const [0, 0, 0, 0],
          MapSpriteAtlasProbeFixture.orientation2x2 => switch ((
            sourceX % 2,
            sourceY % 2,
          )) {
            (0, 0) => const [255, 0, 0, 255],
            (1, 0) => const [0, 255, 0, 255],
            (0, 1) => const [0, 0, 255, 255],
            (1, 1) => const [255, 255, 255, 255],
            _ => const [0, 0, 0, 0],
          },
          MapSpriteAtlasProbeFixture.alphaHalf => const [255, 255, 255, 128],
          MapSpriteAtlasProbeFixture.edgeBleed =>
            regionIndex.isEven
                ? const [0, 255, 255, 255]
                : const [255, 255, 0, 255],
        };
        final offset = (y * atlas.width + x) * MapSpriteAtlas.bytesPerPixel;
        bytes.setRange(offset, offset + MapSpriteAtlas.bytesPerPixel, rgba);
      }
    }
  }
  return bytes;
}
