import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_delay.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_delay_edge_search.g.dart';

@riverpod
KyoshinMonitorDelayEdgeSearch kyoshinMonitorDelayEdgeSearch(Ref ref) =>
    const KyoshinMonitorDelayEdgeSearch();

/// 画像が公開される境目の遅延を二分探索で求めるロジック。
///
/// 「対象時刻から [KyoshinMonitorDelayEdgeBracket.upper] だけ遅らせて取得すれば
/// 成功する」「[KyoshinMonitorDelayEdgeBracket.lower] では早すぎる」という区間を、
/// 取得結果 (200 / 404) で半分ずつ狭めていく。
/// 404 のたびに 100ms ずつ動かす方式に比べ、数回の試行で収束する。
class const KyoshinMonitorDelayEdgeSearch() {
  /// 現在の遅延から下方向へ探す幅。
  ///
  /// `latest.json` の 1 秒粒度ぶんと、パイプライン間の公開遅延差を覆う。
  static const defaultSpan = Duration(milliseconds: 1500);

  /// 上限が 404 だった場合に上へ広げる幅
  static const defaultExpandStep = Duration(milliseconds: 500);

  /// 収束とみなす区間幅
  static const defaultResolution = Duration(milliseconds: 50);

  KyoshinMonitorDelayEdgeBracket start({
    required Duration currentDelay,
    required KyoshinMonitorDelayAdjustConfig config,
    Duration span = defaultSpan,
  }) {
    final upper = clamp(currentDelay, config.minOffset, config.maxOffset);
    final lower = clamp(upper - span, config.minOffset, config.maxOffset);
    return KyoshinMonitorDelayEdgeBracket(
      lower: lower,
      upper: upper,
      isUpperVerified: false,
    );
  }

  /// 次に試す遅延。
  ///
  /// まず上限で取得できることを確かめ、その後は区間の中点を試す。
  Duration nextProbe(KyoshinMonitorDelayEdgeBracket bracket) =>
      bracket.isUpperVerified
      ? Duration(
          microseconds:
              (bracket.lower.inMicroseconds + bracket.upper.inMicroseconds) ~/
              2,
        )
      : bracket.upper;

  /// [nextProbe] の遅延で取得した結果を反映する。
  KyoshinMonitorDelayEdgeBracket onProbed({
    required KyoshinMonitorDelayEdgeBracket bracket,
    required bool isPublished,
    required KyoshinMonitorDelayAdjustConfig config,
    Duration expandStep = defaultExpandStep,
  }) {
    final probe = nextProbe(bracket);
    if (bracket.isUpperVerified) {
      return isPublished
          ? bracket.copyWith(upper: probe)
          : bracket.copyWith(lower: probe);
    }
    if (isPublished) {
      return bracket.copyWith(isUpperVerified: true);
    }
    // 上限でも未公開だった。区間ごと上へずらす。
    return bracket.copyWith(
      lower: probe,
      upper: clamp(probe + expandStep, config.minOffset, config.maxOffset),
    );
  }

  /// 公開の境目を十分な精度で挟めたか。
  bool isConverged(
    KyoshinMonitorDelayEdgeBracket bracket, {
    Duration resolution = defaultResolution,
  }) => bracket.isUpperVerified && bracket.upper - bracket.lower <= resolution;

  /// 上限まで広げても公開済みの遅延が見つからなかったか。
  bool isExhausted(
    KyoshinMonitorDelayEdgeBracket bracket, {
    required KyoshinMonitorDelayAdjustConfig config,
  }) => !bracket.isUpperVerified && bracket.lower >= config.maxOffset;

  Duration clamp(Duration value, Duration min, Duration max) {
    if (value < min) {
      return min;
    }
    if (value > max) {
      return max;
    }
    return value;
  }
}
