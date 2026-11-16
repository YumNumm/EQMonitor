import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_observation_factory.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/device_shake_detection_frame.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_debug_report.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

part 'shake_detection_debug_report_builder.g.dart';

@riverpod
ShakeDetectionDebugReportBuilder shakeDetectionDebugReportBuilder(Ref ref) =>
    const ShakeDetectionDebugReportBuilder();

class const ShakeDetectionDebugReportBuilder({
  final ShakeObservationFactory observationFactory =
      const ShakeObservationFactory(),
}) {
  /// 未確定のイベントを含むすべてのイベントについて、対象の EEW ごとの
  /// 結合判定の内訳を残す。
  ShakeDetectionDebugReport build({
    required bool isEnabled,
    required DeviceShakeDetectionFrame? frame,
    required List<KyoshinObservationPoint> stations,
    required ShakeEewCorrelator? correlator,
    required List<CorrelationEew> eews,
  }) {
    final candidateEews = [
      for (final eew in eews)
        if (!eew.isCancel) eew,
    ];
    return ShakeDetectionDebugReport(
      isEnabled: isEnabled,
      observedAt: frame?.observedAt,
      coldStartAt: frame?.status?.coldStartAt,
      baselineFrameCount: frame?.status?.baselineFrameCount,
      isHistoryRebuilt: frame?.isHistoryRebuilt ?? false,
      isCorrelatorReady: correlator != null,
      eewCount: candidateEews.length,
      events: [
        for (final snapshot in frame?.events ?? const [])
          () {
            if (correlator == null) {
              return ShakeDetectionDebugEvent(
                snapshot: snapshot,
                candidates: const [],
                correlatedEewEventId: null,
              );
            }
            final observation = observationFactory.create(
              snapshot: snapshot,
              stations: stations,
            );
            final candidates = [
              for (final eew in candidateEews)
                correlator.check(eew: eew, shake: observation),
            ];
            return ShakeDetectionDebugEvent(
              snapshot: snapshot,
              candidates: candidates,
              correlatedEewEventId: correlator
                  .selectBest(candidates)
                  ?.eewEventId,
            );
          }(),
      ],
    );
  }
}
