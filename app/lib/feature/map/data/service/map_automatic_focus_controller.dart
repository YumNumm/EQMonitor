import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

const mapAutomaticFocusMaxZoom = 8.0;
const mapAutomaticFocusMercatorMaxLatitude = 85.05112878;
const mapAutomaticFocusTileSize = 512.0;

typedef MapAutomaticFocusTarget = ({Geographic center, double zoom});

MapAutomaticFocusTarget? mapAutomaticFocusTargetForBounds({
  required LngLatBounds bounds,
  required Size viewportSize,
  required EdgeInsets padding,
}) {
  final width = viewportSize.width - padding.horizontal;
  final height = viewportSize.height - padding.vertical;
  if (!width.isFinite || !height.isFinite || width <= 0 || height <= 0) {
    return null;
  }

  final south = bounds.latitudeSouth.clamp(
    -mapAutomaticFocusMercatorMaxLatitude,
    mapAutomaticFocusMercatorMaxLatitude,
  );
  final north = bounds.latitudeNorth.clamp(
    -mapAutomaticFocusMercatorMaxLatitude,
    mapAutomaticFocusMercatorMaxLatitude,
  );
  var longitudeDelta = bounds.longitudeEast - bounds.longitudeWest;
  if (longitudeDelta < 0) {
    longitudeDelta += 360;
  }
  if (!longitudeDelta.isFinite || longitudeDelta < 0 || longitudeDelta > 360) {
    return null;
  }
  final longitudeFraction = longitudeDelta / 360;
  final latitudeFraction =
      (mapAutomaticFocusMercatorY(latitude: north) -
              mapAutomaticFocusMercatorY(latitude: south))
          .abs() /
      (2 * math.pi);
  final zoomX = longitudeFraction == 0
      ? double.infinity
      : math.log(width / (mapAutomaticFocusTileSize * longitudeFraction)) /
            math.ln2;
  final zoomY = latitudeFraction == 0
      ? double.infinity
      : math.log(height / (mapAutomaticFocusTileSize * latitudeFraction)) /
            math.ln2;
  final zoom = math
      .min(zoomX, zoomY)
      .clamp(0.0, mapAutomaticFocusMaxZoom)
      .toDouble();
  if (!zoom.isFinite) {
    return null;
  }

  return (
    center: Geographic(
      lon: mapAutomaticFocusCenterLongitude(bounds: bounds),
      lat: mapAutomaticFocusCenterLatitude(south: south, north: north),
    ),
    zoom: zoom,
  );
}

double mapAutomaticFocusCenterLongitude({required LngLatBounds bounds}) {
  final adjustedEast = bounds.longitudeEast < bounds.longitudeWest
      ? bounds.longitudeEast + 360
      : bounds.longitudeEast;
  final center = (bounds.longitudeWest + adjustedEast) / 2;
  return center > 180 ? center - 360 : center;
}

double mapAutomaticFocusCenterLatitude({
  required double south,
  required double north,
}) {
  final southY = mapAutomaticFocusMercatorY(latitude: south);
  final northY = mapAutomaticFocusMercatorY(latitude: north);
  final centerRadians =
      2 * math.atan(math.exp((southY + northY) / 2)) - math.pi / 2;
  return centerRadians * 180 / math.pi;
}

double mapAutomaticFocusMercatorY({required double latitude}) {
  final radians = latitude * math.pi / 180;
  return math.log(math.tan(radians / 2 + math.pi / 4));
}

class MapAutomaticFocusController {
  const MapAutomaticFocusController();

  Future<bool> fit({
    required MapController controller,
    required LngLatBounds bounds,
    required Size viewportSize,
    required bool Function() isCurrent,
    EdgeInsets padding = EdgeInsets.zero,
    Duration nativeDuration = const Duration(seconds: 2),
    double bearing = 0,
    double pitch = 0,
  }) async {
    if (!isCurrent()) {
      return false;
    }
    final target = mapAutomaticFocusTargetForBounds(
      bounds: bounds,
      viewportSize: viewportSize,
      padding: padding,
    );
    if (target == null || !isCurrent()) {
      return false;
    }
    await controller.animateCamera(
      center: target.center,
      zoom: target.zoom,
      bearing: bearing,
      pitch: pitch,
      nativeDuration: nativeDuration,
      padding: padding,
    );
    return isCurrent();
  }
}
