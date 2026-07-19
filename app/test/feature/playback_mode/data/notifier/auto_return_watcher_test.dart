import 'dart:async';

import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_snapshot.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/playback_mode/data/auto_return_policy.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_to_realtime_notifier.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_watcher.dart';
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

final class RecordingAutoReturnPolicy extends AutoReturnPolicy {
  final decisions = <bool>[];

  @override
  bool shouldReturnToRealtime(RealtimeEvent event) {
    final decision = super.shouldReturnToRealtime(event);
    decisions.add(decision);
    return decision;
  }
}

RealtimeShakeEventData watcherShake(String eventId) => RealtimeShakeEventData(
  eventId: eventId,
  serialNo: 1,
  createdAt: now,
  updatedAt: now,
  expiresAt: now.add(const Duration(minutes: 1)),
  level: 'Medium',
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
);

RealtimeEvent watcherSnapshot({
  required int revision,
  required List<String> eventIds,
}) => RealtimeEvent.shakeSnapshot(
  data: RealtimeShakeSnapshot(
    revision: revision,
    responseAt: now,
    events: eventIds.map(watcherShake).toList(growable: false),
  ),
  source: RealtimeSource.eqmonitor,
);

void main() {
  group('AutoReturnWatcher', () {
    late StreamController<RealtimeEvent> controller;
    late ProviderContainer container;
    late RecordingAutoReturnPolicy policy;
    late ProviderSubscription<void> watcherSubscription;

    setUp(() async {
      controller = StreamController<RealtimeEvent>.broadcast(sync: true);
      policy = RecordingAutoReturnPolicy();
      container = ProviderContainer(
        overrides: [
          realtimeEventsProvider.overrideWith(
            () => StubRealtimeEvents(controller.stream),
          ),
          autoReturnToRealtimeProvider.overrideWith(EnabledAutoReturn.new),
          autoReturnPolicyProvider.overrideWithValue(policy),
          eqMonitorWsStatusProvider.overrideWith(MutableWsStatus.new),
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

    test('通常更新では維持し新しい揺れ検知追加で通常再生へ戻ること', () async {
      controller.add(watcherSnapshot(revision: 1, eventIds: ['shake-1']));
      await pumpEventQueue();
      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));

      controller.add(watcherSnapshot(revision: 2, eventIds: ['shake-1']));
      await pumpEventQueue();
      expect(container.read(appClockProvider), isA<TimeShiftTimeMode>());

      controller.add(
        watcherSnapshot(revision: 3, eventIds: ['shake-1', 'shake-2']),
      );
      await pumpEventQueue();
      expect(policy.decisions, [false, false, true]);
      expect(container.read(appClockProvider), isA<RealtimeTimeMode>());
    });

    test('再接続後の初回snapshotをbaselineにして誤復帰しないこと', () async {
      controller.add(watcherSnapshot(revision: 1, eventIds: ['shake-old']));
      await pumpEventQueue();
      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));

      final status =
          container.read(eqMonitorWsStatusProvider.notifier) as MutableWsStatus;
      status
        ..setPhase(WsPhase.disconnected)
        ..setPhase(WsPhase.connected);
      controller.add(
        watcherSnapshot(
          revision: 2,
          eventIds: ['shake-old', 'shake-reconnected'],
        ),
      );
      await pumpEventQueue();

      expect(container.read(appClockProvider), isA<TimeShiftTimeMode>());
    });

    test('通常再生復帰後はbaselineをresetして次回再生で誤復帰しないこと', () async {
      controller.add(watcherSnapshot(revision: 1, eventIds: ['shake-old']));
      await pumpEventQueue();

      final clock = container.read(appClockProvider.notifier);
      clock.enterTimeShift(const Duration(minutes: -3));
      await pumpEventQueue();
      clock.returnToRealtime();
      await pumpEventQueue();
      clock.enterTimeShift(const Duration(minutes: -3));
      await pumpEventQueue();
      controller.add(
        watcherSnapshot(
          revision: 2,
          eventIds: ['shake-old', 'shake-after-return'],
        ),
      );
      await pumpEventQueue();

      expect(container.read(appClockProvider), isA<TimeShiftTimeMode>());
    });
  });
}
