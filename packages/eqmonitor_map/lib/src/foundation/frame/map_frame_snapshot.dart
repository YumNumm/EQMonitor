import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_revision.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';

enum MapAppLifecycle { active, inactive, background, detached }

final class MapFrameSnapshot {
  const new _({
    required this.clockCapture,
    required this.frameNumber,
    required this.camera,
    required this.viewport,
    required this.revisions,
    required this.lifecycle,
    required this.contextGeneration,
  });

  final MapClockCapture clockCapture;
  final int frameNumber;
  final MapCamera camera;
  final MapViewport viewport;
  final List<MapFrameRevisionStamp> revisions;
  final MapAppLifecycle lifecycle;
  final int contextGeneration;
}

MapFrameSnapshot captureMapFrameSnapshot({
  required MapClock clock,
  required int frameNumber,
  required MapCamera camera,
  required MapViewport viewport,
  required List<MapFrameRevisionStamp> revisions,
  required MapAppLifecycle lifecycle,
  required int contextGeneration,
}) {
  if (frameNumber.isNegative) {
    throw ArgumentError.value(
      frameNumber,
      'frameNumber',
      'must not be negative',
    );
  }
  if (contextGeneration.isNegative) {
    throw ArgumentError.value(
      contextGeneration,
      'contextGeneration',
      'must not be negative',
    );
  }

  final canonicalRevisions = canonicalizeMapFrameRevisions(
    revisions: revisions,
  );
  final capture = clock.capture();
  return MapFrameSnapshot._(
    clockCapture: capture,
    frameNumber: frameNumber,
    camera: MapCamera(
      centerLongitude: camera.centerLongitude,
      centerLatitude: camera.centerLatitude,
      zoom: camera.zoom,
    ),
    viewport: MapViewport(
      logicalSize: Size(
        viewport.logicalSize.width,
        viewport.logicalSize.height,
      ),
      devicePixelRatio: viewport.devicePixelRatio,
    ),
    revisions: canonicalRevisions,
    lifecycle: lifecycle,
    contextGeneration: contextGeneration,
  );
}
