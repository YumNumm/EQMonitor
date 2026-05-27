import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 遅延判定のしきい値。imageFetchInterval(例: 1秒) + 5秒 を想定。
  const delay = Duration(seconds: 6);
  // 基準となる現在時刻。テストを決定的にするため固定値を使う。
  final now = DateTime.utc(2025, 1, 1, 12);

  group('KyoshinMonitorNotifier.isImageDelayed', () {
    test('targetTime が delay より古い (now - (delay + 1s)) 場合は遅延と判定する', () {
      final targetTime = now.subtract(delay + const Duration(seconds: 1));
      expect(
        KyoshinMonitorNotifier.isImageDelayed(
          now: now,
          targetTime: targetTime,
          delay: delay,
        ),
        isTrue,
      );
    });

    test('targetTime の遅れが delay 未満 (now - (delay - 1s)) の場合は遅延としない', () {
      final targetTime = now.subtract(delay - const Duration(seconds: 1));
      expect(
        KyoshinMonitorNotifier.isImageDelayed(
          now: now,
          targetTime: targetTime,
          delay: delay,
        ),
        isFalse,
      );
    });

    test('targetTime == now (差0) の場合は遅延としない', () {
      expect(
        KyoshinMonitorNotifier.isImageDelayed(
          now: now,
          targetTime: now,
          delay: delay,
        ),
        isFalse,
      );
    });

    // 回帰テスト:
    // 修正前の実装は `targetTime.difference(now) > delay` だった。
    // targetTime は呼び出し元(kyoshin_monitor_timer_stream.dart)で常に
    // `clock.now().subtract(delayFromDevice)` として生成されるため、必ず現在時刻
    // より過去になる。よって `targetTime.difference(now)` は常に負となり、
    // `負 > 正(delay)` は決して true にならず、遅延判定が永遠に false のままだった。
    // 正しくは `now.difference(targetTime) > delay`(差分の向きが逆)。
    // 下記は「明確に遅延している」入力で、旧実装なら false に倒れていたケースが
    // 現実装では true になることを保証する。
    test('回帰: 明確に遅延した過去時刻は true になる (旧実装では false に倒れていた)', () {
      final targetTime = now.subtract(const Duration(minutes: 10));

      // 現実装(正しい向き)では遅延と判定される。
      expect(
        KyoshinMonitorNotifier.isImageDelayed(
          now: now,
          targetTime: targetTime,
          delay: delay,
        ),
        isTrue,
      );

      // 旧実装の向き(符号反転バグ)を再現すると false になってしまうことを示す。
      final buggyResult = targetTime.difference(now) > delay;
      expect(buggyResult, isFalse);
    });
  });
}
