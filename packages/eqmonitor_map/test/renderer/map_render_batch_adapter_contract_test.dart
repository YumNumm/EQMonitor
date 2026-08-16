import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/recording_map_render_batch_adapter.dart';

void main() {
  final frame = captureMapFrameSnapshot(
    clock: SystemMapClock.start(domain: createMapClockDomainId(value: 'test')),
    frameNumber: 0,
    camera: const MapCamera(centerLongitude: 0, centerLatitude: 0, zoom: 0),
    viewport: MapViewport(logicalSize: const Size(1, 1), devicePixelRatio: 1),
    revisions: const [],
    lifecycle: .active,
    contextGeneration: 0,
  );
  const batch = buildMapRenderBatchForAdapterTest;

  MapRenderSubmission submission(List<MapRenderBatch> batches) =>
      createMapRenderSubmission(frame: frame, batches: batches);

  test('records one render object for each valid canonical batch', () {
    final value = submission([
      batch(
        version: 1,
        policyVersion: 1,
        phase: 0,
        order: 0,
        packetCount: 2,
      ),
      batch(version: 1, policyVersion: 1, phase: 1, order: 0),
    ]);
    final adapter = RecordingMapRenderBatchAdapter();

    adapter.submit(submission: value);

    expect(adapter.submissions.single, same(value));
    expect(adapter.createdRenderObjectCount, value.batches.length);
  });

  test('rejects cross-batch version, policy, phase, and order mismatch', () {
    final invalid = [
      [
        batch(version: 1, policyVersion: 1, phase: 0, order: 0),
        batch(version: 2, policyVersion: 1, phase: 0, order: 1),
      ],
      [
        batch(version: 1, policyVersion: 1, phase: 0, order: 0),
        batch(version: 1, policyVersion: 2, phase: 0, order: 1),
      ],
      [
        batch(version: 1, policyVersion: 1, phase: 1, order: 0),
        batch(version: 1, policyVersion: 1, phase: 0, order: 0),
      ],
      [
        batch(version: 1, policyVersion: 1, phase: 0, order: 1),
        batch(version: 1, policyVersion: 1, phase: 0, order: 0),
      ],
    ];

    for (final batches in invalid) {
      expect(
        () => validateMapRenderSubmission(submission: submission(batches)),
        throwsArgumentError,
      );
    }
  });
}
