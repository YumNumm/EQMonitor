import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_scheduler.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('再スケジュール後は古いtimerを無効化する', () {
    fakeAsync((async) {
      final fired = <String>[];
      final scheduler = LiveMonitorScheduler();
      final now = DateTime.utc(2026, 7, 27);
      scheduler.schedule(
        now: now,
        deadline: now.add(const Duration(seconds: 10)),
        onElapsed: () => fired.add('old'),
      );
      scheduler.schedule(
        now: now,
        deadline: now.add(const Duration(seconds: 3)),
        onElapsed: () => fired.add('new'),
      );

      async.elapse(const Duration(seconds: 10));

      expect(fired, ['new']);
    });
  });

  test('cancel後は予約済みtimerを発火しない', () {
    fakeAsync((async) {
      var fired = false;
      final scheduler = LiveMonitorScheduler();
      final now = DateTime.utc(2026, 7, 27);
      scheduler.schedule(
        now: now,
        deadline: now.add(const Duration(seconds: 3)),
        onElapsed: () => fired = true,
      );

      scheduler.cancel();
      async.elapse(const Duration(seconds: 3));

      expect(fired, isFalse);
    });
  });

  test('過去の期限は次のtimer処理で発火する', () {
    fakeAsync((async) {
      var fired = false;
      final scheduler = LiveMonitorScheduler();
      final now = DateTime.utc(2026, 7, 27);
      scheduler.schedule(
        now: now,
        deadline: now.subtract(const Duration(seconds: 1)),
        onElapsed: () => fired = true,
      );

      expect(fired, isFalse);
      async.elapse(Duration.zero);

      expect(fired, isTrue);
    });
  });
}
