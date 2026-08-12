import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/render/map_render_batch.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/renderer/map_render_batch_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final frame = captureMapFrameSnapshot(
    clock: SystemMapClock.start(
      domain: createMapClockDomainId(value: 'submission-test'),
    ),
    frameNumber: 4,
    camera: const MapCamera(
      centerLongitude: 139.767,
      centerLatitude: 35.681,
      zoom: 8,
    ),
    viewport: MapViewport(
      logicalSize: const Size(390, 844),
      devicePixelRatio: 3,
    ),
    revisions: const [],
    lifecycle: .active,
    contextGeneration: 2,
  );

  test('owns the immutable frame and copied batch list', () {
    final batches = <MapRenderBatch>[];

    final submission = createMapRenderSubmission(
      frame: frame,
      batches: batches,
    );

    expect(submission.frame, same(frame));
    expect(submission.batches, isNot(same(batches)));
    expect(submission.batches, isEmpty);
    expect(submission.batches.clear, throwsUnsupportedError);
  });

  test('provides a Scene-independent adapter submission boundary', () {
    final submission = createMapRenderSubmission(
      frame: frame,
      batches: const [],
    );
    final adapter = LocalMapRenderBatchAdapter();

    adapter.submit(submission: submission);

    expect(adapter.submission, same(submission));
  });
}

final class LocalMapRenderBatchAdapter implements MapRenderBatchAdapter {
  MapRenderSubmission? submission;

  @override
  void submit({required MapRenderSubmission submission}) {
    this.submission = submission;
  }
}
