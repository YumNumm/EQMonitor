import 'package:eqmonitor/feature/devices/data/exception/device_provisioning_exception.dart';
import 'package:eqmonitor/feature/devices/data/retry/retry_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RetryController', () {
    late List<Duration> recordedDelays;
    late RetryController controller;

    setUp(() {
      recordedDelays = [];
      controller = RetryController(
        delayOverride: (d) async => recordedDelays.add(d),
      );
    });

    test('成功時は即座に結果を返す', () async {
      final result = await controller.run(() async => 42);
      expect(result, 42);
      expect(controller.state, isA<RetryIdle>());
      expect(recordedDelays, isEmpty);
    });

    test('isRetryable=false なら即時 Exhausted', () async {
      var calls = 0;
      await expectLater(
        () => controller.run(() async {
          calls++;
          throw const InvalidRequestException(statusCode: 400);
        }),
        throwsA(isA<InvalidRequestException>()),
      );
      expect(calls, 1);
      expect(controller.state, isA<RetryExhausted>());
    });

    test('isRetryable=true なら最大 6 回試みる', () async {
      var calls = 0;
      await expectLater(
        () => controller.run(() async {
          calls++;
          throw const NetworkUnreachableException();
        }),
        throwsA(isA<NetworkUnreachableException>()),
      );
      expect(calls, 6);
      expect(controller.state, isA<RetryExhausted>());
      expect(recordedDelays, hasLength(5));
    });

    test('途中で成功すれば残りは実行しない', () async {
      var calls = 0;
      final result = await controller.run(() async {
        calls++;
        if (calls < 3) {
          throw const NetworkUnreachableException();
        }
        return 'ok';
      });
      expect(result, 'ok');
      expect(calls, 3);
      expect(controller.state, isA<RetryIdle>());
      expect(recordedDelays, hasLength(2));
    });

    test('RateLimitedException.retryAfter を優先する', () async {
      await expectLater(
        () => controller.run(() async {
          throw const RateLimitedException(retryAfter: Duration(seconds: 30));
        }),
        throwsA(isA<RateLimitedException>()),
      );
      expect(recordedDelays.first, const Duration(seconds: 30));
    });

    test('delay は base * 2^attempt + jitter で増加する（上限 60s）', () async {
      await expectLater(
        () => controller.run(() async {
          throw const NetworkUnreachableException();
        }),
        throwsA(isA<NetworkUnreachableException>()),
      );
      // attempt 0: 2000ms + jitter; attempt 4: 32000ms + jitter (< 60s)
      // attempt 5: would be 64000ms → clamped to 60s
      // jitter makes exact values unstable, so just verify ordering
      for (var i = 0; i < recordedDelays.length - 1; i++) {
        final delta = recordedDelays[i + 1] - recordedDelays[i];
        // 後の delay は前より大きいか 60s に達している
        expect(
          recordedDelays[i + 1] >= recordedDelays[i] ||
              recordedDelays[i + 1] == const Duration(seconds: 60),
          isTrue,
          reason:
              'delay[$i]=${recordedDelays[i]}, delay[${i + 1}]=${recordedDelays[i + 1]}, delta=$delta',
        );
      }
      expect(recordedDelays.last.inSeconds, lessThanOrEqualTo(60));
    });

    test('reset() で state が RetryIdle に戻る', () async {
      await expectLater(
        () => controller.run(() async {
          throw const InvalidRequestException(statusCode: 400);
        }),
        throwsA(anything),
      );
      expect(controller.state, isA<RetryExhausted>());
      controller.reset();
      expect(controller.state, isA<RetryIdle>());
    });

    test('cancel() で待機中の再試行が中断される', () async {
      var calls = 0;
      Future<void> runFuture() => controller.run<void>(() async {
        calls++;
        if (calls == 1) {
          controller.cancel();
        }
        throw const NetworkUnreachableException();
      });
      await expectLater(runFuture, throwsA(isA<NetworkUnreachableException>()));
      expect(calls, 1);
      expect(controller.state, isA<RetryExhausted>());
    });

    test('状態変化コールバックが呼ばれる', () async {
      final states = <RetryControllerState>[];
      controller.onStateChanged = states.add;

      await controller.run(() async => 'done');

      expect(states, [isA<RetryRunning>(), isA<RetryIdle>()]);
    });
  });
}
