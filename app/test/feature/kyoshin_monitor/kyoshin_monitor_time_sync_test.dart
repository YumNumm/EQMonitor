import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_delay_resolver.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_time_sample.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const timeSample = KyoshinMonitorTimeSampleCalculator();
  const delayResolver = KyoshinMonitorDelayResolver();

  group('KyoshinMonitorTimeSampleCalculator', () {
    test('往復時間は送信から受信までの差', () {
      final sample = KyoshinMonitorTimeSample(
        sentAt: DateTime.utc(2026, 8, 19, 0, 17, 30),
        receivedAt: DateTime.utc(2026, 8, 19, 0, 17, 30, 400),
        latestTime: DateTime.utc(2026, 8, 19, 0, 17, 29),
      );
      expect(
        timeSample.roundTripTime(sample),
        const Duration(milliseconds: 400),
      );
    });

    test('ずれは送受信の中点で評価され、往復時間の片道ぶんが打ち消される', () {
      final sample = KyoshinMonitorTimeSample(
        sentAt: DateTime.utc(2026, 8, 19, 0, 17, 30),
        receivedAt: DateTime.utc(2026, 8, 19, 0, 17, 30, 400),
        latestTime: DateTime.utc(2026, 8, 19, 0, 17, 29, 200),
      );
      expect(timeSample.shift(sample), const Duration(milliseconds: -1000));
    });
  });

  group('publishDelay', () {
    test('NTPオフセットが0なら、ずれの符号を反転したものが公開遅延', () {
      expect(
        timeSample.publishDelay(
          shift: const Duration(milliseconds: -1230),
          ntpOffset: Duration.zero,
        ),
        const Duration(milliseconds: 1230),
      );
    });

    group('端末時計が30秒進んでいる場合', () {
      final trueNow = DateTime.utc(2026, 8, 19, 0, 17, 31);
      const clockError = Duration(seconds: 30);
      const publishDelay = Duration(seconds: 1);

      final deviceNow = trueNow.add(clockError);
      final latestTime = trueNow.subtract(publishDelay);
      final ntpOffset = -clockError;

      final sample = KyoshinMonitorTimeSample(
        sentAt: deviceNow,
        receivedAt: deviceNow,
        latestTime: latestTime,
      );

      test('ずれには端末時計の誤差が含まれる', () {
        expect(timeSample.shift(sample), -(publishDelay + clockError));
      });

      test('NTPオフセットを差し引くと純粋な公開遅延になる', () {
        expect(
          timeSample.publishDelay(
            shift: timeSample.shift(sample),
            ntpOffset: ntpOffset,
          ),
          publishDelay,
        );
      });

      test('NTP補正済みの現在時刻から引くと正しい対象時刻になる', () {
        final resolved = timeSample.publishDelay(
          shift: timeSample.shift(sample),
          ntpOffset: ntpOffset,
        );
        expect(trueNow.subtract(resolved), latestTime);
      });

      test('NTP未取得時も、端末時計から引けば同じ対象時刻になる', () {
        final resolved = timeSample.publishDelay(
          shift: timeSample.shift(sample),
          ntpOffset: null,
        );
        expect(resolved, publishDelay + clockError);
        expect(deviceNow.subtract(resolved), latestTime);
      });
    });
  });

  group('KyoshinMonitorDelayResolver', () {
    const config = KyoshinMonitorDelayAdjustConfig(
      minOffset: Duration(milliseconds: 600),
      maxOffset: Duration(milliseconds: 5000),
      maxAdjustment: Duration(seconds: 5),
    );

    test('実測値に補正量を足したものが画像遅延', () {
      expect(
        delayResolver.imageDelay(
          publishDelay: const Duration(milliseconds: 1230),
          adjustment: const Duration(milliseconds: -300),
          config: config,
        ),
        const Duration(milliseconds: 930),
      );
    });

    test('画像遅延は下限でクランプされる', () {
      expect(
        delayResolver.imageDelay(
          publishDelay: const Duration(milliseconds: 1000),
          adjustment: const Duration(milliseconds: -900),
          config: config,
        ),
        config.minOffset,
      );
    });

    test('404なら補正量をstepぶん増やす', () {
      expect(
        delayResolver.onFetchFailed(
          adjustment: Duration.zero,
          config: config,
        ),
        config.step,
      );
    });
  });
}
