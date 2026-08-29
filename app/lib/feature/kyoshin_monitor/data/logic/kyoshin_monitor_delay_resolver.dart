import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_delay_resolver.g.dart';

@riverpod
KyoshinMonitorDelayResolver kyoshinMonitorDelayResolver(Ref ref) =>
    const KyoshinMonitorDelayResolver();

/// `latest.json` で測った公開遅延を、画像取得の 404 を手がかりに詰めていくロジック。
///
/// `latest.json` の `latest_time` は 1 秒粒度で、かつ実際の画像公開より
/// 保守的に遅れている (実測: 長周期地震動モニタは画像が 0.57 秒で公開されるのに
/// `latest_time` は約 1 秒遅れ)。そのぶんをここで取り戻す。
///
/// 補正は公開遅延そのものではなく「測定値からの差分」として保持する。
/// こうすることで、`latest.json` の再同期が端末時計のドリフトやサーバ側の
/// 遅延変動を追従し続ける一方で、学習した詰めぶんは維持される。
class KyoshinMonitorDelayResolver {
  const new();

  /// 画像取得に使う公開遅延。
  Duration imageDelay({
    required Duration publishDelay,
    required Duration adjustment,
    required KyoshinMonitorDelayAdjustConfig config,
  }) => clamp(
    value: publishDelay + adjustment,
    min: config.minOffset,
    max: config.maxOffset,
  );

  /// 画像が未公開 (404) だったときの補正量。
  ///
  /// 取得対象が新しすぎるということなので、より過去を見るように増やす。
  Duration onFetchFailed({
    required Duration adjustment,
    required KyoshinMonitorDelayAdjustConfig config,
  }) => clamp(
    value: adjustment + config.step,
    min: -config.maxAdjustment,
    max: config.maxAdjustment,
  );

  /// 取得に成功したときの補正量。
  ///
  /// 毎ティック詰めると 404 と往復して発振するため、
  /// KyoshinEewViewer と同じく毎分 1 回だけ試す。
  Duration onFetchSucceeded({
    required Duration adjustment,
    required Duration publishDelay,
    required DateTime targetTime,
    required KyoshinMonitorDelayAdjustConfig config,
  }) {
    if (targetTime.second != 0) {
      return adjustment;
    }
    final current = imageDelay(
      publishDelay: publishDelay,
      adjustment: adjustment,
      config: config,
    );
    if (current <= config.minOffset) {
      return adjustment;
    }
    return clamp(
      value: adjustment - config.step,
      min: -config.maxAdjustment,
      max: config.maxAdjustment,
    );
  }

  Map<KyoshinMonitorDelayProfile, Duration> setAdjustment({
    required Map<KyoshinMonitorDelayProfile, Duration> adjustments,
    required KyoshinMonitorDelayProfile profile,
    required Duration adjustment,
    required KyoshinMonitorDelayAdjustConfig config,
  }) {
    final clamped = clamp(
      value: adjustment,
      min: -config.maxAdjustment,
      max: config.maxAdjustment,
    );
    return {...adjustments, profile: clamped};
  }

  Map<KyoshinMonitorDelayProfile, Duration> resetAdjustment({
    required Map<KyoshinMonitorDelayProfile, Duration> adjustments,
    required KyoshinMonitorDelayProfile profile,
  }) => Map.of(adjustments)..remove(profile);

  Duration clamp({
    required Duration value,
    required Duration min,
    required Duration max,
  }) {
    if (value < min) {
      return min;
    }
    if (value > max) {
      return max;
    }
    return value;
  }
}
