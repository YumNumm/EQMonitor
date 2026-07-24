import 'dart:async';

import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_to_realtime_notifier.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_watcher.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final now = DateTime.utc(2026, 7, 19, 12);

final class StubRealtimeEvents extends RealtimeEvents {
  StubRealtimeEvents(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

final class EnabledAutoReturn extends AutoReturnToRealtimeNotifier {
  @override
  Future<bool> build() async => true;
}

final class MutableWsStatus extends EqMonitorWsStatus {
  @override
  EqMonitorWsStatusState build() =>
      const EqMonitorWsStatusState(phase: WsPhase.connected);

  void setPhase(WsPhase phase) {
    state = state.copyWith(phase: phase);
  }
}

final class MutableAcceptedShakeSnapshot
    extends ShakeDetectionAcceptedSnapshot {
  @override
  ShakeDetectionSnapshot? build() => null;

  void publish(ShakeDetectionSnapshot snapshot) => state = snapshot;
}

api.ShakeDetectionActiveEvent watcherShake(String eventId) =>
    api.ShakeDetectionActiveEvent(
      type: 'shake_detection',
      eventId: eventId,
      serialNo: 1,
      createdAt: now,
      updatedAt: now,
      expiresAt: now.add(const Duration(minutes: 1)),
      level: api.Level.medium,
      mergedEvents: const [],
      pointCount: 1,
      region: const api.Region(
        topLeft: api.TopLeft(latitude: 36, longitude: 139),
        bottomRight: api.BottomRight(latitude: 35, longitude: 140),
      ),
      points: const [],
      changeReasons: const [api.ChangeReasons.newEvent],
    );

RealtimeEvent watcherSnapshot({
  required int revision,
  required List<String> eventIds,
}) => RealtimeEvent.shakeSnapshot(
  record: api.ShakeDetectionActiveSnapshot(
    type: 'shake_detection',
    revision: revision,
    responseAt: now,
    events: eventIds.map(watcherShake).toList(growable: false),
  ),
  source: RealtimeSource.eqmonitor,
);

ShakeDetectionSnapshot acceptedSnapshot({
  required int revision,
  required List<String> eventIds,
}) => ShakeDetectionSnapshot(
  revision: revision,
  responseAt: now,
  events: eventIds
      .map(
        (eventId) => ShakeDetectionEvent(
          eventId: eventId,
          serialNo: 1,
          createdAt: now,
          updatedAt: now,
          expiresAt: now.add(const Duration(minutes: 1)),
          level: api.ShakeDetectionLevel.medium,
          pointCount: 1,
          minLat: 35,
          maxLat: 36,
          minLng: 139,
          maxLng: 140,
          changeReasons: const ['new_event'],
        ),
      )
      .toList(growable: false),
);

void main() {
  group('AutoReturnWatcher', () {
    late StreamController<RealtimeEvent> controller;
    late ProviderContainer container;
    late ProviderSubscription<void> watcherSubscription;

    setUp(() async {
      controller = StreamController<RealtimeEvent>.broadcast(sync: true);
      container = ProviderContainer(
        overrides: [
          realtimeEventsProvider.overrideWith(
            () => StubRealtimeEvents(controller.stream),
          ),
          autoReturnToRealtimeProvider.overrideWith(EnabledAutoReturn.new),
          eqMonitorWsStatusProvider.overrideWith(MutableWsStatus.new),
          shakeDetectionAcceptedSnapshotProvider.overrideWith(
            MutableAcceptedShakeSnapshot.new,
          ),
        ],
      );
      watcherSubscription = container.listen(
        autoReturnWatcherProvider,
        (_, _) {},
      );
      await pumpEventQueue();
    });

    tearDown(() async {
      watcherSubscription.close();
      container.dispose();
      await controller.close();
    });

    test('REST baseline後の初回の新しいWS eventで通常再生へ戻ること', () async {
      final accepted =
          container.read(shakeDetectionAcceptedSnapshotProvider.notifier)
              as MutableAcceptedShakeSnapshot;
      accepted.publish(acceptedSnapshot(revision: 1, eventIds: []));
      await pumpEventQueue();
      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));

      controller.add(watcherSnapshot(revision: 2, eventIds: ['shake-1']));
      await pumpEventQueue();
      expect(container.read(appClockProvider), isA<RealtimeTimeMode>());
    });

    test('通常再生復帰後もaccepted baselineを維持し次の新規eventで戻ること', () async {
      final accepted =
          container.read(shakeDetectionAcceptedSnapshotProvider.notifier)
              as MutableAcceptedShakeSnapshot;
      accepted.publish(acceptedSnapshot(revision: 1, eventIds: ['shake-old']));
      await pumpEventQueue();
      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));

      controller.add(
        watcherSnapshot(revision: 2, eventIds: ['shake-old', 'shake-first']),
      );
      await pumpEventQueue();
      expect(container.read(appClockProvider), isA<RealtimeTimeMode>());

      final clock = container.read(appClockProvider.notifier);
      clock.enterTimeShift(const Duration(minutes: -3));
      await pumpEventQueue();
      controller.add(
        watcherSnapshot(
          revision: 3,
          eventIds: ['shake-old', 'shake-first', 'shake-second'],
        ),
      );
      await pumpEventQueue();

      expect(container.read(appClockProvider), isA<RealtimeTimeMode>());
    });

    test('同revisionのRESTで再接続した後も次の新しいWS eventで戻ること', () async {
      final accepted =
          container.read(shakeDetectionAcceptedSnapshotProvider.notifier)
              as MutableAcceptedShakeSnapshot;
      accepted.publish(
        acceptedSnapshot(revision: 10, eventIds: ['rest-current']),
      );
      await pumpEventQueue();

      final status =
          container.read(eqMonitorWsStatusProvider.notifier) as MutableWsStatus;
      status
        ..setPhase(WsPhase.disconnected)
        ..setPhase(WsPhase.connected);
      await pumpEventQueue();
      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));
      controller.add(
        watcherSnapshot(revision: 11, eventIds: ['rest-current', 'ws-new']),
      );
      await pumpEventQueue();

      expect(container.read(appClockProvider), isA<RealtimeTimeMode>());
    });

    test('再接続reseed後の同一・古いraw WS revisionでは戻らないこと', () async {
      final accepted =
          container.read(shakeDetectionAcceptedSnapshotProvider.notifier)
              as MutableAcceptedShakeSnapshot;
      accepted.publish(
        acceptedSnapshot(revision: 10, eventIds: ['rest-current']),
      );
      await pumpEventQueue();

      final status =
          container.read(eqMonitorWsStatusProvider.notifier) as MutableWsStatus;
      status
        ..setPhase(WsPhase.disconnected)
        ..setPhase(WsPhase.connected);
      await pumpEventQueue();
      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));

      controller.add(watcherSnapshot(revision: 10, eventIds: ['equal-unseen']));
      controller.add(watcherSnapshot(revision: 9, eventIds: ['stale-unseen']));
      await pumpEventQueue();

      expect(container.read(appClockProvider), isA<TimeShiftTimeMode>());
    });
  });
}
