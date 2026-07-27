import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_tap_tracker.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('単一pointerの移動なしupだけをtapと判定する', () {
    final tracker = LiveMonitorTapTracker(touchSlop: 18);
    tracker.pointerDown(pointer: 1, position: const Offset(10, 10));
    expect(
      tracker.pointerUp(pointer: 1, position: const Offset(12, 12)),
      isTrue,
    );
  });

  test('pan、pinch、Divider dragはtapにしない', () {
    final tracker = LiveMonitorTapTracker(touchSlop: 18);
    tracker.pointerDown(pointer: 1, position: Offset.zero);
    tracker.pointerMove(pointer: 1, position: const Offset(30, 0));
    expect(
      tracker.pointerUp(pointer: 1, position: const Offset(30, 0)),
      isFalse,
    );

    tracker.pointerDown(pointer: 1, position: Offset.zero);
    tracker.pointerDown(pointer: 2, position: const Offset(20, 20));
    expect(tracker.pointerUp(pointer: 1, position: Offset.zero), isFalse);

    tracker.pointerDown(pointer: 3, position: const Offset(40, 40));
    expect(
      tracker.pointerUp(pointer: 3, position: const Offset(40, 40)),
      isFalse,
    );
    expect(
      tracker.pointerUp(pointer: 2, position: const Offset(20, 20)),
      isFalse,
    );
  });

  test('panel表示状態が変わったgestureのupはtapにしない', () {
    final tracker = LiveMonitorTapTracker(touchSlop: 18);
    tracker.pointerDown(pointer: 1, position: Offset.zero);

    tracker.cancelAll();

    expect(tracker.pointerUp(pointer: 1, position: Offset.zero), isFalse);
  });

  test('単一tapはdouble tap待機後に一度だけ通知する', () {
    fakeAsync((async) {
      final tracker = LiveMonitorTapTracker(touchSlop: 18);
      var tapCount = 0;
      tracker.pointerDown(pointer: 1, position: Offset.zero);
      final isTap = tracker.pointerUp(pointer: 1, position: Offset.zero);

      tracker.scheduleSingleTap(
        isTap: isTap,
        delay: const Duration(milliseconds: 300),
        onTap: () => tapCount += 1,
      );
      async.elapse(const Duration(milliseconds: 299));
      expect(tapCount, 0);
      async.elapse(const Duration(milliseconds: 1));
      expect(tapCount, 1);
    });
  });

  test('double tapの2回目downは保留中の単一tapと2回目upを取り消す', () {
    fakeAsync((async) {
      final tracker = LiveMonitorTapTracker(touchSlop: 18);
      var tapCount = 0;
      tracker.pointerDown(pointer: 1, position: Offset.zero);
      tracker.scheduleSingleTap(
        isTap: tracker.pointerUp(pointer: 1, position: Offset.zero),
        delay: const Duration(milliseconds: 300),
        onTap: () => tapCount += 1,
      );

      async.elapse(const Duration(milliseconds: 100));
      tracker.pointerDown(pointer: 2, position: const Offset(2, 2));
      tracker.scheduleSingleTap(
        isTap: tracker.pointerUp(pointer: 2, position: const Offset(2, 2)),
        delay: const Duration(milliseconds: 300),
        onTap: () => tapCount += 1,
      );
      async.elapse(const Duration(seconds: 1));

      expect(tapCount, 0);
    });
  });

  test('EEWやpanel状態変更のcancelAllは保留中の単一tapを取り消す', () {
    fakeAsync((async) {
      final tracker = LiveMonitorTapTracker(touchSlop: 18);
      var tapCount = 0;
      tracker.pointerDown(pointer: 1, position: Offset.zero);
      tracker.scheduleSingleTap(
        isTap: tracker.pointerUp(pointer: 1, position: Offset.zero),
        delay: const Duration(milliseconds: 300),
        onTap: () => tapCount += 1,
      );

      tracker.cancelAll();
      async.elapse(const Duration(seconds: 1));

      expect(tapCount, 0);
    });
  });
}
