import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';

/// A sprite region whose UV bounds point at content texel centers.
final class MapSpriteRegion {
  const MapSpriteRegion({
    required this.id,
    required this.normalizedUv,
    required this.logicalSize,
  });

  final String id;
  final Rect normalizedUv;
  final Size logicalSize;
}

/// Explicit caller-owned limits for an atlas allocation.
final class MapSpriteAtlasLimits {
  const MapSpriteAtlasLimits({
    required this.maxWidth,
    required this.maxHeight,
    required this.maxPixelBytes,
    required this.maxRegions,
  });

  final int maxWidth;
  final int maxHeight;
  final int maxPixelBytes;
  final int maxRegions;
}

/// Immutable top-left, tight-row, straight-alpha sRGB RGBA8888 sprite data.
final class MapSpriteAtlas {
  const MapSpriteAtlas._({
    required this.identity,
    required this.width,
    required this.height,
    required this.rgbaBytes,
    required this.regions,
  });

  static const bytesPerPixel = 4;
  static const regionExtrusionPixels = 2;

  final MapSourceIdentity identity;
  final int width;
  final int height;
  final Uint8List rgbaBytes;
  final List<MapSpriteRegion> regions;

  int get rowStrideBytes => width * bytesPerPixel;
}

MapSpriteAtlas createMapSpriteAtlas({
  required MapSourceIdentity identity,
  required int width,
  required int height,
  required Uint8List rgbaBytes,
  required List<MapSpriteRegion> regions,
  required MapSpriteAtlasLimits limits,
}) {
  _validateLimits(limits);
  if (width <= 0 || width > limits.maxWidth) {
    throw ArgumentError.value(width, 'width');
  }
  if (height <= 0 || height > limits.maxHeight) {
    throw ArgumentError.value(height, 'height');
  }
  final expectedByteCount = width * height * MapSpriteAtlas.bytesPerPixel;
  if (rgbaBytes.length != expectedByteCount ||
      rgbaBytes.length > limits.maxPixelBytes) {
    throw ArgumentError.value(rgbaBytes.length, 'rgbaBytes');
  }
  if (regions.length > limits.maxRegions) {
    throw ArgumentError.value(regions.length, 'regions');
  }
  _validateRegions(regions);

  return MapSpriteAtlas._(
    identity: identity,
    width: width,
    height: height,
    rgbaBytes: Uint8List.fromList(rgbaBytes).asUnmodifiableView(),
    regions: List<MapSpriteRegion>.unmodifiable(regions),
  );
}

void _validateLimits(MapSpriteAtlasLimits limits) {
  if (limits.maxWidth <= 0) {
    throw ArgumentError.value(limits.maxWidth, 'limits.maxWidth');
  }
  if (limits.maxHeight <= 0) {
    throw ArgumentError.value(limits.maxHeight, 'limits.maxHeight');
  }
  if (limits.maxPixelBytes <= 0) {
    throw ArgumentError.value(limits.maxPixelBytes, 'limits.maxPixelBytes');
  }
  if (limits.maxRegions <= 0) {
    throw ArgumentError.value(limits.maxRegions, 'limits.maxRegions');
  }
}

void _validateRegions(List<MapSpriteRegion> regions) {
  final ids = <String>{};
  for (final region in regions) {
    if (region.id.trim().isEmpty) {
      throw ArgumentError.value(region.id, 'regions.id');
    }
    if (!ids.add(region.id)) {
      throw ArgumentError.value(region.id, 'regions', 'contains duplicates');
    }
    final uv = region.normalizedUv;
    final coordinates = [uv.left, uv.top, uv.right, uv.bottom];
    if (coordinates.any((value) => !value.isFinite || value < 0 || value > 1) ||
        uv.left > uv.right ||
        uv.top > uv.bottom) {
      throw ArgumentError.value(uv, 'regions.normalizedUv');
    }
    final logicalSize = region.logicalSize;
    if (!logicalSize.width.isFinite ||
        logicalSize.width <= 0 ||
        !logicalSize.height.isFinite ||
        logicalSize.height <= 0) {
      throw ArgumentError.value(logicalSize, 'regions.logicalSize');
    }
  }
}
