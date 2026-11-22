import 'dart:typed_data';

import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_baseline_planner.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_settings_model.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_tuning.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_shake_detection_planner.g.dart';

@riverpod
ReplayShakeDetectionPlanner replayShakeDetectionPlanner(Ref ref) =>
    ReplayShakeDetectionPlanner(
      baselinePlanner: ref.watch(shakeDetectionBaselinePlannerProvider),
    );

final class const ReplayShakeDetectionPlan({
  required final ShakeDetectionRequest request,

  /// 検知の履歴を作り直す要求。履歴が連続している場合や、直前の画像が
  /// 無い場合は `null`。
  required final ShakeBackfillRequest? backfill,
});

class const ReplayShakeDetectionPlanner({
  required final ShakeDetectionBaselinePlanner baselinePlanner,
}) {
  List<DateTime> requiredTimes({
    required DateTime observedAt,
    required DateTime? previousObservedAt,
    required ShakeDetectionSettingsModel settings,
    required ShakeDetectionTuning tuning,
  }) {
    final baselineTimes = settings.isEnabled
        ? baselinePlanner.plan(previous: previousObservedAt, target: observedAt)
        : null;
    return baselineTimes == null
        ? const []
        : [
            ...baselineTimes,
            if (settings.isBackfillEnabled)
              for (var second = 1; second <= tuning.backfillSeconds; second++)
                observedAt.subtract(Duration(seconds: second)),
          ];
  }

  /// [observedAt] の再生画像に対する揺れ検知の要求を作る。
  ///
  /// 平常値と履歴の作り直しには、ライブ取得の代わりに [images] の同時刻の
  /// 画像を使う。揺れ検知が無効な場合は `null` を返す。
  ReplayShakeDetectionPlan? plan({
    required Map<DateTime, Uint8List> images,
    required DateTime observedAt,
    required DateTime? previousObservedAt,
    required ShakeDetectionSettingsModel settings,
    required ShakeDetectionTuning tuning,
  }) {
    if (!settings.isEnabled) {
      return null;
    }
    final baselineTimes = baselinePlanner.plan(
      previous: previousObservedAt,
      target: observedAt,
    );
    final backfillFrames = baselineTimes == null || !settings.isBackfillEnabled
        ? const <ShakeBackfillFrame>[]
        : [
            for (var second = 1; second <= tuning.backfillSeconds; second++)
              if (observedAt.subtract(Duration(seconds: second))
                  case final time)
                if (images[time] case final gif?)
                  ShakeBackfillFrame(observedAt: time, gif: gif),
          ];
    return ReplayShakeDetectionPlan(
      request: ShakeDetectionRequest(
        observedAt: observedAt,
        baselineGifs: baselineTimes == null
            ? null
            : [for (final time in baselineTimes) ?images[time]],
        fallbackBaseline: tuning.fallbackBaseline,
        parameters: tuning.parameters,
      ),
      backfill: backfillFrames.isEmpty
          ? null
          : ShakeBackfillRequest(
              coldStartAt: observedAt,
              frames: backfillFrames,
            ),
    );
  }
}
