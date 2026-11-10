import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_time_sync_estimator.g.dart';

@riverpod
KyoshinMonitorTimeSyncEstimator kyoshinMonitorTimeSyncEstimator(Ref ref) =>
    const KyoshinMonitorTimeSyncEstimator();

/// `latest.json` のサンプル群から、端末時計に対するサーバ時刻のずれを見積もる。
///
/// `latest_time` は 1 秒粒度で切り捨てられているため、1 回の測定で得られる
/// 遅延 (`-shift`) は真の遅延 `P` に対して `[P, P + 1秒)` のどこかになる。
/// どのサンプルも「その遅延なら公開済みだった」という実績なので、
/// 平均ではなく最小の遅延 (= 最大の shift) が最も真値に近く、かつ安全側の値になる。
class const KyoshinMonitorTimeSyncEstimator() {
  /// `latest_time` の粒度
  static const quantum = Duration(seconds: 1);

  /// 通信ゆらぎとして許容する幅
  static const defaultTolerance = Duration(milliseconds: 300);

  /// 保持するサンプル数
  static const defaultCapacity = 5;

  /// 直近 [capacity] 件だけを残してサンプルを追加する。
  List<Duration> append({
    required List<Duration> samples,
    required Duration value,
    int capacity = defaultCapacity,
  }) {
    final next = [...samples, value];
    if (next.length <= capacity) {
      return next;
    }
    return next.sublist(next.length - capacity);
  }

  /// 往復時間の代表値 (中央値)。診断表示用。サンプルが無い場合は null。
  Duration? roundTripTime(List<Duration> roundTripTimes) {
    if (roundTripTimes.isEmpty) {
      return null;
    }
    final sorted = [...roundTripTimes]..sort();
    return sorted[sorted.length ~/ 2];
  }

  /// サンプル群から求めたずれ。サンプルが無い場合は null。
  Duration? shift(List<Duration> shifts) {
    if (shifts.isEmpty) {
      return null;
    }
    return shifts.reduce((a, b) => a > b ? a : b);
  }

  /// 新しいサンプルが現在の見積もりと矛盾しないか。
  ///
  /// 見積もりが真値に近ければ、新しいサンプルの shift は
  /// `[estimate - 1秒, estimate]` に収まる。外れた場合は端末時計の変更や
  /// サーバ側の遅延変動が起きているため、測り直す必要がある。
  bool isConsistent({
    required Duration estimate,
    required Duration sampleShift,
    Duration tolerance = defaultTolerance,
  }) =>
      sampleShift <= estimate + tolerance &&
      sampleShift >= estimate - quantum - tolerance;
}
