import 'package:eqmonitor/core/provider/clock/map_clock_source_identity_provider.dart';
import 'package:eqmonitor/core/util/map/app_map_clock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppMapUtcWallSourceはAppClock時刻をUTCへ正規化する', () {
    var captureCount = 0;
    final source = AppMapUtcWallSource(() {
      captureCount += 1;
      return DateTime(2026, 8, 24, 12, 34, 56);
    });

    final captured = source.captureUtc();

    expect(captured, DateTime(2026, 8, 24, 12, 34, 56).toUtc());
    expect(captured.isUtc, isTrue);
    expect(captureCount, 1);
  });

  test('createAppMapClockはcaptureごとにAppClock.nowを一度だけ読む', () {
    var captureCount = 0;
    final expected = DateTime.utc(2026, 8, 24, 3, 4, 5);
    final clock = createAppMapClock(
      now: () {
        captureCount += 1;
        return expected;
      },
      sourceIdentity: const (
        mode: MapClockSourceMode.realtime,
        timeShiftOffset: null,
        replaySession: null,
      ),
    );

    final first = clock.capture();
    final second = clock.capture();

    expect(first.wallInstant.value, expected);
    expect(second.wallInstant.value, expected);
    expect(captureCount, 2);
    expect(
      second.monotonicInstant.elapsed,
      greaterThanOrEqualTo(first.monotonicInstant.elapsed),
    );
    expect(
      second.monotonicInstant.sourceIdentity,
      same(first.monotonicInstant.sourceIdentity),
    );
  });
}
