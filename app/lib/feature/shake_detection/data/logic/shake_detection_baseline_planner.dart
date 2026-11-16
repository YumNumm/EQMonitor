import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';

part 'shake_detection_baseline_planner.g.dart';

@riverpod
ShakeDetectionBaselinePlanner shakeDetectionBaselinePlanner(Ref ref) =>
    const ShakeDetectionBaselinePlanner();

class const ShakeDetectionBaselinePlanner({
  final List<Duration> lookbacks = const [
    Duration(seconds: 30),
    Duration(seconds: 90),
    Duration(seconds: 180),
  ],
}) {
  /// 検知の履歴が [target] まで連続していない場合に、平常値として取得する
  /// 過去フレームの時刻を返す。連続している場合は `null`。
  List<DateTime>? plan({
    required DateTime? previous,
    required DateTime target,
  }) {
    if (previous != null &&
        target.difference(previous).abs() <
            ShakeDetectionEngine.discontinuityThreshold) {
      return null;
    }
    return [for (final lookback in lookbacks) target.subtract(lookback)];
  }
}
