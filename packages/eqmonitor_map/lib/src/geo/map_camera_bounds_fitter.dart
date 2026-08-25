import 'dart:math' as math;

import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_camera_bounds.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:flutter/widgets.dart';

sealed class MapCameraBoundsFitResult {
  const MapCameraBoundsFitResult();
}

final class MapCameraBoundsFitSucceeded extends MapCameraBoundsFitResult {
  const MapCameraBoundsFitSucceeded({required this.camera});

  final MapCamera camera;
}

final class MapCameraBoundsFitInvalid extends MapCameraBoundsFitResult {
  const MapCameraBoundsFitInvalid({required this.reason});

  final MapCameraBoundsFitInvalidReason reason;
}

enum MapCameraBoundsFitInvalidReason {
  nonFiniteBounds,
  invalidBounds,
  invalidViewport,
  invalidDevicePixelRatio,
  invalidPadding,
  paddingConsumesViewport,
  invalidZoomRange,
}

/// Pure MapLibre-compatible fit-bounds calculation in logical pixels.
final class MapCameraBoundsFitter {
  const new();

  MapCameraBoundsFitResult fit({
    required MapCameraBounds bounds,
    required Size viewportLogicalSize,
    required double devicePixelRatio,
    required EdgeInsets padding,
    required double minZoom,
    required double maxZoom,
  }) {
    final coordinates = [
      bounds.west,
      bounds.south,
      bounds.east,
      bounds.north,
    ];
    if (coordinates.any((value) => !value.isFinite)) {
      return const MapCameraBoundsFitInvalid(
        reason: MapCameraBoundsFitInvalidReason.nonFiniteBounds,
      );
    }
    if (bounds.south < -MapMercatorProjection.maxLatitude ||
        bounds.north > MapMercatorProjection.maxLatitude ||
        bounds.south >= bounds.north) {
      return const MapCameraBoundsFitInvalid(
        reason: MapCameraBoundsFitInvalidReason.invalidBounds,
      );
    }
    final longitudeSpan = bounds.east >= bounds.west
        ? bounds.east - bounds.west
        : bounds.east + 360 - bounds.west;
    if (longitudeSpan <= 0 || longitudeSpan > 360) {
      return const MapCameraBoundsFitInvalid(
        reason: MapCameraBoundsFitInvalidReason.invalidBounds,
      );
    }
    if (!viewportLogicalSize.width.isFinite ||
        !viewportLogicalSize.height.isFinite ||
        viewportLogicalSize.width <= 0 ||
        viewportLogicalSize.height <= 0) {
      return const MapCameraBoundsFitInvalid(
        reason: MapCameraBoundsFitInvalidReason.invalidViewport,
      );
    }
    if (!devicePixelRatio.isFinite || devicePixelRatio <= 0) {
      return const MapCameraBoundsFitInvalid(
        reason: MapCameraBoundsFitInvalidReason.invalidDevicePixelRatio,
      );
    }
    final paddingValues = [
      padding.left,
      padding.top,
      padding.right,
      padding.bottom,
    ];
    if (paddingValues.any((value) => !value.isFinite || value < 0)) {
      return const MapCameraBoundsFitInvalid(
        reason: MapCameraBoundsFitInvalidReason.invalidPadding,
      );
    }
    final availableWidth =
        viewportLogicalSize.width - padding.left - padding.right;
    final availableHeight =
        viewportLogicalSize.height - padding.top - padding.bottom;
    if (availableWidth <= 0 || availableHeight <= 0) {
      return const MapCameraBoundsFitInvalid(
        reason: MapCameraBoundsFitInvalidReason.paddingConsumesViewport,
      );
    }
    if (!minZoom.isFinite || !maxZoom.isFinite || minZoom > maxZoom) {
      return const MapCameraBoundsFitInvalid(
        reason: MapCameraBoundsFitInvalidReason.invalidZoomRange,
      );
    }

    final southY = _mercatorYFromLatitude(bounds.south);
    final northY = _mercatorYFromLatitude(bounds.north);
    final normalizedWidth = longitudeSpan / 360;
    final normalizedHeight = southY - northY;
    final zoom = math
        .min(
          math.log(availableWidth / (normalizedWidth * 512)) / math.ln2,
          math.log(availableHeight / (normalizedHeight * 512)) / math.ln2,
        )
        .clamp(minZoom, maxZoom);
    final scale = math.pow(2, zoom).toDouble();
    final centerX =
        (bounds.west + 180) / 360 +
        normalizedWidth / 2 -
        (padding.left - padding.right) / (2 * 512 * scale);
    final centerY =
        (northY + southY) / 2 -
        (padding.top - padding.bottom) / (2 * 512 * scale);

    return MapCameraBoundsFitSucceeded(
      camera: MapCamera(
        centerLongitude: _wrappedLongitudeFromNormalizedX(centerX),
        centerLatitude: _latitudeFromMercatorY(centerY),
        zoom: zoom,
      ),
    );
  }
}

double _mercatorYFromLatitude(double latitude) {
  final radians = latitude * math.pi / 180;
  return 0.5 - math.log(math.tan(math.pi / 4 + radians / 2)) / (2 * math.pi);
}

double _latitudeFromMercatorY(double y) =>
    (2 * math.atan(math.exp(math.pi * (1 - 2 * y))) - math.pi / 2) *
    180 /
    math.pi;

double _wrappedLongitudeFromNormalizedX(double x) {
  final wrappedX = x - x.floor();
  return wrappedX * 360 - 180;
}
