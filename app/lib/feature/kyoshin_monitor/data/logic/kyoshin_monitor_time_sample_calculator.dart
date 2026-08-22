import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_time_sample.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_time_sample_calculator.g.dart';

@riverpod
KyoshinMonitorTimeSampleCalculator kyoshinMonitorTimeSampleCalculator(Ref ref) =>
    const KyoshinMonitorTimeSampleCalculator();

class KyoshinMonitorTimeSampleCalculator {
  const new();

  Duration roundTripTime(KyoshinMonitorTimeSample sample) =>
      sample.receivedAt.difference(sample.sentAt);

  /// 端末時計から見た `latest_time` のずれ。
  ///
  /// 送受信の中点で評価することで、往復時間の片道ぶんを打ち消す。
  /// 通常は負の値 (サーバの最新データは端末の現在時刻より過去) になる。
  Duration shift(KyoshinMonitorTimeSample sample) {
    final roundTrip = roundTripTime(sample);
    final midpoint = sample.sentAt.add(
      Duration(microseconds: roundTrip.inMicroseconds ~/ 2),
    );
    return sample.latestTime.difference(midpoint);
  }

  /// サーバの公開遅延。
  ///
  /// [shift] は「端末時計から見た `latest_time` のずれ」なので、端末時計自体の
  /// 誤差を含んでいる。NTP 補正が得られている場合は [ntpOffset] を差し引くことで、
  /// 端末時計の誤差に依存しない純粋な公開遅延が得られる。
  ///
  /// 端末時計の誤差を `D` (`deviceNow == trueNow + D`)、公開遅延を `P` とすると
  ///
  /// - `shift == -P - D`
  /// - `ntpOffset == -D`
  /// - `-(shift - ntpOffset) == P`
  ///
  /// NTP 未取得時 ([ntpOffset] が null) は `P + D` が返るが、その場合の
  /// `AppClock.now()` も端末時計 (`trueNow + D`) なので、
  /// `AppClock.now() - publishDelay == trueNow - P` となり結果は一致する。
  Duration publishDelay({
    required Duration shift,
    required Duration? ntpOffset,
  }) => -(shift - (ntpOffset ?? Duration.zero));
}
