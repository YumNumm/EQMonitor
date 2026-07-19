import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event_converter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

RealtimeShakeData shake({
  required String level,
  required List<String> changeReasons,
}) => RealtimeShakeData(
  eventId: 'legacy-1',
  createdAt: DateTime.utc(2026, 7, 19, 12),
  level: level,
  isReplay: true,
  pointCount: 3,
  minLat: 34,
  maxLat: 36,
  minLng: 138,
  maxLng: 140,
  changeReasons: changeReasons,
);

void main() {
  test('legacy realtimeのlevelとchangeReasonsを厳密に変換すること', () {
    final event = shake(
      level: 'Strong',
      changeReasons: const ['level_up'],
    ).toShakeDetectionEvent();

    expect(event.level, ShakeDetectionLevel.strong);
    expect(event.changeReasons, ['level_up']);
  });

  test('未知のlegacy realtime levelをweakerへ降格しないこと', () {
    expect(
      () => shake(
        level: 'Unknown',
        changeReasons: const ['new_event'],
      ).toShakeDetectionEvent(),
      throwsA(isA<FormatException>()),
    );
  });
}
