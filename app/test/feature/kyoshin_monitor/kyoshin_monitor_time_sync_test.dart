import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sample.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/trimmed_mean_samples.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/service/kyoshin_monitor_delay_adjust_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrimmedMeanSamples', () {
    test('サンプルが無い場合はnull', () {
      expect(TrimmedMeanSamples().value, isNull);
    });

    test('2件以下は単純平均', () {
      final samples = TrimmedMeanSamples()
        ..add(const Duration(milliseconds: 100))
        ..add(const Duration(milliseconds: 300));
      expect(samples.value, const Duration(milliseconds: 200));
    });

    test('3件以上は最小・最大を除いた平均', () {
      // 1000ms が外れ値。除去されるので 200ms と 300ms の平均になる。
      final samples = TrimmedMeanSamples()
        ..add(const Duration(milliseconds: 200))
        ..add(const Duration(milliseconds: 1000))
        ..add(const Duration(milliseconds: 100))
        ..add(const Duration(milliseconds: 300));
      expect(samples.value, const Duration(milliseconds: 250));
    });

    test('capacityを超えると古いものから捨てる', () {
      final samples = TrimmedMeanSamples(capacity: 3);
      for (var i = 1; i <= 5; i++) {
        samples.add(Duration(milliseconds: i * 100));
      }
      expect(samples.length, 3);
      // 残るのは 300/400/500ms。最小・最大を除くと 400ms。
      expect(samples.value, const Duration(milliseconds: 400));
    });
  });

  group('KyoshinMonitorTimeSample', () {
    test('往復時間は送信から受信までの差', () {
      final sample = KyoshinMonitorTimeSample(
        sentAt: DateTime.utc(2026, 8, 19, 0, 17, 30),
        receivedAt: DateTime.utc(2026, 8, 19, 0, 17, 30, 400),
        latestTime: DateTime.utc(2026, 8, 19, 0, 17, 29),
      );
      expect(sample.roundTripTime, const Duration(milliseconds: 400));
    });

    test('ずれは送受信の中点で評価され、往復時間の片道ぶんが打ち消される', () {
      // 送信 00:17:30.000 / 受信 00:17:30.400 → 中点 00:17:30.200
      // latest_time が 00:17:29.200 なら、ずれは -1000ms。
      //
      // 受信時刻だけで測ると -1200ms になり、往復時間ぶん過大に見積もる。
      final sample = KyoshinMonitorTimeSample(
        sentAt: DateTime.utc(2026, 8, 19, 0, 17, 30),
        receivedAt: DateTime.utc(2026, 8, 19, 0, 17, 30, 400),
        latestTime: DateTime.utc(2026, 8, 19, 0, 17, 29, 200),
      );
      expect(sample.shift, const Duration(milliseconds: -1000));
    });
  });

  group('KyoshinMonitorPublishDelay.resolve', () {
    // 端末時計が正確なケース。
    test('NTPオフセットが0なら、ずれの符号を反転したものが公開遅延', () {
      expect(
        KyoshinMonitorPublishDelay.resolve(
          shift: const Duration(milliseconds: -1230),
          ntpOffset: Duration.zero,
        ),
        const Duration(milliseconds: 1230),
      );
    });

    // 回帰テスト: 端末時計誤差の二重適用。
    //
    // 修正前は「端末時計基準で測った `deviceNow - latestTime`」を、
    // NTP 補正済みの `AppClock.now()` から引いていたため、端末時計の誤差が
    // 二重に効いていた (端末が30秒進んでいると30秒古い画像を取得していた)。
    group('端末時計が30秒進んでいる場合', () {
      // 真の現在時刻
      final trueNow = DateTime.utc(2026, 8, 19, 0, 17, 31);
      // 端末時計の誤差
      const clockError = Duration(seconds: 30);
      // サーバの公開遅延
      const publishDelay = Duration(seconds: 1);

      final deviceNow = trueNow.add(clockError);
      final latestTime = trueNow.subtract(publishDelay);
      // NTP は端末時計を真の時刻に戻す補正を返す
      final ntpOffset = -clockError;

      final sample = KyoshinMonitorTimeSample(
        sentAt: deviceNow,
        receivedAt: deviceNow,
        latestTime: latestTime,
      );

      test('ずれには端末時計の誤差が含まれる', () {
        expect(sample.shift, -(publishDelay + clockError));
      });

      test('NTPオフセットを差し引くと純粋な公開遅延になる', () {
        expect(
          KyoshinMonitorPublishDelay.resolve(
            shift: sample.shift,
            ntpOffset: ntpOffset,
          ),
          publishDelay,
        );
      });

      test('NTP補正済みの現在時刻から引くと正しい対象時刻になる', () {
        final resolved = KyoshinMonitorPublishDelay.resolve(
          shift: sample.shift,
          ntpOffset: ntpOffset,
        );
        // AppClock は NTP 補正済みなので真の現在時刻を返す
        expect(trueNow.subtract(resolved), latestTime);
      });

      test('NTP未取得時も、端末時計から引けば同じ対象時刻になる', () {
        // このとき AppClock も端末時計にフォールバックするため、
        // 公開遅延に端末時計の誤差が含まれていて整合する。
        final resolved = KyoshinMonitorPublishDelay.resolve(
          shift: sample.shift,
          ntpOffset: null,
        );
        expect(resolved, publishDelay + clockError);
        expect(deviceNow.subtract(resolved), latestTime);
      });

      test('旧実装(端末時計基準の差分をNTP補正済み時刻から引く)は30秒古くなる', () {
        final legacyDelay = deviceNow.difference(latestTime);
        expect(
          trueNow.subtract(legacyDelay),
          latestTime.subtract(clockError),
        );
      });
    });
  });

  group('KyoshinMonitorDelayAdjuster', () {
    const config = KyoshinMonitorDelayAdjustConfig(
      minOffset: Duration(milliseconds: 600),
      maxOffset: Duration(milliseconds: 5000),
      maxAdjustment: Duration(seconds: 5),
    );
    // 秒が0の時刻 (短縮を試すタイミング)
    final onTheMinute = DateTime.utc(2026, 8, 19, 0, 17);
    final midMinute = DateTime.utc(2026, 8, 19, 0, 17, 30);

    test('実測値に補正量を足したものが実効オフセット', () {
      expect(
        KyoshinMonitorDelayAdjuster.effectiveOffset(
          publishDelay: const Duration(milliseconds: 1230),
          adjustment: const Duration(milliseconds: -300),
          config: config,
        ),
        const Duration(milliseconds: 930),
      );
    });

    test('実効オフセットは下限でクランプされる', () {
      expect(
        KyoshinMonitorDelayAdjuster.effectiveOffset(
          publishDelay: const Duration(milliseconds: 1000),
          adjustment: const Duration(milliseconds: -900),
          config: config,
        ),
        config.minOffset,
      );
    });

    test('実効オフセットは上限でクランプされる', () {
      expect(
        KyoshinMonitorDelayAdjuster.effectiveOffset(
          publishDelay: const Duration(milliseconds: 4900),
          adjustment: const Duration(milliseconds: 900),
          config: config,
        ),
        config.maxOffset,
      );
    });

    test('404なら補正量をstepぶん増やす', () {
      expect(
        KyoshinMonitorDelayAdjuster.onFetchFailed(
          adjustment: Duration.zero,
          config: config,
        ),
        config.step,
      );
    });

    test('404が続いても補正量はmaxAdjustmentでクランプされる', () {
      var adjustment = config.maxAdjustment;
      for (var i = 0; i < 3; i++) {
        adjustment = KyoshinMonitorDelayAdjuster.onFetchFailed(
          adjustment: adjustment,
          config: config,
        );
      }
      expect(adjustment, config.maxAdjustment);
    });

    test('成功しても秒が0以外なら補正量は変わらない', () {
      expect(
        KyoshinMonitorDelayAdjuster.onFetchSucceeded(
          adjustment: Duration.zero,
          publishDelay: const Duration(milliseconds: 1230),
          targetTime: midMinute,
          config: config,
        ),
        Duration.zero,
      );
    });

    test('成功して秒が0なら補正量をstepぶん詰める', () {
      expect(
        KyoshinMonitorDelayAdjuster.onFetchSucceeded(
          adjustment: Duration.zero,
          publishDelay: const Duration(milliseconds: 1230),
          targetTime: onTheMinute,
          config: config,
        ),
        -config.step,
      );
    });

    test('すでに下限に達している場合は詰めない', () {
      expect(
        KyoshinMonitorDelayAdjuster.onFetchSucceeded(
          adjustment: const Duration(milliseconds: -900),
          publishDelay: const Duration(milliseconds: 1000),
          targetTime: onTheMinute,
          config: config,
        ),
        const Duration(milliseconds: -900),
      );
    });

    test('実測1.23秒から下限0.6秒まで詰めきると、それ以上は動かない', () {
      // 長周期地震動モニタは実測0.57秒で公開されるため、
      // 強震モニタ基準の1.23秒から詰められる余地がある。
      const publishDelay = Duration(milliseconds: 1230);
      var adjustment = Duration.zero;
      for (var minute = 0; minute < 20; minute++) {
        adjustment = KyoshinMonitorDelayAdjuster.onFetchSucceeded(
          adjustment: adjustment,
          publishDelay: publishDelay,
          targetTime: onTheMinute,
          config: config,
        );
      }
      expect(
        KyoshinMonitorDelayAdjuster.effectiveOffset(
          publishDelay: publishDelay,
          adjustment: adjustment,
          config: config,
        ),
        config.minOffset,
      );
    });
  });
}
