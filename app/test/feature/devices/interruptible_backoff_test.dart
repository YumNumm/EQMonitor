import 'dart:async';

import 'package:eqmonitor/feature/devices/data/retry/interruptible_backoff.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PushTokenBackoff', () {
    test('delay grows exponentially and caps at 60 seconds', () {
      const policy = PushTokenBackoff();
      expect(
        List.generate(8, (i) => policy.durationFor(attempt: i)),
        const [
          Duration(seconds: 2),
          Duration(seconds: 4),
          Duration(seconds: 8),
          Duration(seconds: 16),
          Duration(seconds: 32),
          Duration(seconds: 60),
          Duration(seconds: 60),
          Duration(seconds: 60),
        ],
      );
    });

    test('Retry-After is capped at 60 seconds', () {
      const policy = PushTokenBackoff();
      expect(
        policy.durationFor(
          attempt: 0,
          retryAfter: const Duration(minutes: 5),
        ),
        const Duration(seconds: 60),
      );
    });

    test('Retry-After がキャップ未満ならそのまま採用する', () {
      const policy = PushTokenBackoff();
      expect(
        policy.durationFor(
          attempt: 0,
          retryAfter: const Duration(seconds: 10),
        ),
        const Duration(seconds: 10),
      );
    });
  });

  group('InterruptibleBackoff', () {
    test('interrupt が呼ばれると長い待機を待たずに wait が完了する', () {
      fakeAsync((async) {
        final backoff = InterruptibleBackoff();
        var completed = false;
        unawaited(
          backoff.wait(const Duration(days: 1)).then((_) => completed = true),
        );

        async.elapse(const Duration(milliseconds: 1));
        expect(completed, isFalse);

        backoff.interrupt();
        async.flushMicrotasks();
        expect(completed, isTrue);

        backoff.dispose();
      });
    });

    test(
      'dispose すると待機中の wait が完了し、以後の wait は待機をスケジュールせず即完了する',
      () {
        fakeAsync((async) {
          final backoff = InterruptibleBackoff();
          var firstCompleted = false;
          unawaited(
            backoff
                .wait(const Duration(days: 1))
                .then((_) => firstCompleted = true),
          );

          backoff.dispose();
          async.flushMicrotasks();
          expect(firstCompleted, isTrue);

          var secondCompleted = false;
          unawaited(
            backoff
                .wait(const Duration(days: 1))
                .then((_) => secondCompleted = true),
          );
          async.flushMicrotasks();
          expect(
            secondCompleted,
            isTrue,
            reason: 'dispose 後の wait は新規待機をスケジュールせず即座に完了するべき',
          );
        });
      },
    );
  });
}
