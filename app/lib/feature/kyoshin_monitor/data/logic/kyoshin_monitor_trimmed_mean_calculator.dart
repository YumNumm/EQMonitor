import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_trimmed_mean_calculator.g.dart';

@riverpod
KyoshinMonitorTrimmedMeanCalculator kyoshinMonitorTrimmedMeanCalculator(
  Ref ref,
) => const KyoshinMonitorTrimmedMeanCalculator();

/// 直近 [capacity] 件を保持し、最小値と最大値を除いた平均を返す。
///
/// 単一サンプルだと 1 回の通信ゆらぎが次の再同期まで残り続けてしまうため、
/// 外れ値を落としてから平均する。長周期地震動モニタの公式フロントエンドが
/// 往復時間とサーバ時刻のずれに対して行っているのと同じ処理。
class KyoshinMonitorTrimmedMeanCalculator {
  const new();

  static const defaultCapacity = 5;

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

  /// 3 件以上ある場合は最小・最大を除いた平均、それ未満は単純平均を返す。
  ///
  /// サンプルが無い場合は null。
  Duration? mean(List<Duration> samples) {
    if (samples.isEmpty) {
      return null;
    }
    final sorted = [...samples]..sort();
    final target = sorted.length >= 3
        ? sorted.sublist(1, sorted.length - 1)
        : sorted;
    final total = target.fold<int>(
      0,
      (sum, duration) => sum + duration.inMicroseconds,
    );
    return Duration(microseconds: total ~/ target.length);
  }
}
