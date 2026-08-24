import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/renderer/map_scene_render_phase_policy.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';

/// snapshotとframeから単一観測点instance batchを構築する。
ObservationPointBatch? buildObservationPointBatch({
  required MapFrameSnapshot frame,
  required EarthquakeMapOverlaySnapshot snapshot,
  ObservationPointBatch? previous,
  double strokeLogicalPixels = 1,
  MapMercatorProjection projection = const MapMercatorProjection(),
}) {
  if (snapshot.stations.isEmpty ||
      frame.camera.zoom < snapshot.stationMinZoom) {
    return null;
  }
  if (!strokeLogicalPixels.isFinite || strokeLogicalPixels <= 0) {
    throw ArgumentError.value(
      strokeLogicalPixels,
      'strokeLogicalPixels',
      'must be finite and positive',
    );
  }

  final canReuse =
      previous != null &&
      previous.versionStamp == snapshot.versionStamp &&
      previous.hasStationSnapshotIdentity(snapshot.stations);
  if (canReuse && previous.instanceCount != snapshot.stations.length) {
    throw StateError(
      'Observation station count changed without a version stamp change.',
    );
  }
  final frameUniform = packObservationFrameUniform(
    frame: frame,
    strokeLogicalPixels: strokeLogicalPixels,
    projection: projection,
  );
  if (canReuse) {
    return previous.withFrame(frame: frame, frameUniform: frameUniform);
  }
  final instanceData = packObservationPointInstances(
    stations: snapshot.stations,
    projection: projection,
  );
  final phase = mapSceneRenderPhasePolicy.rankOf(
    mapSceneLivePointPhaseId,
  );
  return createObservationPointBatch(
    frame: frame,
    versionStamp: snapshot.versionStamp,
    instanceData: instanceData,
    instanceCount: snapshot.stations.length,
    frameUniform: frameUniform,
    phasePolicyVersion: mapSceneRenderPhasePolicy.version,
    phase: phase,
    translucentSortPriority: mapSceneTranslucentSortPriorityFor(phase: phase),
    stationSnapshotIdentity: snapshot.stations,
  );
}

/// 全観測点を28-byte little-endian instance列へ詰める。
Float32List packObservationPointInstances({
  required List<EarthquakeObservationPoint> stations,
  MapMercatorProjection projection = const MapMercatorProjection(),
}) {
  final data = Float32List(stations.length * 7);
  final bytes = ByteData.sublistView(data);
  for (final (index, station) in stations.indexed) {
    final center = projection.lngLatToNormalized(
      longitude: station.longitude,
      latitude: station.latitude,
    );
    final offset = index * observationPointInstanceStrideInBytes;
    bytes
      ..setFloat32(offset, center.x, Endian.little)
      ..setFloat32(offset + 4, center.y, Endian.little)
      ..setFloat32(offset + 8, station.color.r, Endian.little)
      ..setFloat32(offset + 12, station.color.g, Endian.little)
      ..setFloat32(offset + 16, station.color.b, Endian.little)
      ..setFloat32(offset + 20, station.color.a, Endian.little)
      ..setFloat32(
        offset + 24,
        station.radiusLogicalPixels,
        Endian.little,
      );
  }
  return data;
}

/// ObservationFrameをstd140 vec4二本、32 byteへ詰める。
ByteData packObservationFrameUniform({
  required MapFrameSnapshot frame,
  required double strokeLogicalPixels,
  MapMercatorProjection projection = const MapMercatorProjection(),
}) {
  final camera = projection.lngLatToNormalized(
    longitude: frame.camera.centerLongitude,
    latitude: frame.camera.centerLatitude,
  );
  return ByteData(observationFrameUniformByteLength)
    ..setFloat32(0, camera.x, Endian.little)
    ..setFloat32(4, camera.y, Endian.little)
    ..setFloat32(
      8,
      projection.worldSizeForZoom(frame.camera.zoom),
      Endian.little,
    )
    ..setFloat32(16, frame.viewport.logicalSize.width, Endian.little)
    ..setFloat32(20, frame.viewport.logicalSize.height, Endian.little)
    ..setFloat32(24, strokeLogicalPixels, Endian.little);
}

/// cameraに最も近いworld copyまでのnormalized X差。
double nearestWrappedObservationWorldDelta({
  required double normalizedX,
  required double cameraNormalizedX,
}) {
  if (!normalizedX.isFinite || !cameraNormalizedX.isFinite) {
    throw ArgumentError('normalized X coordinates must be finite');
  }
  final delta = normalizedX - cameraNormalizedX;
  return delta - delta.round();
}

/// shaderと同じ式で観測点中心をNDCへ変換するpure reference。
({double x, double y}) observationPointNdc({
  required double normalizedX,
  required double normalizedY,
  required double cameraNormalizedX,
  required double cameraNormalizedY,
  required double worldSizeLogicalPixels,
  required MapViewport viewport,
}) {
  if (!normalizedY.isFinite ||
      !cameraNormalizedY.isFinite ||
      !worldSizeLogicalPixels.isFinite ||
      worldSizeLogicalPixels <= 0) {
    throw ArgumentError(
      'projection inputs must be finite and worldSize positive',
    );
  }
  final logicalX =
      nearestWrappedObservationWorldDelta(
        normalizedX: normalizedX,
        cameraNormalizedX: cameraNormalizedX,
      ) *
      worldSizeLogicalPixels;
  final logicalY = (normalizedY - cameraNormalizedY) * worldSizeLogicalPixels;
  return (
    x: logicalX * 2 / viewport.logicalSize.width,
    y: -logicalY * 2 / viewport.logicalSize.height,
  );
}

/// logical pixel半径をX/YのNDC半径へ変換する。
({double x, double y}) observationRadiusNdc({
  required double radiusLogicalPixels,
  required MapViewport viewport,
}) {
  if (!radiusLogicalPixels.isFinite || radiusLogicalPixels <= 0) {
    throw ArgumentError.value(
      radiusLogicalPixels,
      'radiusLogicalPixels',
      'must be finite and positive',
    );
  }
  return (
    x: radiusLogicalPixels * 2 / viewport.logicalSize.width,
    y: radiusLogicalPixels * 2 / viewport.logicalSize.height,
  );
}
