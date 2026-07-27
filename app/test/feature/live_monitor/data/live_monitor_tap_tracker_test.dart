import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_tap_tracker.dart';
import 'package:flutter/widgets.dart';
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
  });
}
