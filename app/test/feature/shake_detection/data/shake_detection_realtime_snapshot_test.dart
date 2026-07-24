import 'dart:async';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/repository/shake_detection_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

final class _RepositorySpy implements ShakeDetectionRepository {
  int fetchCount = 0;

  @override
  Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  fetchActive() async {
    fetchCount += 1;
    throw StateError('REST must not be called for realtime snapshots');
  }
}

void main() {
  test('newer revisionでpoints/mergeを含むsnapshot全体をRESTなしに置換すること', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final repository = _RepositorySpy();
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        shakeDetectionRepositoryProvider.overrideWith(
          (ref) async => repository,
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(shakeDetectionProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.pump();

    controller.add(_event(_snapshot(revision: 1, eventId: 'old')));
    await container.pump();
    controller.add(_event(_snapshot(revision: 2, eventId: 'new')));
    await container.pump();

    final accepted = container.read(shakeDetectionAcceptedSnapshotProvider);
    expect(accepted?.revision, 2);
    expect(accepted?.events.map((event) => event.eventId), ['new']);
    expect(accepted?.events.single.points.single.code, 'point-new');
    expect(accepted?.events.single.mergedEvents.single.eventId, 'merged-new');
    expect(identical(accepted?.sourceRecord, _latestRecord), isTrue);
    expect(repository.fetchCount, 0);

    controller.add(_event(_snapshot(revision: 1, eventId: 'stale')));
    await container.pump();
    expect(
      container
          .read(shakeDetectionAcceptedSnapshotProvider)
          ?.events
          .single
          .eventId,
      'new',
    );

    controller.add(
      _event(
        api.ShakeDetectionActiveSnapshot(
          type: 'shake_detection',
          revision: 3,
          responseAt: DateTime.utc(2026, 7, 23, 12, 1),
          events: const [],
        ),
      ),
    );
    await container.pump();
    expect(container.read(shakeDetectionProvider), isEmpty);
    expect(repository.fetchCount, 0);
  });
}

api.ShakeDetectionActiveSnapshot? _latestRecord;

RealtimeEvent _event(api.ShakeDetectionActiveSnapshot record) {
  if (record.revision == 2) {
    _latestRecord = record;
  }
  return RealtimeEvent.shakeSnapshot(
    record: record,
    source: RealtimeSource.eqmonitor,
  );
}

api.ShakeDetectionActiveSnapshot _snapshot({
  required int revision,
  required String eventId,
}) => api.ShakeDetectionActiveSnapshot(
  type: 'shake_detection',
  revision: revision,
  responseAt: DateTime.utc(2026, 7, 23, 12),
  events: [
    api.ShakeDetectionActiveEvent(
      type: 'shake_detection',
      eventId: eventId,
      serialNo: revision,
      createdAt: DateTime.utc(2026, 7, 23, 11, 59),
      updatedAt: DateTime.utc(2026, 7, 23, 12),
      expiresAt: DateTime.utc(2026, 7, 23, 12, 1),
      level: api.Level.strong,
      changeReasons: const [api.ChangeReasons.pointsChanged],
      mergedEvents: [
        api.MergedEvents(
          eventId: 'merged-$eventId',
          mergedAt: DateTime.utc(2026, 7, 23, 12),
        ),
      ],
      pointCount: 1,
      region: const api.Region(
        topLeft: api.TopLeft(latitude: 36, longitude: 139),
        bottomRight: api.BottomRight(latitude: 35, longitude: 140),
      ),
      points: [
        api.Points(
          code: 'point-$eventId',
          name: '観測点',
          region: '東京都',
          type: 'K-NET',
          location: const api.Location(latitude: 35.5, longitude: 139.5),
          intensity: 3.2,
        ),
      ],
    ),
  ],
);
