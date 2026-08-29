import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_image_delay_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const delay = Duration(seconds: 6);
  final now = DateTime.utc(2025, 1, 1, 12);
  const status = KyoshinMonitorImageDelayStatus();

  group('KyoshinMonitorImageDelayStatus.isDelayed', () {
    test('targetTime が delay より古い場合は遅延と判定する', () {
      final targetTime = now.subtract(delay + const Duration(seconds: 1));
      expect(
        status.isDelayed(now: now, targetTime: targetTime, delay: delay),
        isTrue,
      );
    });

    test('targetTime の遅れが delay 未満の場合は遅延としない', () {
      final targetTime = now.subtract(delay - const Duration(seconds: 1));
      expect(
        status.isDelayed(now: now, targetTime: targetTime, delay: delay),
        isFalse,
      );
    });

    test('targetTime == now の場合は遅延としない', () {
      expect(
        status.isDelayed(now: now, targetTime: now, delay: delay),
        isFalse,
      );
    });

    test('回帰: 明確に遅延した過去時刻は true になる', () {
      final targetTime = now.subtract(const Duration(minutes: 10));
      expect(
        status.isDelayed(now: now, targetTime: targetTime, delay: delay),
        isTrue,
      );
      final buggyResult = targetTime.difference(now) > delay;
      expect(buggyResult, isFalse);
    });
  });
}
