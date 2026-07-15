import 'dart:async';

import 'package:eqmonitor/feature/devices/data/retry/interruptible_backoff.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('delay grows exponentially and caps at 60 seconds', () {
    const policy = PushTokenBackoff();

    expect(List.generate(8, (i) => policy.durationFor(attempt: i)), const [
      Duration(seconds: 2),
      Duration(seconds: 4),
      Duration(seconds: 8),
      Duration(seconds: 16),
      Duration(seconds: 32),
      Duration(seconds: 60),
      Duration(seconds: 60),
      Duration(seconds: 60),
    ]);
  });

  test('Retry-After is capped at 60 seconds', () {
    const policy = PushTokenBackoff();

    expect(
      policy.durationFor(attempt: 0, retryAfter: const Duration(minutes: 5)),
      const Duration(seconds: 60),
    );
  });

  test('interrupt completes a pending long wait', () async {
    final delayed = Completer<void>();
    final backoff = InterruptibleBackoff(delayOverride: (_) => delayed.future);
    final waiting = backoff.wait(const Duration(days: 1));

    await Future<void>.delayed(Duration.zero);
    backoff.interrupt();

    await waiting;
  });

  test('dispose completes a pending wait and prevents later delays', () async {
    final delayed = Completer<void>();
    var delayCalls = 0;
    final backoff = InterruptibleBackoff(
      delayOverride: (_) {
        delayCalls++;
        return delayed.future;
      },
    );
    final waiting = backoff.wait(const Duration(days: 1));

    await Future<void>.delayed(Duration.zero);
    backoff.dispose();

    await waiting;
    await backoff.wait(const Duration(days: 1));
    expect(delayCalls, 1);
  });
}
