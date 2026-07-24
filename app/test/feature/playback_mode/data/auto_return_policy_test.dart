import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/feature/playback_mode/data/auto_return_policy.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

final _now = DateTime.utc(2026, 7, 19, 12);

EewItemWithRelations eewItem() => EewItemWithRelations.fromJson(const {
  'event_id': '20240101161010',
  'type': 'VXSE45',
  'status': 'NORMAL',
  'info_type': 'PUBLICATION',
  'serial_no': 1,
  'headline': null,
  'is_canceled': false,
  'is_warning': null,
  'is_last_info': false,
  'origin_time': null,
  'arrival_time': null,
  'accuracy': null,
  'is_plum': false,
  'editorial_office': null,
  'report_time': '2024-01-01T07:10:16.000Z',
});

ShakeDetectionActiveEvent shake(String eventId, {int serialNo = 1}) =>
    ShakeDetectionActiveEvent(
      type: 'shake_detection',
      eventId: eventId,
      serialNo: serialNo,
      createdAt: _now,
      updatedAt: _now,
      expiresAt: _now.add(const Duration(minutes: 1)),
      level: Level.medium,
      mergedEvents: const [],
      pointCount: 1,
      region: const Region(
        topLeft: TopLeft(latitude: 36, longitude: 139),
        bottomRight: BottomRight(latitude: 35, longitude: 140),
      ),
      points: const [],
      changeReasons: const [ChangeReasons.newEvent],
    );

RealtimeEvent snapshot({
  required int revision,
  required List<ShakeDetectionActiveEvent> events,
}) => RealtimeEvent.shakeSnapshot(
  record: ShakeDetectionActiveSnapshot(
    type: 'shake_detection',
    revision: revision,
    responseAt: _now,
    events: events,
  ),
  source: RealtimeSource.eqmonitor,
);

void main() {
  group('AutoReturnPolicy.shouldReturnToRealtime', () {
    test('EEW更新は復帰トリガーになること', () {
      final policy = AutoReturnPolicy();
      final event = RealtimeEvent.eewUpsert(
        record: eewItem(),
        source: RealtimeSource.eqmonitor,
      );
      expect(policy.shouldReturnToRealtime(event), isTrue);
    });

    test('初回の揺れ検知snapshotはbaselineとして復帰しないこと', () {
      final policy = AutoReturnPolicy();
      expect(
        policy.shouldReturnToRealtime(
          snapshot(revision: 1, events: [shake('shake-1')]),
        ),
        isFalse,
      );
    });

    test('同じeventIdのrevision更新では復帰しないこと', () {
      final policy = AutoReturnPolicy()
        ..shouldReturnToRealtime(
          snapshot(revision: 1, events: [shake('shake-1')]),
        );

      expect(
        policy.shouldReturnToRealtime(
          snapshot(revision: 2, events: [shake('shake-1', serialNo: 2)]),
        ),
        isFalse,
      );
    });

    test('同一・古いrevisionに未見eventIdがあっても復帰しないこと', () {
      final policy = AutoReturnPolicy()
        ..shouldReturnToRealtime(
          snapshot(revision: 2, events: [shake('shake-1')]),
        );

      expect(
        policy.shouldReturnToRealtime(
          snapshot(
            revision: 2,
            events: [shake('shake-1'), shake('shake-equal')],
          ),
        ),
        isFalse,
      );
      expect(
        policy.shouldReturnToRealtime(
          snapshot(
            revision: 1,
            events: [shake('shake-1'), shake('shake-stale')],
          ),
        ),
        isFalse,
      );
    });

    test('後続snapshotに新しいeventIdが追加されたら復帰すること', () {
      final policy = AutoReturnPolicy()
        ..shouldReturnToRealtime(
          snapshot(revision: 1, events: [shake('shake-1')]),
        );

      expect(
        policy.shouldReturnToRealtime(
          snapshot(revision: 2, events: [shake('shake-1'), shake('shake-2')]),
        ),
        isTrue,
      );
    });

    test('空snapshotとevent削除では復帰しないこと', () {
      final policy = AutoReturnPolicy()
        ..shouldReturnToRealtime(
          snapshot(revision: 1, events: [shake('shake-1'), shake('shake-2')]),
        );

      expect(
        policy.shouldReturnToRealtime(
          snapshot(revision: 2, events: [shake('shake-2')]),
        ),
        isFalse,
      );
      expect(
        policy.shouldReturnToRealtime(snapshot(revision: 3, events: [])),
        isFalse,
      );
    });

    test('同一lifecycleで削除後に同じeventIdが再出現しても復帰しないこと', () {
      final policy = AutoReturnPolicy()
        ..shouldReturnToRealtime(
          snapshot(revision: 1, events: [shake('shake-1')]),
        )
        ..shouldReturnToRealtime(snapshot(revision: 2, events: []));

      expect(
        policy.shouldReturnToRealtime(
          snapshot(revision: 3, events: [shake('shake-1')]),
        ),
        isFalse,
      );
    });

    test('lifecycle reset後の初回snapshotは再baselineして復帰しないこと', () {
      final policy = AutoReturnPolicy()
        ..shouldReturnToRealtime(
          snapshot(revision: 1, events: [shake('shake-old')]),
        )
        ..resetShakeBaseline();

      expect(
        policy.shouldReturnToRealtime(
          snapshot(
            revision: 2,
            events: [shake('shake-old'), shake('shake-reconnected')],
          ),
        ),
        isFalse,
      );
      expect(
        policy.shouldReturnToRealtime(
          snapshot(
            revision: 3,
            events: [
              shake('shake-old'),
              shake('shake-reconnected'),
              shake('shake-new'),
            ],
          ),
        ),
        isTrue,
      );
    });
  });
}
