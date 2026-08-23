import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch.dart';
import 'package:eqmonitor_map/src/renderer/observation_point_batch_builder.dart';
import 'package:flutter_test/flutter_test.dart';

ObservationPointBatch _requireObservationPointBatch(
  ObservationPointBatch? batch,
) {
  if (batch == null) {
    fail('Expected a non-null ObservationPointBatch.');
  }
  return batch;
}

void main() {
  final clock = SystemMapClock.start(
    domain: createMapClockDomainId(value: 'observation-batch-test'),
  );
  final viewport = MapViewport(
    logicalSize: const Size(400, 800),
    devicePixelRatio: 3,
  );

  MapFrameSnapshot frame({
    int frameNumber = 0,
    double centerLongitude = 139.7,
    double centerLatitude = 35.7,
    double zoom = 6,
  }) => captureMapFrameSnapshot(
    clock: clock,
    frameNumber: frameNumber,
    camera: MapCamera(
      centerLongitude: centerLongitude,
      centerLatitude: centerLatitude,
      zoom: zoom,
    ),
    viewport: viewport,
    revisions: const [],
    lifecycle: MapAppLifecycle.active,
    contextGeneration: 0,
  );

  EarthquakeMapOverlaySnapshot snapshot({
    int revision = 3,
    List<EarthquakeObservationPoint> stations = const [
      EarthquakeObservationPoint(
        id: 'tokyo',
        longitude: 139.6917,
        latitude: 35.6895,
        color: Color.fromRGBO(32, 128, 240, 0.75),
        radiusLogicalPixels: 10,
      ),
    ],
  }) => createEarthquakeMapOverlaySnapshot(
    sourceId: 'event-1',
    revision: revision,
    regionToCityZoom: 6,
    stationMinZoom: 6,
    regionStyles: const [],
    cityStyles: const [],
    stations: stations,
  );

  test('packs Tokyo Mercator, RGBA, and radius at the 28-byte ABI offsets', () {
    final value = buildObservationPointBatch(
      frame: frame(),
      snapshot: snapshot(),
    );
    expect(value, isNotNull);
    final batch = _requireObservationPointBatch(value);
    final bytes = ByteData.sublistView(batch.instanceData);

    expect(batch.instanceStrideInBytes, 28);
    expect(bytes.lengthInBytes, 28);
    expect(bytes.getFloat32(0, Endian.little), closeTo(0.8880325, 1e-7));
    expect(
      bytes.getFloat32(4, Endian.little),
      closeTo(0.393749745244, 1e-7),
    );
    expect(bytes.getFloat32(8, Endian.little), closeTo(32 / 255, 1e-7));
    expect(bytes.getFloat32(12, Endian.little), closeTo(128 / 255, 1e-7));
    expect(bytes.getFloat32(16, Endian.little), closeTo(240 / 255, 1e-7));
    expect(bytes.getFloat32(20, Endian.little), closeTo(0.75, 1e-7));
    expect(bytes.getFloat32(24, Endian.little), 10);
  });

  test('packs the 32-byte ObservationFrame std140 offsets', () {
    final value = buildObservationPointBatch(
      frame: frame(),
      snapshot: snapshot(),
    );
    final batch = _requireObservationPointBatch(value);
    final bytes = batch.frameUniform;

    expect(bytes.lengthInBytes, 32);
    expect(bytes.getFloat32(0, Endian.little), closeTo(0.88805556, 1e-7));
    expect(
      bytes.getFloat32(4, Endian.little),
      closeTo(0.393713831763, 1e-7),
    );
    expect(bytes.getFloat32(8, Endian.little), 32768);
    expect(bytes.getFloat32(12, Endian.little), 0);
    expect(bytes.getFloat32(16, Endian.little), 400);
    expect(bytes.getFloat32(20, Endian.little), 800);
    expect(bytes.getFloat32(24, Endian.little), 1);
    expect(bytes.getFloat32(28, Endian.little), 0);
  });

  test('wraps a date-line delta to the nearest world copy', () {
    expect(
      nearestWrappedObservationWorldDelta(
        normalizedX: 0.999,
        cameraNormalizedX: 0.001,
      ),
      closeTo(-0.002, 1e-12),
    );
    expect(
      nearestWrappedObservationWorldDelta(
        normalizedX: 0.001,
        cameraNormalizedX: 0.999,
      ),
      closeTo(0.002, 1e-12),
    );
  });

  test('converts center and radius with logical pixels, never DPR', () {
    final center = observationPointNdc(
      normalizedX: 0.999,
      normalizedY: 0.5,
      cameraNormalizedX: 0.001,
      cameraNormalizedY: 0.499,
      worldSizeLogicalPixels: 1000,
      viewport: viewport,
    );
    final radius = observationRadiusNdc(
      radiusLogicalPixels: 10,
      viewport: viewport,
    );

    expect(center.x, closeTo(-0.01, 1e-12));
    expect(center.y, closeTo(-0.0025, 1e-12));
    expect(radius.x, 0.05);
    expect(radius.y, 0.025);
  });

  test('returns no batch for zero stations or below stationMinZoom', () {
    expect(
      buildObservationPointBatch(
        frame: frame(),
        snapshot: snapshot(stations: const []),
      ),
      isNull,
    );
    expect(
      buildObservationPointBatch(
        frame: frame(zoom: 5.999),
        snapshot: snapshot(),
      ),
      isNull,
    );
  });

  test(
    'same snapshot revision reuses instance bytes and updates only frame',
    () {
      final first = _requireObservationPointBatch(
        buildObservationPointBatch(
          frame: frame(),
          snapshot: snapshot(),
        ),
      );
      final second = _requireObservationPointBatch(
        buildObservationPointBatch(
          frame: frame(frameNumber: 1, centerLongitude: 140),
          snapshot: snapshot(),
          previous: first,
        ),
      );

      expect(second.instanceData, same(first.instanceData));
      expect(second.frameUniform, isNot(same(first.frameUniform)));
      expect(
        second.frameUniform.getFloat32(0, Endian.little),
        isNot(first.frameUniform.getFloat32(0, Endian.little)),
      );
    },
  );
}
