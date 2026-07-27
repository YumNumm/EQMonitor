import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_transition_policy.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_display_state.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:flutter_test/flutter_test.dart';

final _now = DateTime.utc(2026, 7, 27);

Earthquake earthquake(String eventId) => Earthquake(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: _now,
  originTimePrecision: OriginTimePrecision.second,
  arrivalTime: _now,
  dataSources: const [],
  telegramTypes: const [],
  hypocenter: null,
  intensity: null,
  estimatedIntensityTileUrl: null,
);

LiveMonitorDetectedEvent earthquakeEvent(String eventId) =>
    LiveMonitorDetectedEvent.earthquakeUpsert(
      eventId: eventId,
      trigger: LiveMonitorEarthquakeTrigger.telegram(
        kind: .vxse53,
        reportedAt: _now,
      ),
      earthquake: earthquake(eventId),
    );

LiveMonitorEarthquakeDisplayState earthquakeState({
  String eventId = 'A',
  DateTime? minimumUntil,
  DateTime? expiresAt,
  DateTime? returnToRealtimeAt,
}) => LiveMonitorEarthquakeDisplayState(
  eventId: eventId,
  trigger: LiveMonitorEarthquakeTrigger.telegram(
    kind: .vxse53,
    reportedAt: _now,
  ),
  earthquake: earthquake(eventId),
  shownAt: _now.subtract(const Duration(seconds: 1)),
  minimumUntil: minimumUntil ?? _now.add(const Duration(seconds: 2)),
  expiresAt: expiresAt ?? _now.add(const Duration(seconds: 9)),
  returnToRealtimeAt: returnToRealtimeAt,
);

void main() {
  const policy = LiveMonitorTransitionPolicy();

  group('LiveMonitorTransitionPolicy.resolve', () {
    test('地震情報は3秒の最低期限と設定期限を持つ', () {
      final decision = policy.resolve(
        current: const LiveMonitorDisplayState.realtime(),
        event: earthquakeEvent('A'),
        now: _now,
        displaySeconds: 10,
      );
      final next = decision.next as LiveMonitorEarthquakeDisplayState;

      expect(next.minimumUntil, DateTime.utc(2026, 7, 27, 0, 0, 3));
      expect(next.expiresAt, DateTime.utc(2026, 7, 27, 0, 0, 10));
      expect(next.returnToRealtimeAt, isNull);
      expect(decision.deadline, next.expiresAt);
      expect(decision.closeControlPanel, isFalse);
    });

    for (final replacementId in ['A', 'B']) {
      test('$replacementIdの地震更新は両期限を再設定して待機中の復帰を破棄する', () {
        final current = earthquakeState(
          returnToRealtimeAt: _now.add(const Duration(seconds: 2)),
        );

        final decision = policy.resolve(
          current: current,
          event: earthquakeEvent(replacementId),
          now: _now,
          displaySeconds: 20,
        );
        final next = decision.next as LiveMonitorEarthquakeDisplayState;

        expect(next.eventId, replacementId);
        expect(next.shownAt, _now);
        expect(next.minimumUntil, _now.add(const Duration(seconds: 3)));
        expect(next.expiresAt, _now.add(const Duration(seconds: 20)));
        expect(next.returnToRealtimeAt, isNull);
        expect(decision.deadline, next.expiresAt);
      });
    }

    test('新規EEWは最低期限中でも即時realtimeへ戻す', () {
      final decision = policy.resolve(
        current: earthquakeState(),
        event: const LiveMonitorDetectedEvent.eewStarted(
          eventId: 'E',
          serialNo: 1,
        ),
        now: _now,
        displaySeconds: 10,
      );

      expect(decision.next, const LiveMonitorDisplayState.realtime());
      expect(decision.deadline, isNull);
      expect(decision.closeControlPanel, isTrue);
    });

    test('既存EEW更新と揺れ検知は最低期限まで待つ', () {
      final state = earthquakeState();
      final events = <LiveMonitorDetectedEvent>[
        const LiveMonitorDetectedEvent.eewUpdated(eventId: 'E', serialNo: 2),
        const LiveMonitorDetectedEvent.shakeDetected(eventId: 'S', serialNo: 2),
      ];

      for (final event in events) {
        final decision = policy.resolve(
          current: state,
          event: event,
          now: _now,
          displaySeconds: 10,
        );
        final next = decision.next as LiveMonitorEarthquakeDisplayState;

        expect(next.returnToRealtimeAt, state.minimumUntil);
        expect(decision.deadline, state.minimumUntil);
      }
    });

    test('最低期限前の反復トリガーは単一の復帰期限を維持する', () {
      final state = earthquakeState(
        returnToRealtimeAt: _now.add(const Duration(seconds: 1)),
      );

      final decision = policy.resolve(
        current: state,
        event: const LiveMonitorDetectedEvent.eewUpdated(
          eventId: 'E',
          serialNo: 3,
        ),
        now: _now,
        displaySeconds: 30,
      );
      final next = decision.next as LiveMonitorEarthquakeDisplayState;

      expect(next.returnToRealtimeAt, state.returnToRealtimeAt);
      expect(decision.deadline, state.returnToRealtimeAt);
    });

    test('最低期限後の既存EEW更新と揺れ検知は即時realtimeへ戻す', () {
      final state = earthquakeState(minimumUntil: _now);
      final events = <LiveMonitorDetectedEvent>[
        const LiveMonitorDetectedEvent.eewUpdated(eventId: 'E', serialNo: 2),
        const LiveMonitorDetectedEvent.shakeDetected(eventId: 'S', serialNo: 2),
      ];

      for (final event in events) {
        final decision = policy.resolve(
          current: state,
          event: event,
          now: _now,
          displaySeconds: 10,
        );

        expect(decision.next, const LiveMonitorDisplayState.realtime());
        expect(decision.deadline, isNull);
      }
    });

    test('表示中の地震と一致する削除はrealtimeへ戻す', () {
      final decision = policy.resolve(
        current: earthquakeState(),
        event: const LiveMonitorDetectedEvent.earthquakeDeleted(eventId: 'A'),
        now: _now,
        displaySeconds: 10,
      );

      expect(decision.next, const LiveMonitorDisplayState.realtime());
      expect(decision.deadline, isNull);
      expect(decision.closeControlPanel, isFalse);
    });

    test('表示中の地震と一致しない削除は表示と期限を維持する', () {
      final state = earthquakeState();

      final decision = policy.resolve(
        current: state,
        event: const LiveMonitorDetectedEvent.earthquakeDeleted(eventId: 'B'),
        now: _now,
        displaySeconds: 30,
      );

      expect(decision.next, state);
      expect(decision.deadline, state.expiresAt);
      expect(decision.closeControlPanel, isFalse);
    });

    test('設定秒数の変更は現在の期限を変えず次の地震表示から反映する', () {
      final current = earthquakeState();
      final preserved = policy.resolve(
        current: current,
        event: const LiveMonitorDetectedEvent.earthquakeDeleted(eventId: 'B'),
        now: _now,
        displaySeconds: 30,
      );
      final replacement = policy.resolve(
        current: preserved.next,
        event: earthquakeEvent('B'),
        now: _now,
        displaySeconds: 30,
      );

      expect(
        (preserved.next as LiveMonitorEarthquakeDisplayState).expiresAt,
        current.expiresAt,
      );
      expect(
        (replacement.next as LiveMonitorEarthquakeDisplayState).expiresAt,
        _now.add(const Duration(seconds: 30)),
      );
    });
  });

  group('LiveMonitorTransitionPolicy.resolveDeadline', () {
    test('通常期限前は表示を維持して通常期限を返す', () {
      final state = earthquakeState();

      final decision = policy.resolveDeadline(current: state, now: _now);

      expect(decision.next, state);
      expect(decision.deadline, state.expiresAt);
      expect(decision.closeControlPanel, isFalse);
    });

    test('待機中の復帰期限に到達するとrealtimeへ戻す', () {
      final state = earthquakeState(returnToRealtimeAt: _now);

      final decision = policy.resolveDeadline(current: state, now: _now);

      expect(decision.next, const LiveMonitorDisplayState.realtime());
      expect(decision.deadline, isNull);
    });

    test('通常期限に到達するとrealtimeへ戻す', () {
      final state = earthquakeState(expiresAt: _now);

      final decision = policy.resolveDeadline(current: state, now: _now);

      expect(decision.next, const LiveMonitorDisplayState.realtime());
      expect(decision.deadline, isNull);
    });

    test('realtimeには期限を設定しない', () {
      final decision = policy.resolveDeadline(
        current: const LiveMonitorDisplayState.realtime(),
        now: _now,
      );

      expect(decision.next, const LiveMonitorDisplayState.realtime());
      expect(decision.deadline, isNull);
    });
  });
}
