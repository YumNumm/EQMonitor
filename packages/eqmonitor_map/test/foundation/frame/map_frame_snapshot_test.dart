import 'dart:ui';

import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_revision.dart';
import 'package:eqmonitor_map/src/foundation/frame/map_frame_snapshot.dart';
import 'package:eqmonitor_map/src/foundation/map_node_identity.dart';
import 'package:eqmonitor_map/src/foundation/revision/map_source_identity.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final domain = createMapClockDomainId(value: 'render-loop');

  test('captures the clock once and fixes the complete frame state', () {
    final clock = CountingMapClock(domain: domain);
    final source = createMapSourceInstanceId(value: 'base-map');
    final digest = createMapContentDigest(value: 'sha256:base-map');
    final owner = createMapNodeKey(value: 'prefecture-labels');
    final revisions = [
      createMapFrameLayerRevisionStamp(
        sourceInstanceId: source,
        ownerKey: owner,
        revision: 4,
      ),
      createMapFrameSourceRevisionStamp(
        sourceInstanceId: source,
        revision: 9,
        contentDigest: digest,
      ),
    ];

    final snapshot = captureMapFrameSnapshot(
      clock: clock,
      frameNumber: 12,
      camera: const MapCamera(
        centerLongitude: 139.767,
        centerLatitude: 35.681,
        zoom: 8.5,
      ),
      viewport: MapViewport(
        logicalSize: const Size(390, 844),
        devicePixelRatio: 3,
      ),
      revisions: revisions,
      lifecycle: MapAppLifecycle.active,
      contextGeneration: 3,
    );

    expect(clock.captureCount, 1);
    expect(snapshot.clockCapture.domain, domain);
    expect(snapshot.frameNumber, 12);
    expect(snapshot.camera.centerLongitude, 139.767);
    expect(snapshot.viewport.logicalSize, const Size(390, 844));
    expect(snapshot.lifecycle, MapAppLifecycle.active);
    expect(snapshot.contextGeneration, 3);
    expect(snapshot.revisions.map((revision) => revision.scope), [
      MapFrameRevisionScope.source,
      MapFrameRevisionScope.layer,
    ]);
  });

  test('rejects negative frame or context generation before clock capture', () {
    final clock = CountingMapClock(domain: domain);
    const camera = MapCamera(
      centerLongitude: 139.767,
      centerLatitude: 35.681,
      zoom: 8.5,
    );
    final viewport = MapViewport(
      logicalSize: const Size(390, 844),
      devicePixelRatio: 3,
    );

    expect(
      () => captureMapFrameSnapshot(
        clock: clock,
        frameNumber: -1,
        camera: camera,
        viewport: viewport,
        revisions: const [],
        lifecycle: MapAppLifecycle.active,
        contextGeneration: 0,
      ),
      throwsArgumentError,
    );
    expect(
      () => captureMapFrameSnapshot(
        clock: clock,
        frameNumber: 0,
        camera: camera,
        viewport: viewport,
        revisions: const [],
        lifecycle: MapAppLifecycle.active,
        contextGeneration: -1,
      ),
      throwsArgumentError,
    );
    final source = createMapSourceInstanceId(value: 'base-map');
    final duplicateRevisions = [
      createMapFrameSourceRevisionStamp(
        sourceInstanceId: source,
        revision: 1,
        contentDigest: createMapContentDigest(value: 'sha256:first'),
      ),
      createMapFrameSourceRevisionStamp(
        sourceInstanceId: source,
        revision: 2,
        contentDigest: createMapContentDigest(value: 'sha256:second'),
      ),
    ];
    expect(
      () => captureMapFrameSnapshot(
        clock: clock,
        frameNumber: 0,
        camera: camera,
        viewport: viewport,
        revisions: duplicateRevisions,
        lifecycle: MapAppLifecycle.active,
        contextGeneration: 0,
      ),
      throwsArgumentError,
    );
    expect(clock.captureCount, 0);
  });

  test(
    'deep-owns canonical revisions and immutable camera viewport values',
    () {
      final clock = CountingMapClock(domain: domain);
      final source = createMapSourceInstanceId(value: 'base-map');
      final sourceRevision = createMapFrameSourceRevisionStamp(
        sourceInstanceId: source,
        revision: 9,
        contentDigest: createMapContentDigest(value: 'sha256:base-map'),
      );
      final revisions = [sourceRevision];
      const camera = MapCamera(
        centerLongitude: 139.767,
        centerLatitude: 35.681,
        zoom: 8.5,
      );
      final viewport = MapViewport(
        logicalSize: const Size(390, 844),
        devicePixelRatio: 3,
      );

      final snapshot = captureMapFrameSnapshot(
        clock: clock,
        frameNumber: 1,
        camera: camera,
        viewport: viewport,
        revisions: revisions,
        lifecycle: MapAppLifecycle.background,
        contextGeneration: 0,
      );
      revisions.clear();

      expect(snapshot.revisions, [sourceRevision]);
      expect(snapshot.revisions.clear, throwsUnsupportedError);
      expect(snapshot.camera, isNot(same(camera)));
      expect(snapshot.viewport, isNot(same(viewport)));
    },
  );
}

final class CountingMapClock implements MapClock {
  CountingMapClock({required this.domain});

  final MapClockDomainId domain;
  final MapMonotonicSourceIdentity _sourceIdentity =
      createMapMonotonicSourceIdentity();
  var _captureCount = 0;

  int get captureCount => _captureCount;

  @override
  MapClockCapture capture() {
    _captureCount += 1;
    final instant = createMapMonotonicInstant(
      domain: domain,
      sourceIdentity: _sourceIdentity,
      elapsed: Duration(microseconds: _captureCount),
    );
    return createMapClockCapture(
      domain: domain,
      sourceIdentity: _sourceIdentity,
      wallInstant: createMapWallInstant(value: DateTime.utc(2026, 8, 9)),
      monotonicInstant: instant,
      previousMonotonicInstant: null,
    );
  }
}
