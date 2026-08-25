import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';

const earthquakeMapNormalSpriteRegionId = 'normal';
const earthquakeMapLowPrecisionSpriteRegionId = 'low-precision';

final class EarthquakeMapSpriteImage {
  new({required int width, required int height, required Uint8List rgbaBytes})
    : width = width,
      height = height,
      rgbaBytes = Uint8List.fromList(rgbaBytes).asUnmodifiableView() {
    if (width <= 0) {
      throw ArgumentError.value(width, 'width', 'must be positive');
    }
    if (height <= 0) {
      throw ArgumentError.value(height, 'height', 'must be positive');
    }
    final hasTightPixels =
        rgbaBytes.length.remainder(MapSpriteAtlas.bytesPerPixel) == 0 &&
        rgbaBytes.length ~/ MapSpriteAtlas.bytesPerPixel ~/ width == height &&
        rgbaBytes.length ~/ MapSpriteAtlas.bytesPerPixel % width == 0;
    if (!hasTightPixels) {
      throw ArgumentError.value(rgbaBytes.length, 'rgbaBytes');
    }
  }

  final int width;
  final int height;
  final Uint8List rgbaBytes;
}

final class EarthquakeMapSpriteAtlasBuilder {
  const new();

  MapSpriteAtlas build({
    required EarthquakeMapSpriteImage normalImage,
    required EarthquakeMapSpriteImage lowPrecisionImage,
    required MapSpriteAtlasLimits limits,
  }) {
    const limitValidator = _EarthquakeMapSpriteAtlasLimitValidator();
    limitValidator.validateDimensions(
      normalImage: normalImage,
      lowPrecisionImage: lowPrecisionImage,
      limits: limits,
    );
    final layout = _EarthquakeMapSpriteAtlasLayout(
      normalImage: normalImage,
      lowPrecisionImage: lowPrecisionImage,
    );
    final rgbaBytes = Uint8List(
      limitValidator.validatedByteCount(layout: layout, limits: limits),
    );
    for (final placement in layout.placements) {
      placement.blitTo(atlasWidth: layout.width, destination: rgbaBytes);
    }
    final regions = [
      for (final placement in layout.placements)
        placement.toRegion(
          atlasWidth: layout.width,
          atlasHeight: layout.height,
        ),
    ];
    return createMapSpriteAtlas(
      identity: createMapSourceIdentity(
        value: const _EarthquakeMapSpriteAtlasIdentityBuilder().build(
          layout: layout,
          rgbaBytes: rgbaBytes,
        ),
      ),
      width: layout.width,
      height: layout.height,
      rgbaBytes: rgbaBytes,
      regions: regions,
      limits: limits,
    );
  }
}

final class _EarthquakeMapSpriteAtlasLayout {
  new({
    required EarthquakeMapSpriteImage normalImage,
    required EarthquakeMapSpriteImage lowPrecisionImage,
  }) : placements = [
         _EarthquakeMapSpritePlacement(
           regionId: earthquakeMapNormalSpriteRegionId,
           image: normalImage,
           cellLeft: 0,
         ),
         _EarthquakeMapSpritePlacement(
           regionId: earthquakeMapLowPrecisionSpriteRegionId,
           image: lowPrecisionImage,
           cellLeft: normalImage.width + _padding * 2,
         ),
       ],
       width = normalImage.width + lowPrecisionImage.width + _padding * 4,
       height =
           (normalImage.height > lowPrecisionImage.height
               ? normalImage.height
               : lowPrecisionImage.height) +
           _padding * 2;

  static const _padding = MapSpriteAtlas.regionExtrusionPixels;

  final List<_EarthquakeMapSpritePlacement> placements;
  final int width;
  final int height;
}

final class _EarthquakeMapSpriteAtlasLimitValidator {
  const new();

  void validateDimensions({
    required EarthquakeMapSpriteImage normalImage,
    required EarthquakeMapSpriteImage lowPrecisionImage,
    required MapSpriteAtlasLimits limits,
  }) {
    if (limits.maxWidth <= 0 ||
        limits.maxHeight <= 0 ||
        limits.maxPixelBytes <= 0 ||
        limits.maxRegions <= 0) {
      throw ArgumentError.value(limits, 'limits');
    }
    if (limits.maxRegions < 2) {
      throw ArgumentError.value(2, 'regions');
    }
    final horizontalPadding = MapSpriteAtlas.regionExtrusionPixels * 4;
    if (horizontalPadding > limits.maxWidth ||
        normalImage.width > limits.maxWidth - horizontalPadding ||
        lowPrecisionImage.width >
            limits.maxWidth - horizontalPadding - normalImage.width) {
      throw ArgumentError.value(limits.maxWidth, 'limits.maxWidth');
    }
    final verticalPadding = MapSpriteAtlas.regionExtrusionPixels * 2;
    final sourceHeight = normalImage.height > lowPrecisionImage.height
        ? normalImage.height
        : lowPrecisionImage.height;
    if (verticalPadding > limits.maxHeight ||
        sourceHeight > limits.maxHeight - verticalPadding) {
      throw ArgumentError.value(limits.maxHeight, 'limits.maxHeight');
    }
  }

  int validatedByteCount({
    required _EarthquakeMapSpriteAtlasLayout layout,
    required MapSpriteAtlasLimits limits,
  }) {
    if (layout.width > limits.maxPixelBytes ~/ MapSpriteAtlas.bytesPerPixel) {
      throw ArgumentError.value(limits.maxPixelBytes, 'limits.maxPixelBytes');
    }
    final rowByteCount = layout.width * MapSpriteAtlas.bytesPerPixel;
    if (layout.height > limits.maxPixelBytes ~/ rowByteCount) {
      throw ArgumentError.value(limits.maxPixelBytes, 'limits.maxPixelBytes');
    }
    return rowByteCount * layout.height;
  }
}

final class _EarthquakeMapSpritePlacement {
  const new({
    required this.regionId,
    required this.image,
    required this.cellLeft,
  });

  static const _padding = MapSpriteAtlas.regionExtrusionPixels;

  final String regionId;
  final EarthquakeMapSpriteImage image;
  final int cellLeft;

  int get cellWidth => image.width + _padding * 2;

  void blitTo({required int atlasWidth, required Uint8List destination}) {
    for (var cellY = 0; cellY < image.height + _padding * 2; cellY++) {
      final sourceY = clampedSourceIndex(
        cellIndex: cellY,
        sourceLength: image.height,
      );
      for (var cellX = 0; cellX < cellWidth; cellX++) {
        final sourceX = clampedSourceIndex(
          cellIndex: cellX,
          sourceLength: image.width,
        );
        final sourceOffset =
            (sourceY * image.width + sourceX) * MapSpriteAtlas.bytesPerPixel;
        final destinationOffset =
            (cellY * atlasWidth + cellLeft + cellX) *
            MapSpriteAtlas.bytesPerPixel;
        destination.setRange(
          destinationOffset,
          destinationOffset + MapSpriteAtlas.bytesPerPixel,
          image.rgbaBytes,
          sourceOffset,
        );
      }
    }
  }

  MapSpriteRegion toRegion({
    required int atlasWidth,
    required int atlasHeight,
  }) {
    final contentLeft = cellLeft + _padding;
    const contentTop = _padding;
    return MapSpriteRegion(
      id: regionId,
      normalizedUv: Rect.fromLTRB(
        (contentLeft + 0.5) / atlasWidth,
        (contentTop + 0.5) / atlasHeight,
        (contentLeft + image.width - 0.5) / atlasWidth,
        (contentTop + image.height - 0.5) / atlasHeight,
      ),
      logicalSize: Size(image.width.toDouble(), image.height.toDouble()),
    );
  }

  int clampedSourceIndex({required int cellIndex, required int sourceLength}) {
    final contentIndex = cellIndex - MapSpriteAtlas.regionExtrusionPixels;
    if (contentIndex < 0) {
      return 0;
    }
    if (contentIndex >= sourceLength) {
      return sourceLength - 1;
    }
    return contentIndex;
  }
}

final class _EarthquakeMapSpriteAtlasIdentityBuilder {
  const new();

  String build({
    required _EarthquakeMapSpriteAtlasLayout layout,
    required Uint8List rgbaBytes,
  }) {
    final digestInput = BytesBuilder(copy: false);
    appendField(
      destination: digestInput,
      tag: 'format',
      value: 'earthquake-map-sprite-atlas-v1',
    );
    appendField(
      destination: digestInput,
      tag: 'size',
      value: '${layout.width}x${layout.height}',
    );
    for (final placement in layout.placements) {
      appendField(
        destination: digestInput,
        tag: 'region',
        value:
            '${placement.regionId}:${placement.cellLeft}:'
            '${placement.image.width}x${placement.image.height}',
      );
    }
    appendField(
      destination: digestInput,
      tag: 'rgbaLength',
      value: rgbaBytes.length.toString(),
    );
    digestInput.add(rgbaBytes);
    return 'sha256:${sha256.convert(digestInput.takeBytes())}';
  }

  void appendField({
    required BytesBuilder destination,
    required String tag,
    required String value,
  }) {
    final tagBytes = utf8.encode(tag);
    final valueBytes = utf8.encode(value);
    destination
      ..add(ascii.encode('${tagBytes.length}:'))
      ..add(tagBytes)
      ..add(ascii.encode('${valueBytes.length}:'))
      ..add(valueBytes);
  }
}
