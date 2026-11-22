import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:maplibre/maplibre.dart';

const mapAutomaticFocusMaxZoom = 7.0;
const mapAutomaticFocusMercatorMaxLatitude = 85.05112878;
const mapAutomaticFocusTileSize = 512.0;

typedef MapAutomaticFocusTarget = ({Geographic center, double zoom});

class const MapAutomaticFocusController() {
  Future<bool> fit({
    required MapController controller,
    required GeoBox bounds,
    required Size viewportSize,
    required bool Function() isCurrent,
    EdgeInsets padding = EdgeInsets.zero,
    Duration nativeDuration = const Duration(milliseconds: 500),
    double bearing = 0,
    double pitch = 0,
  }) async {
    if (!isCurrent()) {
      return false;
    }
    final target = targetForBounds(
      bounds: bounds,
      viewportSize: viewportSize,
      padding: padding,
    );
    if (target == null || !isCurrent()) {
      return false;
    }
    await controller.animateCamera(
      CameraUpdate.position(
        center: target.center,
        zoom: target.zoom,
        bearing: bearing,
        pitch: pitch,
        padding: padding,
      ),
      animation: CameraAnimation.fly(duration: nativeDuration),
    );
    return isCurrent();
  }

  static MapAutomaticFocusTarget? targetForBounds({
    required GeoBox bounds,
    required Size viewportSize,
    required EdgeInsets padding,
  }) {
    final width = viewportSize.width - padding.horizontal;
    final height = viewportSize.height - padding.vertical;
    if (!width.isFinite || !height.isFinite || width <= 0 || height <= 0) {
      return null;
    }
    if (!bounds.south.isFinite ||
        !bounds.north.isFinite ||
        !bounds.west.isFinite ||
        !bounds.east.isFinite) {
      return null;
    }
    if (bounds.south < -90 ||
        bounds.south > 90 ||
        bounds.north < -90 ||
        bounds.north > 90 ||
        bounds.west < -180 ||
        bounds.west > 180 ||
        bounds.east < -180 ||
        bounds.east > 180 ||
        bounds.south > bounds.north) {
      return null;
    }

    final south = bounds.south.clamp(
      -mapAutomaticFocusMercatorMaxLatitude,
      mapAutomaticFocusMercatorMaxLatitude,
    );
    final north = bounds.north.clamp(
      -mapAutomaticFocusMercatorMaxLatitude,
      mapAutomaticFocusMercatorMaxLatitude,
    );
    var longitudeDelta = bounds.east - bounds.west;
    if (longitudeDelta < 0) {
      longitudeDelta += 360;
    }
    if (!longitudeDelta.isFinite ||
        longitudeDelta < 0 ||
        longitudeDelta > 360) {
      return null;
    }
    final longitudeFraction = longitudeDelta / 360;
    final latitudeFraction =
        (mercatorY(latitude: north) - mercatorY(latitude: south)).abs() /
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
        lon: centerLongitude(bounds: bounds),
        lat: centerLatitude(south: south, north: north),
      ),
      zoom: zoom,
    );
  }

  static double centerLongitude({required GeoBox bounds}) {
    final adjustedEast = bounds.east < bounds.west
        ? bounds.east + 360
        : bounds.east;
    final center = (bounds.west + adjustedEast) / 2;
    return center > 180 ? center - 360 : center;
  }

  static double centerLatitude({required double south, required double north}) {
    final southY = mercatorY(latitude: south);
    final northY = mercatorY(latitude: north);
    final centerRadians =
        2 * math.atan(math.exp((southY + northY) / 2)) - math.pi / 2;
    return centerRadians * 180 / math.pi;
  }

  static double mercatorY({required double latitude}) {
    final radians = latitude * math.pi / 180;
    return math.log(math.tan(radians / 2 + math.pi / 4));
  }
}
