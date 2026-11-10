import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_delay_edge_search.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_time_sync_estimator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('KyoshinMonitorTimeSyncEstimator', () {
    const estimator = KyoshinMonitorTimeSyncEstimator();

    test('サンプルが無い場合はnull', () {
      expect(estimator.shift(const []), isNull);
    });

    test('1件でもその値を使う', () {
      expect(
        estimator.shift(const [Duration(milliseconds: -1800)]),
        const Duration(milliseconds: -1800),
      );
    });

    test('遅延が最小のサンプル (shiftが最大) を採用する', () {
      expect(
        estimator.shift(const [
          Duration(milliseconds: -1800),
          Duration(milliseconds: -1050),
          Duration(milliseconds: -1300),
        ]),
        const Duration(milliseconds: -1050),
      );
    });

    test('1秒粒度の範囲に収まるサンプルは矛盾しない', () {
      const estimate = Duration(milliseconds: -1050);
      for (final sample in const [
        Duration(milliseconds: -1050),
        Duration(milliseconds: -2000),
        Duration(milliseconds: -900),
        Duration(milliseconds: -2300),
      ]) {
        expect(
          estimator.isConsistent(estimate: estimate, sampleShift: sample),
          isTrue,
          reason: '$sample',
        );
      }
    });

    test('端末時計が動いた場合は矛盾として検出する', () {
      const estimate = Duration(milliseconds: -1050);
      expect(
        estimator.isConsistent(
          estimate: estimate,
          sampleShift: const Duration(milliseconds: -31050),
        ),
        isFalse,
      );
      expect(
        estimator.isConsistent(
          estimate: estimate,
          sampleShift: const Duration(milliseconds: -500),
        ),
        isFalse,
      );
    });
  });

  group('KyoshinMonitorDelayEdgeSearch', () {
    const search = KyoshinMonitorDelayEdgeSearch();
    const config = KyoshinMonitorDelayAdjustConfig(
      minOffset: Duration(milliseconds: 600),
      maxOffset: Duration(milliseconds: 5000),
    );

    // 真の公開の境目が edge のとき、収束までの試行を再現する。
    ({KyoshinMonitorDelayEdgeBracket bracket, int probes}) run({
      required Duration currentDelay,
      required Duration edge,
    }) {
      var bracket = search.start(currentDelay: currentDelay, config: config);
      var probes = 0;
      while (!search.isConverged(bracket) &&
          !search.isExhausted(bracket, config: config) &&
          probes < 30) {
        final probe = search.nextProbe(bracket);
        bracket = search.onProbed(
          bracket: bracket,
          isPublished: probe >= edge,
          config: config,
        );
        probes++;
      }
      return (bracket: bracket, probes: probes);
    }

    test('最初に現在の遅延で取得できることを確かめる', () {
      final bracket = search.start(
        currentDelay: const Duration(milliseconds: 1800),
        config: config,
      );
      expect(search.nextProbe(bracket), const Duration(milliseconds: 1800));
      expect(bracket.lower, const Duration(milliseconds: 600));
    });

    test('数回の試行で公開の境目の直上に収束する', () {
      const edge = Duration(milliseconds: 1230);
      final result = run(
        currentDelay: const Duration(milliseconds: 1900),
        edge: edge,
      );
      expect(search.isConverged(result.bracket), isTrue);
      expect(result.bracket.upper, greaterThanOrEqualTo(edge));
      expect(
        result.bracket.upper - edge,
        lessThanOrEqualTo(KyoshinMonitorDelayEdgeSearch.defaultResolution),
      );
      expect(result.probes, lessThanOrEqualTo(7));
    });

    test('現在の遅延で404なら上へ広げてから収束する', () {
      const edge = Duration(milliseconds: 1230);
      final result = run(
        currentDelay: const Duration(milliseconds: 1000),
        edge: edge,
      );
      expect(search.isConverged(result.bracket), isTrue);
      expect(result.bracket.upper, greaterThanOrEqualTo(edge));
      expect(
        result.bracket.upper - edge,
        lessThanOrEqualTo(KyoshinMonitorDelayEdgeSearch.defaultResolution),
      );
    });

    test('下限より短い遅延は試さない', () {
      final result = run(
        currentDelay: const Duration(milliseconds: 900),
        edge: const Duration(milliseconds: 100),
      );
      expect(search.isConverged(result.bracket), isTrue);
      expect(result.bracket.upper, greaterThanOrEqualTo(config.minOffset));
    });

    test('上限まで広げても取得できなければ打ち切る', () {
      final result = run(
        currentDelay: const Duration(milliseconds: 4000),
        edge: const Duration(seconds: 30),
      );
      expect(search.isConverged(result.bracket), isFalse);
      expect(search.isExhausted(result.bracket, config: config), isTrue);
    });
  });
}
