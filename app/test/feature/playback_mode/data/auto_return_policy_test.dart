import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor/feature/playback_mode/data/auto_return_policy.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

RealtimeShakeData _shake({required bool isReplay}) => RealtimeShakeData(
  eventId: 'shake-1',
  createdAt: DateTime.utc(2024, 1, 1, 7, 10, 8),
  level: 'weak',
  isReplay: isReplay,
  pointCount: 1,
  minLat: 36,
  maxLat: 38,
  minLng: 136,
  maxLng: 138,
);

EewItemWithRelations _eewItem() => EewItemWithRelations.fromJson(const {
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

void main() {
  const policy = AutoReturnPolicy();

  group('AutoReturnPolicy.shouldReturnToRealtime', () {
    test('EEW更新は復帰トリガーになること', () {
      final event = RealtimeEvent.eewUpsert(
        item: _eewItem(),
        source: RealtimeSource.eqmonitor,
      );
      expect(policy.shouldReturnToRealtime(event), isTrue);
    });

    test('リプレイ由来でない揺れ検知は復帰トリガーになること', () {
      final event = RealtimeEvent.shakeDetected(
        data: _shake(isReplay: false),
        source: RealtimeSource.eqmonitor,
      );
      expect(policy.shouldReturnToRealtime(event), isTrue);
    });

    test('リプレイ由来の揺れ検知は復帰トリガーにならないこと', () {
      final event = RealtimeEvent.shakeDetected(
        data: _shake(isReplay: true),
        source: RealtimeSource.eqmonitor,
      );
      expect(policy.shouldReturnToRealtime(event), isFalse);
    });
  });
}
